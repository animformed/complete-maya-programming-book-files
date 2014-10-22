//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#include "Molecule4Cmd.h"
#include "Molecule4Node.h"
#include <maya/MFnPlugin.h>

MStatus initializePlugin( MObject obj )
{
	MFnPlugin plugin( obj, "David Gould", "1.0" );

	MStatus stat;
	stat = plugin.registerCommand( "molecule4", 
								   Molecule4Cmd::creator,
								   Molecule4Cmd::newSyntax );
	if( !stat )
	{
		MGlobal::displayError( MString( "registerCommand failed: " ) + stat.errorString() );
		return stat;
	}

	stat = plugin.registerNode( "molecule4",
								Molecule4Node::id,
								Molecule4Node::creator,
								Molecule4Node::initialize );
	if( !stat )
	{
		MGlobal::displayError( MString( "registerNode failed: " ) + stat.errorString() );
		return stat;
	}

	stat = plugin.registerUI( "molecule4CreateUI", "molecule4DeleteUI");
	if( !stat ) 
	{
		MGlobal::displayError( MString( "registerUI failed: " ) + stat.errorString() );
		return stat;
	}

	return stat;
}

MStatus uninitializePlugin( MObject obj )
{
	MFnPlugin plugin( obj );

	MStatus	stat;
	stat = plugin.deregisterCommand( "molecule4" );
	if ( !stat )
	{
		MGlobal::displayError( MString( "deregisterCommand failed: " ) + stat.errorString() );
		return stat;
	}
	
	stat = plugin.deregisterNode( Molecule4Node::id );
	if ( !stat )
	{
		MGlobal::displayError( MString( "deregisterNode failed: " ) + stat.errorString() );
		return stat;
	}

	return stat;
}