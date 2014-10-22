//
// Copyright (C) 2001 David Gould 
// 
#include "BasicLocator.h"
#include "BasicLocatorManip.h"
#include <maya/MFnPlugin.h>

MStatus initializePlugin( MObject obj )
{ 
MStatus stat;
MString errStr;
MFnPlugin plugin( obj, "David Gould", "1.0", "Any");

stat = plugin.registerNode( BasicLocator::typeName,
										BasicLocator::typeId,
										&BasicLocator::creator, &BasicLocator::initialize, 
										MPxNode::kLocatorNode );
if ( !stat )
	{
	errStr = "registerNode failed";
	goto error;
	}

stat = plugin.registerNode( BasicLocatorManip::typeName,
										BasicLocatorManip::typeId, 
										&BasicLocatorManip::creator,
										&BasicLocatorManip::initialize, 
										MPxNode::kManipContainer );
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

stat = plugin.deregisterNode( BasicLocator::typeId );
if( !stat ) 
	{
	errStr = "deregisterNode failed";
	goto error;
	}

stat = plugin.deregisterNode( BasicLocatorManip::typeId );
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
