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
#include <maya/MDistance.h>
#include <maya/MSyntax.h>
#include <maya/MArgDatabase.h>
#include <math.h>

class SubdCubeCmd : public MPxCommand 
{
public:
	virtual MStatus	doIt ( const MArgList& );
	virtual MStatus	redoIt();
	virtual MStatus	undoIt();
	virtual bool isUndoable() const { return true; }

	static void *creator() { return new SubdCubeCmd; }

private:
	// Subd object created
	MObject subdTransform;
};


MStatus SubdCubeCmd::doIt ( const MArgList &args )
{
	return redoIt();
}


MStatus	SubdCubeCmd::redoIt()
{	
	const MPoint pts[8] =
	{
		MPoint( -0.5, -0.5, 0.5 ),
		MPoint( 0.5, -0.5, 0.5 ),
		MPoint( 0.5, 0.5, 0.5 ),
		MPoint( -0.5, 0.5, 0.5 ),
		MPoint( 0.5, -0.5, -0.5 ),
		MPoint( 0.5, 0.5, -0.5 ),
		MPoint( -0.5, 0.5, -0.5 ),
		MPoint( -0.5, -0.5, -0.5 ),
	};
	
	const int faces[6][4] =
	{
		{ 0, 1, 2, 3 },
		{ 1, 4, 5, 2 },
		{ 4, 7, 6, 5 },
		{ 7, 0, 3, 6 },
		{ 2, 5, 6, 3 },
		{ 0, 7, 4, 1 }
	};
	
	MStatus stat;

	unsigned int i, j;
	MPointArray verts;
	for( i=0; i < 8; i++ )
		verts.append( pts[i] );
	
	MIntArray polyCounts, polyConnects;
	for( i=0; i < 6; i++ )
	{
		polyCounts.append( 4 );
		for( j=0; j < 4; j++ )
			polyConnects.append( faces[i][j] );
	}
	
	MFnSubd subdFn;
	subdTransform = subdFn.createBaseMesh( false, 8, 6, verts, polyCounts, polyConnects );
	
	// Put the object into the initial shading group
	MString cmd( "sets -e -fe initialShadingGroup " );
	cmd += subdFn.name();
	MGlobal::executeCommand( cmd );

	cmd = MString("select -r ") + subdFn.name();
	MGlobal::executeCommand( cmd );
	
	return stat;	
}

MStatus	SubdCubeCmd::undoIt()
{
	MFnDagNode dagFn( subdTransform );
	MObject child;
	
	// N.B. It is important to delete the child shape before
	// the transform node, otherwise Maya will crash.
	child = dagFn.child(0);
	MGlobal::deleteNode( child );
	MGlobal::deleteNode( subdTransform );
	
	return MS::kSuccess;
}

MStatus initializePlugin( MObject obj )
{
	MFnPlugin plugin( obj, "David Gould", "1.0" );

	MStatus stat;
	stat = plugin.registerCommand( "subdCube", 
								   SubdCubeCmd::creator );
	if ( !stat )
		stat.perror( "registerCommand failed");

	return stat;
}

MStatus uninitializePlugin( MObject obj )
{
	MFnPlugin plugin( obj );

	MStatus	stat;
	stat = plugin.deregisterCommand( "subdCube" );
	if ( !stat )
		stat.perror( "deregisterCommand failed" );

	return stat;
}