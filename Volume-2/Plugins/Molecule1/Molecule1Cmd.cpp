//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#include <maya/MPxCommand.h>
#include <maya/MGlobal.h>
#include <maya/MFnPlugin.h>
#include <maya/MSelectionList.h>
#include <maya/MItSelectionList.h>
#include <maya/MDagPath.h>
#include <maya/MPoint.h>
#include <maya/MFnMesh.h>
#include <maya/MItMeshEdge.h>
#include "MoleculeUtils.h"

class Molecule1Cmd : public MPxCommand 
{
public:
	virtual MStatus	doIt ( const MArgList& );
	static void *creator() { return new Molecule1Cmd; }
};

MStatus Molecule1Cmd::doIt ( const MArgList & )
{
	double radius = 0.1;
	int segs = 6;
	double ballRodRatio = 2.0;
	
	MStatus stat;
	
	// Get a list of currently selected objects
	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	MDagPath dagPath;
	MFnMesh meshFn;
	//MItMeshEdge edgeIter( MObject::kNullObj );
		
	// Create a ball
	int nBallPolys;
	MPointArray ballVerts;
	MIntArray ballPolyCounts;
	MIntArray ballPolyConnects;
	genBall( MPoint::origin, ballRodRatio * radius, segs, nBallPolys, ballVerts, ballPolyCounts, ballPolyConnects );
		
	unsigned int i, j, vertOffset;
	MPointArray meshVerts;
	MPoint p0, p1;
	MObject objTransform;
	
	// Setup for rods
	int nRodPolys;
	MPointArray rodVerts;
	MIntArray rodPolyCounts;
	MIntArray rodPolyConnects;
		
	// Setup for newMesh
	int nNewPolys;
	MPointArray newVerts;
	MIntArray newPolyCounts;
	MIntArray newPolyConnects;
	
	// Iterate over the meshes
	MItSelectionList iter( selection, MFn::kMesh );
	for ( ; !iter.isDone(); iter.next() )
	{								
		iter.getDagPath( dagPath );
		meshFn.setObject( dagPath );
		
		nNewPolys = 0;
		newVerts.clear();
		newPolyCounts.clear();
		newPolyConnects.clear();

		// Generate balls
		meshFn.getPoints( meshVerts );
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
		}
		
		// Generate rods
		MItMeshEdge edgeIter( dagPath );
		for( ; !edgeIter.isDone(); edgeIter.next() )
		{
			p0 = edgeIter.point( 0 );		
			p1 = edgeIter.point( 1 );
			
			genRod( p0, p1, radius, segs, nRodPolys, rodVerts, rodPolyCounts, rodPolyConnects ); 

			vertOffset = newVerts.length();
			
			// Add the rod to the mesh
			nNewPolys += nRodPolys;
			
			for( i=0; i < rodVerts.length(); i++ )
				newVerts.append( rodVerts[i] );
				
			for( i=0; i < rodPolyCounts.length(); i++ )
				newPolyCounts.append( rodPolyCounts[i] );
				
			for( i=0; i < rodPolyConnects.length(); i++ )
				newPolyConnects.append( vertOffset + rodPolyConnects[i] );
		}
		 
		objTransform = meshFn.create( newVerts.length(), nNewPolys, newVerts, newPolyCounts, newPolyConnects, MObject::kNullObj, &stat ); 
		if( !stat )
			stat.perror( "Unable to create mesh" );
			
		meshFn.updateSurface();
		
		// Put mesh into the initial shading group
		MString cmd( "sets -e -fe initialShadingGroup " );
		cmd += meshFn.name();
		MGlobal::executeCommand( cmd );
	}

	return MS::kSuccess;
}

MStatus initializePlugin( MObject obj )
{
	MFnPlugin plugin( obj, "David Gould", "1.0" );

	MStatus stat;
	stat = plugin.registerCommand( "molecule1", Molecule1Cmd::creator );
	if ( !stat )
		stat.perror( "registerCommand failed");

	return stat;
}

MStatus uninitializePlugin( MObject obj )
{
	MFnPlugin plugin( obj );

	MStatus	stat;
	stat = plugin.deregisterCommand( "molecule1" );
	if ( !stat )
		stat.perror( "deregisterCommand failed" );

	return stat;
}