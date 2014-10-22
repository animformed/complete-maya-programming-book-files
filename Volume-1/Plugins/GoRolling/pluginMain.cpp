//
// Copyright (C) 2001 David Gould 
// 
#include "RollingNode.h"
#include "GoRollingCmd.h"
#include <maya/MFnPlugin.h>

MStatus initializePlugin( MObject obj )
{ 
MStatus stat;
MString errStr;
MFnPlugin plugin( obj, "David Gould", "1.0", "Any");

stat = plugin.registerCommand( "goRolling", GoRollingCmd::creator );
if ( !stat )
	{
	errStr = "registerCommand failed";
	goto error;
	}

stat = plugin.registerNode( "RollingNode", RollingNode::id, 
										RollingNode::creator, RollingNode::initialize );
if ( !stat ) 
	{
	errStr = "registerNode failed";
	goto error;
	}

return stat;

error:

stat.perror( errStr );
return stat;
}

MStatus uninitializePlugin( MObject obj)
{
MStatus stat;
MString errStr;
MFnPlugin plugin( obj );

stat = plugin.deregisterCommand( "goRolling" );
if ( !stat )
	{
	errStr = "deregisterCommand failed";
	goto error;
	}

stat = plugin.deregisterNode( RollingNode::id );
if( !stat ) 
	{
	errStr = "deregisterNode failed";
	goto error;
	}

return stat;

error:

stat.perror( errStr );
return stat;
}
