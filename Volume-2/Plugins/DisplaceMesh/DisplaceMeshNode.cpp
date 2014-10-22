//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#include "DisplaceMeshNode.h"
#include <maya/MFnMeshData.h>
#include <maya/MFnMesh.h>
#include <maya/MFnUnitAttribute.h>
#include <maya/MFnNumericAttribute.h>
#include <maya/MGlobal.h>
#include <maya/MItMeshEdge.h>
#include <maya/MMatrix.h>
#include <maya/MDistance.h>
#include <maya/MPointArray.h>
#include <maya/MFloatArray.h>
#include <maya/MFnUnitAttribute.h>
#include <maya/MFnTypedAttribute.h>
#include <maya/MItMeshFaceVertex.h>
#include <maya/MFnStringData.h>
#include <maya/MImage.h>

MTypeId DisplaceMeshNode::id( 0x00338 );

MObject DisplaceMeshNode::strength;
MObject DisplaceMeshNode::imageFilename;

MStatus DisplaceMeshNode::compute( const MPlug &plug, MDataBlock &data )
{
	MStatus stat;
	bool hasNoEffect = false;
	
	MDataHandle inMeshHnd = data.inputValue( inMesh );
	MDataHandle outMeshHnd = data.outputValue( outMesh );
	 
	MDataHandle stateHnd = data.inputValue( state );
	int state = stateHnd.asInt();
	if( state == 1 ) // No Effect/Pass through
		hasNoEffect = true;
		
	if( !hasNoEffect && plug == outMesh )
	{
	    MObject inMeshData = inMeshHnd.asMesh();
	    MDataHandle strengthHnd = data.inputValue( strength );
		MDataHandle imageFilenameHnd = data.inputValue( imageFilename );
    
		double strengthValue = strengthHnd.asDouble();
		MString imageFilenameStr = imageFilenameHnd.asString();
		
		hasNoEffect = strengthValue == 0.0 || imageFilenameStr.length() == 0;
		
		MImage image;
		if( !hasNoEffect )
			hasNoEffect = !image.readFromFile( imageFilenameStr );
		
		if( !hasNoEffect )
		{
			MFnMeshData meshDataFn;
			MObject newMeshData = meshDataFn.create();
			MFnMesh inMeshFn( inMeshData );
			inMeshFn.copy( inMeshData, newMeshData );

			unsigned int width, height;
			image.getSize( width, height );
			
			unsigned char *pixs = image.pixels();
			unsigned int depth = image.depth();
			
			MFnMesh meshFn( newMeshData );
			MPointArray pts;
			meshFn.getPoints( pts );

			const unsigned int nPts = pts.length();
			bool *visited = new bool[ nPts ];
			unsigned int i;
			for( i=0; i < nPts; i++ )
				visited[i] = false;

			float2 uv;
			int vertId;
			MVector norm;
			double lum;
			int x, y;
			unsigned char *pix;
					
			MItMeshFaceVertex fvIter( newMeshData );
			for( ; !fvIter.isDone(); fvIter.next() )			
			{
				vertId = fvIter.vertId();
				
				if( visited[ vertId ] )
					continue;
			
				if( !fvIter.hasUVs() )
					continue;
			
				// Get the UV coordinate
				fvIter.getUV( uv );
				
				// Given a UV coordinate determine the x, y coordinate
				x = int( uv[0] * (width-1) );
				y = int( uv[1] * (height-1) );		
				
				// Get the pixel at the given x,y coordinate
				pix = pixs + (y * width * depth) + x * depth;
			
				// Calculate luminance
				if( depth >= 3 )
					lum = 0.29 * *pix + 0.59 * *(pix+1) + 0.12 * *(pix+2);
				else
					lum = *pix;
				lum /= 255.0; // Scale to [0,1]
				
				// Get "average" normal by averaging the geometric normals for the surrounding faces
				meshFn.getVertexNormal( vertId, norm );
				
				// Displace point
				pts[ vertId ] += strengthValue * lum * norm;
				
				// Tag vertex as having been visited
				visited[ vertId ] = true;
			}
			
			delete[] visited;
			
			meshFn.setPoints( pts );
			meshFn.updateSurface();	

			outMeshHnd.set( newMeshData );
		}	
	}
	else 
		return MS::kUnknownParameter;

	if( hasNoEffect )
		outMeshHnd.set( inMeshHnd.asMesh() );
	
	data.setClean( plug );

	return stat;
}

void *DisplaceMeshNode::creator()
{
	return new DisplaceMeshNode();
}

MStatus DisplaceMeshNode::initialize()
{
	// Call super class's initialize function to setup
	// inMesh and outMesh attributes
	//
	CmpMeshModifierNode::initialize();
	
	// Create and initialize custom attributes
	//
	MFnNumericAttribute nAttr;
	strength = nAttr.create( "strength", "str", MFnNumericData::kDouble, 1.0 );
	nAttr.setKeyable( true );

	MFnTypedAttribute tAttr;
	imageFilename = tAttr.create( "imageFilename", "img", MFnData::kString );

	addAttribute( strength );
	addAttribute( imageFilename );

	attributeAffects( strength, outMesh );
	attributeAffects( imageFilename, outMesh );
	
	return MS::kSuccess;
}

double DisplaceMeshNode::strengthDefault()	
{
	MFnNumericAttribute nAttr( strength );
	double d;
	nAttr.getDefault( d );
	return d;
}

MString DisplaceMeshNode::imageFilenameDefault()
{
	MFnTypedAttribute tAttr;
	MObject d;
	tAttr.getDefault( d );
	MFnStringData sd( d );
	return sd.string();	
}

