//
// Copyright (C) 2001 David Gould 
// 
#include "GroundShadowNode.h"
#include "GroundShadowCmd.h"
#include <maya/MFnPlugin.h>

MStatus initializePlugin( MObject obj )
{ 
MStatus stat;
MString errStr;
MFnPlugin plugin( obj, "David Gould", "1.0", "Any");

stat = plugin.registerCommand( "groundShadow", GroundShadowCmd::creator );
if ( !stat )
	{
	errStr = "registerCommand failed";
	goto error;
	}

stat = plugin.registerNode( "groundShadow", GroundShadowNode::id, GroundShadowNode::creator, GroundShadowNode::initialize );
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

stat = plugin.deregisterCommand( "groundShadow" );
if ( !stat )
	{
	errStr = "deregisterCommand failed";
	goto error;
	}

stat = plugin.deregisterNode( GroundShadowNode::id );
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
