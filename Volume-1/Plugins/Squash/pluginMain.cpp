//
// Copyright (C) 2001 David Gould 
// 
// File: pluginMain.cpp
//
// Author: Maya SDK Wizard
//

#include "SquashNode.h"

#include <maya/MFnPlugin.h>

MStatus initializePlugin( MObject obj )
//
//	Description:
//		this method is called when the plug-in is loaded into Maya.  It 
//		registers all of the services that this plug-in provides with 
//		Maya.
//
//	Arguments:
//		obj - a handle to the plug-in object (use MFnPlugin to access it)
//
{ 
	MStatus   status;
	MFnPlugin plugin( obj, "David Gould", "4.0", "Any");

	status = plugin.registerNode( "Squash", Squash::id, Squash::creator,
								  Squash::initialize );
	if (!status) {
		status.perror("registerNode");
		return status;
	}

	return status;
}

MStatus uninitializePlugin( MObject obj)
//
//	Description:
//		this method is called when the plug-in is unloaded from Maya. It 
//		deregisters all of the services that it was providing.
//
//	Arguments:
//		obj - a handle to the plug-in object (use MFnPlugin to access it)
//
{
	MStatus   status;
	MFnPlugin plugin( obj );

	status = plugin.deregisterNode( Squash::id );
	if (!status) {
		status.perror("deregisterNode");
		return status;
	}

	return status;
}
