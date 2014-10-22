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
#include <maya/MDagPath.h>
#include <maya/MDagPathArray.h>
#include <maya/MObjectArray.h>
#include <maya/MFnTransform.h>
#include <maya/MDistance.h>
#include <maya/MSyntax.h>
#include <maya/MArgDatabase.h>
#include <math.h>

class SubdToNURBS : public MPxCommand 
{
public:
	virtual MStatus	doIt ( const MArgList& );
	virtual MStatus	redoIt();
	virtual MStatus	undoIt();
	virtual bool isUndoable() const { return true; }

	static void *creator() { return new SubdToNURBS; }

private:
	// Selected subd objects
	MDagPathArray selSubds;

	// Resulting parent transforms of nurbs surfaces
	MObjectArray nurbsTransforms;
};

MStatus SubdToNURBS::doIt ( const MArgList &args )
{
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

MStatus SubdToNURBS::redoIt()
{	
	MStatus stat;
	
	nurbsTransforms.clear();
	
	MObjectArray nurbsSurfs;
	MDagPath dagPath;
	unsigned int i;
	for( i=0; i < selSubds.length(); i++ )
	{
		dagPath = selSubds[i];
	
		MFnSubd subdFn( dagPath );
		subdFn.convertToNurbs( nurbsSurfs );

		MFnDagNode dagFn;
		MObject transform;
		transform = dagFn.create( "transform", "subdivToNURBS" );
		nurbsTransforms.append( transform );

		dagFn.setObject( transform );			
		unsigned int j;
		for( j=0; j < nurbsSurfs.length(); j++ )
		{
			dagFn.addChild( nurbsSurfs[j] );
			
			// Put the object into the initial shading group
			MFnDependencyNode depFn( nurbsSurfs[j] );
			MGlobal::executeCommand( MString("sets -e -fe initialShadingGroup ") + depFn.name() );
		}
	}
	
	// Select transforms
	MString cmd( "select -r" );
	for( i=0; i < nurbsTransforms.length(); i++ )
	{
		MFnDagNode dagFn( nurbsTransforms[i] );
		cmd += MString(" ") + dagFn.name();
	}
	MGlobal::executeCommand( cmd );

	return stat;
}

MStatus SubdToNURBS::undoIt()
{
	unsigned int i;
	for( i=0; i < nurbsTransforms.length(); i++ )
	{
		MFnTransform transformFn( nurbsTransforms[i] );
		// N.B. It is important to delete the child shapes before
		// the transform node, otherwise Maya will crash.
		while( transformFn.childCount() )
			MGlobal::deleteNode( transformFn.child(0) );
		MGlobal::deleteNode( transformFn.object() );
	}

	return MS::kSuccess;
}

MStatus initializePlugin( MObject obj )
{
	MFnPlugin plugin( obj, "David Gould", "1.0" );

	MStatus stat;
	stat = plugin.registerCommand( "subdToNURBS", 
								   SubdToNURBS::creator );
	if ( !stat )
		stat.perror( "registerCommand failed");

	return stat;
}

MStatus uninitializePlugin( MObject obj )
{
	MFnPlugin plugin( obj );

	MStatus stat;
	stat = plugin.deregisterCommand( "subdToNURBS" );
	if ( !stat )
		stat.perror( "deregisterCommand failed" );

	return stat;
}