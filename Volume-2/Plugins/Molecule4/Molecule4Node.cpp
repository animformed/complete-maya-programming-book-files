//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#include "Molecule4Node.h"
#include <maya/MFnMeshData.h>
#include <maya/MFnMesh.h>
#include <maya/MFnUnitAttribute.h>
#include <maya/MFnNumericAttribute.h>
#include <maya/MFnTypedAttribute.h>
#include <maya/MGlobal.h>
#include <maya/MItMeshEdge.h>
#include <maya/MMatrix.h>
#include <maya/MDistance.h>
#include "MoleculeUtils.h"

MTypeId Molecule4Node::id( 0x00337 );

MObject Molecule4Node::radius;
MObject Molecule4Node::segments;
MObject Molecule4Node::ballRatio;
MObject Molecule4Node::inMesh;
MObject Molecule4Node::outMesh;

MStatus Molecule4Node::compute( const MPlug &plug, MDataBlock &data )
{
	MStatus stat;
	 
	MDataHandle stateHnd = data.inputValue( state );
	int state = stateHnd.asInt();
	if( state == 1 ) // No Effect/Pass through
	{
		MDataHandle inMeshHnd = data.inputValue( inMesh );
		MDataHandle outMeshHnd = data.outputValue( outMesh );

		outMeshHnd.set( inMeshHnd.asMesh() );
		data.setClean( plug );

		return MS::kSuccess;
	}
		
	if( plug == outMesh )
		{
		MDataHandle radiusHnd = data.inputValue( radius );
		MDataHandle segmentsHnd = data.inputValue( segments );
		MDataHandle ballRatioHnd = data.inputValue( ballRatio );
		MDataHandle inMeshHnd = data.inputValue( inMesh );
		MDataHandle outMeshHnd = data.outputValue( outMesh );
		
		double radius = radiusHnd.asDouble(); // Convert from MDistance to double
		int segs = segmentsHnd.asInt();
		double ballRatio = ballRatioHnd.asDouble();
				
		MObject inMeshObj = inMeshHnd.asMeshTransformed();
		MFnMesh inMeshFn( inMeshObj );
		
		MFnMeshData meshDataFn;
		MObject newMeshData = meshDataFn.create();
		
		// Create a ball
		int nBallPolys;
		MPointArray ballVerts;
		MIntArray ballPolyCounts;
		MIntArray ballPolyConnects;
		MFloatArray ballUCoords;
		MFloatArray ballVCoords;
		MIntArray ballFvUVIDs;
		genBall( MPoint::origin, ballRatio * radius, segs, nBallPolys, 
				ballVerts, ballPolyCounts, ballPolyConnects,
				true, ballUCoords, ballVCoords, ballFvUVIDs );

		unsigned int i, j, vertOffset;
		MPointArray meshVerts;
		MPoint p0, p1;
		
		// Setup for rods
		int nRodPolys;
		MPointArray rodVerts;
		MIntArray rodPolyCounts;
		MIntArray rodPolyConnects;
		MFloatArray rodUCoords;
		MFloatArray rodVCoords;
		MIntArray rodFvUVIDs;
		
		// Setup for newMesh
		int nNewPolys;
		MPointArray newVerts;
		MIntArray newPolyCounts;
		MIntArray newPolyConnects;
		MFloatArray newUCoords;
		MFloatArray newVCoords;
		MIntArray newFvUVIDs;
	
		int uvOffset; 
				
		uvOffset = 0;
		nNewPolys = 0;
		newVerts.clear();
		newPolyCounts.clear();
		newPolyConnects.clear();
		newUCoords.clear();
		newVCoords.clear();
		newFvUVIDs.clear();
		
		// Generate balls
		inMeshFn.getPoints( meshVerts, MSpace::kWorld );
		for( i=0; i < meshVerts.length(); i++ )
		{
			vertOffset = newVerts.length();
			
			// Add the ball to the new mesh
			nNewPolys += nBallPolys;
			
			// Move the ball vertices to the mesh vertex. Add it to the newMesh
			for( j=0; j < ballVerts.length(); j++ )
				newVerts.append( meshVerts[i] + ballVerts[j] );
				
			for( j=0; j < ballPolyCounts.length(); j++ )
				newPolyCounts.append( ballPolyCounts[j] );
				
			for( j=0; j < ballPolyConnects.length(); j++ )
				newPolyConnects.append( vertOffset + ballPolyConnects[j] );
		
			// Only add the uv coordinates once, since they are shared
			// by all balls
			if( i == 0 )
			{
				for( j=0; j < ballUCoords.length(); j++ )
				{
					newUCoords.append( ballUCoords[j] );
					newVCoords.append( ballVCoords[j] );
				}				
			}
			
			for( j=0; j < ballFvUVIDs.length(); j++ )
			{
				newFvUVIDs.append( uvOffset + ballFvUVIDs[j] );
			}
		}
		
		uvOffset = newUCoords.length();
		
		// Generate rods
		int nRods = 0;
		MItMeshEdge edgeIter( inMeshObj );
		for( ; !edgeIter.isDone(); edgeIter.next(), nRods++  )
		{	
			p0 = edgeIter.point( 0, MSpace::kWorld );		
			p1 = edgeIter.point( 1, MSpace::kWorld );
			
			// N.B. Generate the uv coordinates only once since they
			// are referenced by all rods
			genRod( p0, p1, 
					radius, segs, nRodPolys, 
					rodVerts, rodPolyCounts, rodPolyConnects,
					nRods == 0,	rodUCoords, rodVCoords,
					rodFvUVIDs ); 

			vertOffset = newVerts.length();
			
			// Add the rod to the mesh
			nNewPolys += nRodPolys;
			
			for( i=0; i < rodVerts.length(); i++ )
				newVerts.append( rodVerts[i] );
				
			for( i=0; i < rodPolyCounts.length(); i++ )
				newPolyCounts.append( rodPolyCounts[i] );
				
			for( i=0; i < rodPolyConnects.length(); i++ )
				newPolyConnects.append( vertOffset + rodPolyConnects[i] );

			// First rod
			if( nRods == 0 )
			{
				// Add rod's uv coordinates to the list
				for( i=0; i < rodUCoords.length(); i++ )
				{
					newUCoords.append( rodUCoords[i] );
					newVCoords.append( rodVCoords[i] );
				}
			}
			
			// Set the face-vertex-uvIDs
			for( i=0; i < rodFvUVIDs.length(); i++ )
			{
				newFvUVIDs.append( uvOffset + rodFvUVIDs[i] );
			}
		}
		
		// N.B. Use newMeshData as the parentOrOwner parameter
		MFnMesh meshFn;
		meshFn.create( newVerts.length(), nNewPolys, newVerts, 
					   newPolyCounts, newPolyConnects,
					   newUCoords, newVCoords, 
					   newMeshData, &stat );
		if( !stat )
		{
			MGlobal::displayError( MString( "Unable to create mesh: " ) + stat.errorString() );
			return stat;
		}	
						
		meshFn.assignUVs( newPolyCounts, newFvUVIDs );		
		meshFn.updateSurface();		
				
		outMeshHnd.set( newMeshData );
		
		data.setClean( plug );
		} 
	else 
		stat  = MS::kUnknownParameter;

	return stat;
}

void *Molecule4Node::creator()
{
	return new Molecule4Node();
}

MStatus Molecule4Node::initialize()
{
	MFnUnitAttribute uAttr;
	MFnNumericAttribute nAttr;
	MFnTypedAttribute tAttr;
	
	radius = uAttr.create( "radius", "rad", MFnUnitAttribute::kDistance, 0.1 );
	uAttr.setKeyable( true );
	
	segments = nAttr.create( "segments", "seg", MFnNumericData::kLong, 6 );
	nAttr.setKeyable( true );
	
	ballRatio = nAttr.create( "ballRatio", "br", MFnNumericData::kDouble, 2.0 );
	nAttr.setKeyable( true );
	
	inMesh = tAttr.create( "inMesh", "im", MFnData::kMesh );
	
	outMesh = tAttr.create( "outMesh", "om", MFnData::kMesh );
	tAttr.setStorable( false );
	
	addAttribute( radius );
	addAttribute( segments );
	addAttribute( ballRatio );
	addAttribute( inMesh );
	addAttribute( outMesh );
	
	attributeAffects( radius, outMesh );
	attributeAffects( segments, outMesh );
	attributeAffects( ballRatio, outMesh );
	attributeAffects( inMesh, outMesh );

	return MS::kSuccess;
}

MDistance Molecule4Node::radiusDefault()
{
	MFnUnitAttribute uAttr( radius );
	MDistance d;
	uAttr.getDefault( d );
	return d;	
}

int Molecule4Node::segmentsDefault()
{
	MFnNumericAttribute nAttr( segments );
	int d;
	nAttr.getDefault( d );
	return d;
}

double Molecule4Node::ballRatioDefault()
{
	MFnNumericAttribute nAttr( ballRatio );
	double d;
	nAttr.getDefault( d );
	return d;
}
