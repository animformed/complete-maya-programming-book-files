//
// Copyright (C) 2001 David Gould 
// 
#include "SwirlDeformer.h"
#include <maya/MFnPlugin.h>

MStatus initializePlugin( MObject obj )
{ 
MStatus stat;
MString errStr;
MFnPlugin plugin( obj, "David Gould", "1.0", "Any");

stat = plugin.registerNode( SwirlDeformer::typeName, 
										SwirlDeformer::typeId, 
										SwirlDeformer::creator, 
										SwirlDeformer::initialize, 
										MPxNode::kDeformerNode );
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

stat = plugin.deregisterNode( SwirlDeformer::typeId );
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
