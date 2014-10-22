//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#include <maya/MSimple.h>
#include <maya/MGlobal.h>
#include <maya/MItSelectionList.h>
#include <maya/MItMeshVertex.h>
#include <maya/MFnMesh.h>
#include <maya/MDagPath.h>

DeclareSimpleCommand( meshInfo6, "David Gould", "1.0" );

MStatus meshInfo6::doIt( const MArgList& args )
{
	MStatus stat = MS::kSuccess;

	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	MDagPath dagPath;
	MObject component;
	
	unsigned int i;
	int fIndex, vIndex;
	
	MString txt;
	MItSelectionList iter( selection );
	for ( ; !iter.isDone(); iter.next() )
	{								
		iter.getDagPath( dagPath, component );
		
		MFnMesh meshFn( dagPath, &stat );
		if( !stat )
			continue;
			
		txt += MString( "Object: " ) + dagPath.fullPathName() + "\n";	

		MStringArray uvSetNames;
		meshFn.getUVSetNames( uvSetNames );
		
		for( i=0; i < uvSetNames.length(); i++ )
		{
			txt += MString(" UV Set: " ) + uvSetNames[i];
			txt += MString(" # UVs: " ) + meshFn.numUVs(uvSetNames[i]) + "\n";
		}
		
		MString cUVSetName;
		meshFn.getCurrentUVSetName( cUVSetName );
		
		txt += MString(" Current UV Set: ") + cUVSetName + "\n";
		
		// This handles mesh and mesh-vertex component selections
		MItMeshVertex vertIter( dagPath, component, &stat );
		if( !stat )
			continue;
					
		float2 vUV;			
		MFloatArray fvUs;
		MFloatArray fvVs;
		MIntArray faceIds;
		MIntArray vertIds;
		unsigned int fvIndex;
		
		for( ; !vertIter.isDone(); vertIter.next() )
		{
			vIndex = vertIter.index();
			txt += MString(" Vertex: ") + vIndex + "\n"; 
			
			bool hasUV = false;
			
			stat = vertIter.getUV( vUV, &cUVSetName );
			if( stat )
			{	
				txt += MString("  Vertex UV: (") + vUV[0] + ", " + vUV[1] + ")\n";
				hasUV = true;
			}
			
			stat = vertIter.getUVs( fvUs, fvVs, faceIds, &cUVSetName );
			if( stat )
			{
				for( i=0; i < faceIds.length(); i++ )
				{
					fIndex = faceIds[i];
					
					meshFn.getPolygonVertices( fIndex, vertIds );
					
					for( fvIndex=0; fvIndex < vertIds.length(); fvIndex++ )
					{
						if( vertIds[fvIndex] == vIndex )
							break;
					}
					
					txt += MString("  Face-vertex UV: face,vertex: (") + fIndex + ", " + fvIndex + ") uv: (" + fvUs[i] + ", " + fvVs[i] + ")\n";
				}
				hasUV = true;
			}
			
			if( !hasUV )
				txt += "  No assigned uv\n";
		}	
	}
	
	MGlobal::displayInfo( txt );

	return MS::kSuccess;
}
