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
#include <maya/MItMeshPolygon.h>
#include <maya/MItMeshVertex.h>
#include <maya/MDagPath.h>
#include <maya/MPoint.h>
#include <maya/MFnMesh.h>
#include <maya/MItMeshEdge.h>
#include <maya/MDagModifier.h>
#include <maya/MSyntax.h>
#include <maya/MArgDatabase.h>
#include <maya/MDistance.h>
#include <maya/MDagPathArray.h>
#include "MoleculeUtils.h"

class Molecule2Cmd : public MPxCommand 
{
public:
	virtual MStatus	doIt( const MArgList& );
	virtual MStatus	redoIt();
	virtual MStatus	undoIt();
	virtual bool isUndoable() const { return true; }
	
	static void *creator() { return new Molecule2Cmd; }
	static MSyntax newSyntax();
	
private:
	// Command options
	MDistance radius;
	int segs;
	double ballRodRatio;
	MDagPathArray selMeshes;
	
	// Molecule mesh objects created
	MObjectArray objTransforms;
};

const char *radiusFlag = "-r", *radiusLongFlag = "-radius";
const char *segsFlag = "-s", *segsLongFlag = "-segments";
const char *ballRatioFlag = "-br", *ballRatioLongFlag = "-ballRatio";

MSyntax Molecule2Cmd::newSyntax()
{
    MSyntax syntax;

    syntax.addFlag( radiusFlag, radiusLongFlag, MSyntax::kDistance );
    syntax.addFlag( segsFlag, segsLongFlag, MSyntax::kLong );
    syntax.addFlag( ballRatioFlag, ballRatioLongFlag, MSyntax::kDouble );
	
	syntax.enableQuery( false );
	syntax.enableEdit( false );

	return syntax;
}

MStatus Molecule2Cmd::doIt( const MArgList &args )
{
	MStatus stat;
	
	// Initialize options to default values
	radius.setValue( 0.1 );
	segs = 6;
	ballRodRatio = 2.0;
	selMeshes.clear();
	
	// Get the options from the command line
	MArgDatabase argData( syntax(), args, &stat );
	if( !stat )
		return stat;

	if( argData.isFlagSet( radiusFlag ) )
		argData.getFlagArgument( radiusFlag, 0, radius );
	
	if( argData.isFlagSet( segsFlag ) )
		argData.getFlagArgument( segsFlag, 0, segs );

	if( argData.isFlagSet( ballRatioFlag ) )
		argData.getFlagArgument( ballRatioFlag, 0, ballRodRatio );
	
	// Get a list of currently selected objects
	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	// Iterate over the meshes
	MDagPath dagPath;
	MItSelectionList iter( selection, MFn::kMesh );
	for ( ; !iter.isDone(); iter.next() )
	{								
		iter.getDagPath( dagPath );
		selMeshes.append( dagPath );	
	}
	
	if( selMeshes.length() == 0 )
	{
		MGlobal::displayWarning( "Select one or more meshes" );
		return MS::kFailure;
	}	
		
	return redoIt();
}

MStatus	Molecule2Cmd::redoIt()
{
	MStatus stat;
	MDagPath dagPath;
	MFnMesh meshFn;
		
	// Create a ball
	int nBallPolys;
	MPointArray ballVerts;
	MIntArray ballPolyCounts;
	MIntArray ballPolyConnects;
	MFloatArray ballUCoords;
	MFloatArray ballVCoords;
	MIntArray ballFvUVIDs;
	genBall( MPoint::origin, ballRodRatio * radius.value(), segs, nBallPolys, 
			 ballVerts, ballPolyCounts, ballPolyConnects,
			 true, ballUCoords, ballVCoords, ballFvUVIDs );
		
	unsigned int i, j, vertOffset;
	MPointArray meshVerts;
	MPoint p0, p1;
	MObject objTransform;
	
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
	MDagModifier dagMod;
	MFnDagNode dagFn;
	
	objTransforms.clear();
	
	// Iterate over the meshes
	unsigned int mi;
	for( mi=0; mi < selMeshes.length(); mi++ )
	{								
		dagPath = selMeshes[mi];
		meshFn.setObject( dagPath );
		
		uvOffset = 0;
		nNewPolys = 0;
		newVerts.clear();
		newPolyCounts.clear();
		newPolyConnects.clear();
		newUCoords.clear();
		newVCoords.clear();
		newFvUVIDs.clear();
		
		// Generate balls
		meshFn.getPoints( meshVerts, MSpace::kWorld );
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
		MItMeshEdge edgeIter( dagPath );
		for( ; !edgeIter.isDone(); edgeIter.next(), nRods++  )
		{	
			p0 = edgeIter.point( 0, MSpace::kWorld );		
			p1 = edgeIter.point( 1, MSpace::kWorld );
			
			// N.B. Generate the uv coordinates only once since they
			// are referenced by all rods
			genRod( p0, p1, 
					radius.value(), segs, nRodPolys, 
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
		
		objTransform = meshFn.create( newVerts.length(), nNewPolys, newVerts, 
									  newPolyCounts, newPolyConnects,
									  newUCoords, newVCoords, 
									  MObject::kNullObj, &stat ); 
		if( !stat )
		{
			MGlobal::displayError( MString( "Unable to create mesh: " ) + stat.errorString() );
			return stat;
		}	
		
		objTransforms.append( objTransform );
				
		meshFn.assignUVs( newPolyCounts, newFvUVIDs );
				
		meshFn.updateSurface();
		
		// Rename transform node
		dagFn.setObject( objTransform );
		dagFn.setName( "molecule" );
				
		// Put mesh into the initial shading group
		dagMod.commandToExecute( MString( "sets -e -fe initialShadingGroup " ) + meshFn.name() );
	}

	// Select all the newly created molecule meshes
	MString cmd( "select -r" );
	for( i=0; i < objTransforms.length(); i++ )
	{
		dagFn.setObject( objTransforms[i] );
		cmd += " " + dagFn.name();	
	}

	dagMod.commandToExecute( cmd );
	
	return dagMod.doIt();
}

MStatus	Molecule2Cmd::undoIt()
{
	MDGModifier dgMod;
	MFnDagNode dagFn;
	MObject child;
	
	unsigned int i;
	for( i=0; i < objTransforms.length(); i++ )
	{
		// N.B. It is important to delete the child shape before
		// the transform node, otherwise Maya will crash.
		dagFn.setObject( objTransforms[i] );
		child = dagFn.child( 0 );
		dgMod.deleteNode( child );
		
		dgMod.deleteNode( objTransforms[i] );
	}
	
	return dgMod.doIt();
}

MStatus initializePlugin( MObject obj )
{
	MFnPlugin plugin( obj, "David Gould", "1.0" );

	MStatus stat;
	stat = plugin.registerCommand( "molecule2", 
								   Molecule2Cmd::creator,
								   Molecule2Cmd::newSyntax );
	if ( !stat )
		MGlobal::displayError( MString( "registerCommand failed: " ) + stat.errorString() );

	return stat;
}

MStatus uninitializePlugin( MObject obj )
{
	MFnPlugin plugin( obj );

	MStatus	stat;
	stat = plugin.deregisterCommand( "molecule2" );
	if ( !stat )
		MGlobal::displayError( MString( "deregisterCommand failed: " ) + stat.errorString() );

	return stat;
}