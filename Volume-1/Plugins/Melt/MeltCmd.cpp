#include "MeltCmd.h"
#include "MeltNode.h"
#include <maya/MSelectionList.h>
#include <maya/MGlobal.h>
#include <maya/MDagPath.h>
#include <maya/MFnTransform.h>
#include <maya/MItSelectionList.h>
#include <maya/MPlug.h>
#include <maya/MPlugArray.h>
#include <maya/MTime.h>
#include <maya/MAnimControl.h>
#include <assert.h>

MStatus MeltCmd::doIt ( const MArgList &args )
{ 
MStatus stat;

// Get a list of currently selected objects
MSelectionList selection;
MGlobal::getActiveSelectionList( selection );

MTime startTime = MAnimControl::minTime();
MTime endTime = MAnimControl::maxTime();

// Iterate over all the nurbs surfaces nodes
MItSelectionList iter( selection, MFn::kNurbsSurface );
for ( ; !iter.isDone(); iter.next() )
	{								
	// Get the shape node	
	MObject shapeNode;
	iter.getDependNode( shapeNode );
	MFnDependencyNode shapeFn( shapeNode );

	MPlug createPlug = shapeFn.findPlug( "create" );
			
	// Determine the input connections to the create plug
	MPlugArray srcPlugs;
	createPlug.connectedTo( srcPlugs, true, false );
	assert( srcPlugs.length() == 1 );
	MPlug srcPlug = srcPlugs[0];

	// Create new Melt node
	MObject meltNode = dgMod.createNode( MeltNode::id );
	assert( !meltNode.isNull() );
	MFnDependencyNode meltFn( meltNode );
		
	MPlug outputSurfacePlug = meltFn.findPlug( "outputSurface" );
	MPlug inputSurfacePlug = meltFn.findPlug( "inputSurface" );
	
	// Make the connections			
	dgMod.disconnect( srcPlug, createPlug );
	dgMod.connect( srcPlug, inputSurfacePlug );
	dgMod.connect( outputSurfacePlug, createPlug );
	
	static int i = 0;
	MString name = MString("melting") + i++;
	dgMod.renameNode( meltNode, name );

	//MString n( meltFn.name() );
	//MGlobal::displayInfo( "\nMelt node: " + name + " " + shapeFn.name() );

	MString cmd;
	cmd = MString("setKeyframe -at amount -t ") + startTime.value() + " -v " + 0.0 + " " + name;
	dgMod.commandToExecute( cmd );

	//MGlobal::displayInfo( cmd );

	cmd = MString("setKeyframe -at amount -t ") + endTime.value() + " -v " + 1.0 + " " + name;
	dgMod.commandToExecute( cmd );

	//MGlobal::displayInfo( cmd );

/*
	//MPlug interestPlug = meltFn.findPlug( "isHistoricallyInteresting 
	// Setup animation
	MPlug amountPlug = meltFn.findPlug( "amount" );

	MAnimControl::setCurrentTime( startTime );
	amountPlug.setValue( double(0.0) );
	MAnimControl::setCurrentTime( endTime );
	amountPlug.setValue( double(1.0) );
*/
	}

/*
MAnimControl::setCurrentTime( curTime );
MAnimControl::setAutoKeyMode( autoKeyOn );
*/

return redoIt();
}

MStatus MeltCmd::undoIt()
{
return dgMod.undoIt();
}

MStatus MeltCmd::redoIt()
{
return dgMod.doIt();
}

