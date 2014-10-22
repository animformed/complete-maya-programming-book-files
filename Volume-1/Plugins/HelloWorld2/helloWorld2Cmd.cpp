//
// Copyright (C) 2001 David Gould 
// 
#include <maya/MPxCommand.h>
#include <maya/MGlobal.h>
#include <maya/MFnPlugin.h>

class HelloWorld2Cmd : public MPxCommand 
{
public:
	virtual MStatus	doIt ( const MArgList& ) { MGlobal::displayInfo( "Hello World\n" ); return MS::kSuccess; }
	static void *creator() { return new HelloWorld2Cmd; }
};

MStatus initializePlugin( MObject obj )
{
	MFnPlugin plugin( obj, "David Gould", "1.0" );

	MStatus stat;
	stat = plugin.registerCommand( "helloWorld2", HelloWorld2Cmd::creator );
	if ( !stat )
		stat.perror( "registerCommand failed");

	return stat;
}

MStatus uninitializePlugin( MObject obj )
{
	MFnPlugin plugin( obj );

	MStatus	stat;
	stat = plugin.deregisterCommand( "helloWorld2" );
	if ( !stat )
		stat.perror( "deregisterCommand failed" );

	return stat;
}
