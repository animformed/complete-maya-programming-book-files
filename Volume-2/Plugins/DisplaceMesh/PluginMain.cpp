//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#include "DisplaceMeshCmd.h"
#include "DisplaceMeshNode.h"
#include <maya/MFnPlugin.h>

MStatus initializePlugin( MObject obj )
{
	MFnPlugin plugin( obj, "David Gould", "1.0" );

	MStatus stat;
	stat = plugin.registerCommand( "displaceMesh", 
								   DisplaceMeshCmd::creator,
								   DisplaceMeshCmd::newSyntax );
	if( !stat )
	{
		MGlobal::displayError( MString( "registerCommand failed: " ) + stat.errorString() );
		return stat;
	}

	stat = plugin.registerNode( "displaceMesh",
								DisplaceMeshNode::id,
								DisplaceMeshNode::creator,
								DisplaceMeshNode::initialize );
	if( !stat )
	{
		MGlobal::displayError( MString( "registerNode failed: " ) + stat.errorString() );
		return stat;
	}

	return stat;
}

MStatus uninitializePlugin( MObject obj )
{
	MFnPlugin plugin( obj );

	MStatus	stat;
	stat = plugin.deregisterCommand( "displaceMesh" );
	if ( !stat )
	{
		MGlobal::displayError( MString( "deregisterCommand failed: " ) + stat.errorString() );
		return stat;
	}
	
	stat = plugin.deregisterNode( DisplaceMeshNode::id );
	if ( !stat )
	{
		MGlobal::displayError( MString( "deregisterNode failed: " ) + stat.errorString() );
		return stat;
	}

	return stat;
}