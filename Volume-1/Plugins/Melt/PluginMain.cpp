//
// Copyright (C) 2001 David Gould 
// 
#include "MeltNode.h"
#include "MeltCmd.h"
#include <maya/MFnPlugin.h>

MStatus initializePlugin( MObject obj )
{ 
MStatus stat;
MString errStr;
MFnPlugin plugin( obj, "David Gould", "1.0", "Any");

stat = plugin.registerCommand( "melt", MeltCmd::creator );
if ( !stat )
	{
	errStr = "registerCommand failed";
	goto error;
	}

stat = plugin.registerNode( "melt", MeltNode::id, MeltNode::creator, MeltNode::initialize );
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

stat = plugin.deregisterCommand( "melt" );
if ( !stat )
	{
	errStr = "deregisterCommand failed";
	goto error;
	}

stat = plugin.deregisterNode( MeltNode::id );
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
