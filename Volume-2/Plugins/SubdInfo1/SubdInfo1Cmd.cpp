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
#include <maya/MPoint.h>
#include <maya/MVector.h>
#include <maya/MObjectArray.h>
#include <maya/MFnSubd.h>
#include <maya/MFnSubdNames.h>
#include <maya/MDagPath.h>
#include <maya/MUint64Array.h>

DeclareSimpleCommand( subdInfo1, "David Gould", "1.0" );

MStatus subdInfo1::doIt( const MArgList& args )
{
	MStatus stat = MS::kSuccess;

	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	MDagPath dagPath;
	MObject component;
	
	bool filterAll = true, 
		 filterCreases = true, 
		 filterEdits = true;
	unsigned int index;
	index = args.flagIndex( "co", "creasesOnly" );
	if( index != MArgList::kInvalidArgIndex )
	{
		args.get( index+1, filterCreases );
		filterAll = filterEdits = false;
	}
	index = args.flagIndex( "eo", "editsOnly" );
	if( index != MArgList::kInvalidArgIndex )
	{
		args.get( index+1, filterCreases );
		filterAll = filterCreases = false;
	}
		
	unsigned int i, j, k, m, level, nLevels, nMaxLevels, nPolysLevel0;
	unsigned int index0, index1;
	MUint64Array polyIds, childPolyIds, vertIds, edgeIds;
	MUint64 polyId, vertId;
	MPoint pt;
	MVector vec, norm;
	int valence;
	bool isBoundary, isCreased, hasUVs, hasOffset, found;
	MDoubleArray uCoords, vCoords;
	MObjectArray shaders;
	MUint64Array polyIdsWithShader;
	MIntArray shaderIds;
	MObject shader;
	//MIntArray creasedEdges;
	MUint64Array filteredComponents;
	MString str;
	MString relevancy;
	
	MString txt;
	MItSelectionList iter( selection );
	for ( ; !iter.isDone(); iter.next() )
	{								
		iter.getDagPath( dagPath, component );
		
		MFnSubd subdFn( dagPath, &stat );
		if( !stat )
			continue;
			
		txt += dagPath.fullPathName() + "\n";
		
		nLevels = subdFn.levelMaxCurrent() + 1; // Include the base mesh in the count
		nMaxLevels = subdFn.levelMaxAllowed();

		if( filterAll )
		{
			subdFn.getConnectedShaders( dagPath.instanceNumber(), shaders, polyIdsWithShader, shaderIds );
			txt += MString("Levels: ") + nLevels + " Max Levels: " + nMaxLevels + "\n";
		}
								
		// Get polygons at control mesh (level 0)
		polyIds.clear();
		nPolysLevel0 = (unsigned int) subdFn.polygonCount(0);
		for( i=0; i < nPolysLevel0; i++ )
			polyIds.append( MFnSubdNames::baseFaceIdFromIndex(i) ); 
		
		for( level=0; level < nLevels; level++ )
		{
			if( filterAll )
			{
				txt += MString("Level ") + level + "\n";
				txt += MString("  Polygons: ") + subdFn.polygonCount( level ) + "\n";
			}
				
			childPolyIds.clear();
			
			for( i=0; i < polyIds.length(); i++ )
			{
				polyId = polyIds[i];
				
				if( filterAll )
				{
					txt += MString("  Polygon #") + i + "\n";
				
					// Get shader assigned to face
					shader = MObject::kNullObj;
					for( k=0; k < polyIdsWithShader.length(); k++ )
					{
						if( polyId == polyIdsWithShader[k] &&
							shaderIds[k] != -1 )
						{
							shader = shaders[ shaderIds[k] ];
							MFnDependencyNode depFn( shader );
							txt += ("  Shader: ") + depFn.name() + "\n";
							break;
						}
					}
				}
									
				// Output edge creasing information
				if( filterCreases )
				{
					if( filterAll )
						txt += "  Creased Edges:";

					//creasedEdges.clear();
					subdFn.polygonEdges( polyId, edgeIds );
					for( k=0; k < edgeIds.length(); k++ )
					{
						if( subdFn.edgeIsCreased( edgeIds[k] ) )
						{
							if( subdFn.edgeCreaseRelevant( edgeIds[k] ) )
								relevancy = "Relevant";
							else
								relevancy = "Irrelevant";

							if( filterAll )
								txt += MString(" ") + k + " (" + relevancy + ")";
							else
							{
								found = false;
								for( m=0; m < filteredComponents.length(); m++ )
								{
									if( edgeIds[k] == filteredComponents[m] )
									{
										found = true;
										break;
									}
								}
								
								if( !found )
								{
									MFnSubdNames::toSelectionIndices( edgeIds[k], index0, index1 );
									
									str = dagPath.fullPathName() + ".sme[" + index0 + "][" + index1 + "]";
									txt += "Edge: " + str + " (" + relevancy + ")\n";
									
									//txt += MString(" " ) + LOWORD(edgeIds[k]) + " " + HIWORD(edgeIds[k]) + "\n";
									
									appendToResult( MString(" ") + str );
									filteredComponents.append( edgeIds[k] );
								}
							}
						}
					}

					if( filterAll )
						txt += "\n";
				}					
					
				if( filterAll )
				{
					hasUVs = subdFn.polygonHasVertexUVs( polyId );
					if( hasUVs )
						subdFn.polygonGetVertexUVs( polyId, uCoords, vCoords );

					txt += MString("  Vertices: ") + subdFn.polygonVertexCount(polyId) + "\n";
				}
				
				subdFn.polygonVertices( polyId, vertIds );
				for( j=0; j < vertIds.length(); j++ )
				{
					vertId = vertIds[j];
					
					subdFn.vertexPositionGet( vertId, pt, MSpace::kWorld );
					subdFn.vertexEditGet( vertId, vec, MSpace::kWorld );
					hasOffset = vec != MVector::zero;
					valence = subdFn.vertexValence( vertId );
					subdFn.vertexNormal( vertId, norm );
					isBoundary = subdFn.vertexIsBoundary( vertId );
					isCreased = subdFn.vertexIsCreased( vertId );

					if( filterAll )
					{
						txt += MString("    Vertex #") + j;
						if( isBoundary )
							txt += " (Boundary)";
					}
					
					if( filterCreases && isCreased )
					{
						if( subdFn.vertexCreaseRelevant( vertId ) )
							relevancy = "Relevant";
						else
							relevancy = "Irrelevant";
							
						if( filterAll )
							txt += " (Creased - " + relevancy + ")";
						else
						{
							found = false;
							for( m=0; m < filteredComponents.length(); m++ )
							{
								if( vertId == filteredComponents[m] )
								{
									found = true;
									break;
								}
							}
							
							if( !found )
							{
								MFnSubdNames::toSelectionIndices( vertId, index0, index1 );
								str = dagPath.fullPathName() + ".smp[" + index0 + "][" + index1 + "]";
								txt += "Vertex: " + str + " (" + relevancy + ")\n";
								appendToResult( MString(" ") + str );
								filteredComponents.append( vertId );
							}
						}
					}
						
					if( filterAll )
						txt += "\n";
					
					if( filterAll )
					{
						txt += MString("      Position: (") + pt.x + ", " + pt.y + ", " + pt.z + ")";
						if( hasOffset )
							txt += MString(" Offset: (") + vec.x + ", " + vec.y + ", " + vec.z + ")";
						txt += "\n";
					}
					else
					{
						if( filterEdits && hasOffset )
						{
							found = false;
							for( m=0; m < filteredComponents.length(); m++ )
							{
								if( vertId == filteredComponents[m] )
								{
									found = true;
									break;
								}
							}
							
							if( !found )
							{
								MFnSubdNames::toSelectionIndices( vertId, index0, index1 );
								str = dagPath.fullPathName() + ".smp[" + index0 + "][" + index1 + "]";
								txt += "Vertex: " + str + ")\n";
								appendToResult( MString(" ") + str );
								filteredComponents.append( vertId );
							}
						}
					}
					
					if( filterAll )
					{
						txt += MString("      Normal: (") + norm.x + ", " + norm.y + ", " + norm.z + ")\n";
						if( hasUVs )
							txt += MString("      UV: (") + uCoords[j] + ", " + vCoords[j] + ")\n";							
						
						txt += MString("      Valence: ") + valence + "\n";
					}
				}
				
				subdFn.polygonChildren( polyId, childPolyIds );
			}
			
			polyIds = childPolyIds;
		}
	}
	
	MGlobal::displayInfo( txt );

	return MS::kSuccess;
}
