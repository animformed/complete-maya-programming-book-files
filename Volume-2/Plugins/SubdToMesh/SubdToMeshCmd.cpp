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
#include <maya/MPointArray.h>
#include <maya/MVector.h>
#include <maya/MFnSubd.h>
#include <maya/MFnMesh.h>
#include <maya/MDagPath.h>
#include <maya/MDagPathArray.h>
#include <maya/MObjectArray.h>
#include <maya/MDistance.h>
#include <maya/MSyntax.h>
#include <maya/MArgDatabase.h>
#include <math.h>

class SubdToMesh : public MPxCommand 
{
public:
	virtual MStatus	doIt ( const MArgList& );
	virtual MStatus	redoIt();
	virtual MStatus	undoIt();
	virtual bool isUndoable() const { return true; }

	static void *creator() { return new SubdToMesh; }
	static MSyntax newSyntax();

private:
	bool viaNurbs;
	bool uniform;
	int depth;
	int samples;
	
	MDagPathArray selSubds;
	MObjectArray meshes;	
};

const char *viaNurbsFlag = "-vn", *viaNurbsLongFlag = "-viaNurbs";
const char *uniformFlag = "-u", *uniformLongFlag = "-uniform";
const char *depthFlag = "-d", *depthLongFlag = "-depth";
const char *samplesFlag = "-s", *samplesLongFlag = "-samples";

MSyntax SubdToMesh::newSyntax()
{
    MSyntax syntax;

    syntax.addFlag( viaNurbsFlag, viaNurbsLongFlag, MSyntax::kBoolean );
    syntax.addFlag( uniformFlag, uniformLongFlag, MSyntax::kBoolean );
    syntax.addFlag( depthFlag, depthLongFlag, MSyntax::kLong );
    syntax.addFlag( samplesFlag, samplesLongFlag, MSyntax::kLong );
    
	syntax.enableQuery( false );
	syntax.enableEdit( false );

	return syntax;
}

MStatus SubdToMesh::doIt ( const MArgList &args )
{
	MStatus stat;
	
	// Set default values
	viaNurbs = false;
	uniform = true;
	depth = 1;
	samples = 4;

	// Get the options from the command line
	MArgDatabase argData( syntax(), args, &stat );
	if( !stat )
		return stat;

	if( argData.isFlagSet( viaNurbsFlag ) )
		argData.getFlagArgument( viaNurbsFlag, 0, viaNurbs );
	
	if( argData.isFlagSet( uniformFlag ) )
		argData.getFlagArgument( uniformFlag, 0, uniform );

	if( argData.isFlagSet( depthFlag ) )
		argData.getFlagArgument( depthFlag, 0, depth );

	if( argData.isFlagSet( samplesFlag ) )
		argData.getFlagArgument( samplesFlag, 0, samples );
	
	// Get a list of currently selected objects
	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	// Iterate over the subds
	MDagPath dagPath;
	MItSelectionList iter( selection, MFn::kSubdiv );
	for ( ; !iter.isDone(); iter.next() )
	{								
		iter.getDagPath( dagPath );
		selSubds.append( dagPath );
	}

	if( selSubds.length() == 0 )
	{
		MGlobal::displayWarning( "Select one or more subd surfaces." );
		return MS::kFailure;
	}

	return redoIt();
}

MStatus SubdToMesh::redoIt()
{	
	meshes.clear();
	
	MObject meshTransform, mesh;
	MDagPath dagPath;
	unsigned int i;
	for( i=0; i < selSubds.length(); i++ )
	{
		dagPath = selSubds[i];
	
		MFnSubd subdFn( dagPath );
		meshTransform = viaNurbs ?
						subdFn.tessellateViaNurbs() :
						subdFn.tesselate( uniform, depth, samples );
		if( !meshTransform.isNull() )
		{
			MFnDagNode dagFn( meshTransform );
			mesh = dagFn.child(0);
		
			MFnMesh meshFn( mesh );
			meshes.append( mesh );

			// Put the object into the initial shading group			
			MString cmd( "sets -e -fe initialShadingGroup " );
			cmd += meshFn.name();
			MGlobal::executeCommand( cmd );		
		}	
	}

	// Select meshes
	MString cmd( "select -r" );
	for( i=0; i < meshes.length(); i++ )
	{
		MFnMesh meshFn( meshes[i] );
		cmd += MString(" ") + meshFn.name();
	}
	MGlobal::executeCommand( cmd );
		
	return MS::kSuccess;
}

MStatus SubdToMesh::undoIt()
{
	unsigned int i;
	for( i=0; i < meshes.length(); i++ )
	{
		MFnDagNode dagFn( meshes[i] );
		MObject parentTransform = dagFn.parent(0);

		// N.B. It is important to delete the child shape before
		// the transform node, otherwise Maya will crash.
		MGlobal::deleteNode( meshes[i] );
		MGlobal::deleteNode( parentTransform );
	}

	return MS::kSuccess;
}

MStatus initializePlugin( MObject obj )
{
	MFnPlugin plugin( obj, "David Gould", "1.0" );

	MStatus stat;
	stat = plugin.registerCommand( "subdToMesh", 
								   SubdToMesh::creator,
								   SubdToMesh::newSyntax );
	if ( !stat )
		stat.perror( "registerCommand failed");

	return stat;
}

MStatus uninitializePlugin( MObject obj )
{
	MFnPlugin plugin( obj );

	MStatus stat;
	stat = plugin.deregisterCommand( "subdToMesh" );
	if ( !stat )
		stat.perror( "deregisterCommand failed" );

	return stat;
}