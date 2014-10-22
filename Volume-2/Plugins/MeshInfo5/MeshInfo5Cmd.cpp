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
#include <maya/MItMeshPolygon.h>
#include <maya/MItMeshVertex.h>
#include <maya/MFnMesh.h>
#include <maya/MDagPath.h>

void addData( MString &txt,
			  const int fIndex, 
			  const int vIndex, 
			  const int fvIndex,
			  const MVector &fNormal, 
			  const MVector &vNormal, 
			  const MVector &fvNormal 
			  )
{
	txt += MString(" Face: ") + fIndex + " Vertex: " + vIndex + " Face-Vertex: " + fvIndex + "\n";
	txt += MString("   Face Normal: (") + fNormal.x + ", " + fNormal.y + ", " + fNormal.z + ")\n";
	txt += MString("   Vertex Normal: (") + vNormal.x + ", " + vNormal.y + ", " + vNormal.z + ")\n";
	txt += MString("   Face-Vertex Normal: (") + fvNormal.x + ", " + fvNormal.y + ", " + fvNormal.z + ")\n";
}

DeclareSimpleCommand( meshInfo5, "David Gould", "1.0" );

MStatus meshInfo5::doIt( const MArgList& args )
{
	MStatus stat = MS::kSuccess;

	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	MDagPath dagPath;
	MObject component;
	
	unsigned int i, nVerts;
	int fIndex, vIndex, fvIndex;
	MVector fNormal, vNormal, fvNormal;
	
	MString txt;
	MItSelectionList iter( selection );
	for ( ; !iter.isDone(); iter.next() )
	{								
		iter.getDagPath( dagPath, component );
		
		MFnMesh meshFn( dagPath );
		
		// This handles whole mesh selections and mesh-face component selections
		MItMeshPolygon faceIter( dagPath, component, &stat );
		if( stat == MS::kSuccess )
		{
			txt += MString( "Object: " ) + dagPath.fullPathName() + "\n";	
									
			for( ; !faceIter.isDone(); faceIter.next() )
			{
				nVerts = faceIter.polygonVertexCount();
				
				for( i=0; i < nVerts; i++ )
				{
					fvIndex = i;
					fIndex = faceIter.index();
					vIndex = faceIter.vertexIndex( i );
					
					faceIter.getNormal( fNormal );
					meshFn.getVertexNormal( vIndex, vNormal );					
					faceIter.getNormal( fvIndex, fvNormal );

					addData( txt, fIndex, vIndex, fvIndex, fNormal, vNormal, fvNormal );
				}
			}
		} 
		else
		{
			// This handles mesh-vertex component selections
			MItMeshVertex vertIter( dagPath, component, &stat );
			if( stat == MS::kSuccess )
			{
				txt += MString( "Object: " ) + dagPath.fullPathName() + "\n";	

				MIntArray faceIds;
				MIntArray vertIds;
						
				for( ; !vertIter.isDone(); vertIter.next() )
				{
					vIndex = vertIter.index();
					
					vertIter.getNormal( vNormal );
					vertIter.getConnectedFaces( faceIds );
					
					for( i=0; i < faceIds.length(); i++ )
					{
						fIndex = faceIds[i];
						
						meshFn.getPolygonNormal( fIndex, fNormal );
						meshFn.getFaceVertexNormal( fIndex, vIndex, fvNormal );
						meshFn.getPolygonVertices( fIndex, vertIds );
												
						for( fvIndex=0; fvIndex < int(vertIds.length()); fvIndex++ )
						{
							if( vertIds[fvIndex] == vIndex )
								break;
						}
						
						addData( txt, fIndex, vIndex, fvIndex, fNormal, vNormal, fvNormal ); 
					}
				}
			}
		}
	}
	
	MGlobal::displayInfo( txt );

	return MS::kSuccess;
}
