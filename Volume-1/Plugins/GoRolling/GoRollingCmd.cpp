#include "GoRollingCmd.h"
#include <maya/MSelectionList.h>
#include <maya/MGlobal.h>
#include <maya/MDagPath.h>
#include <maya/MFnTransform.h>
#include <maya/MItSelectionList.h>
#include <maya/MPlug.h>

MStatus GoRollingCmd::doIt ( const MArgList &args )
{ 
	MStatus stat;

	// Get a list of currently selected objects
	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	MDagPath dagPath;
	MFnTransform transformFn;
	MString name;
	
	// Iterate over all the transforms
	MItSelectionList iter( selection, MFn::kTransform );
	for ( ; !iter.isDone(); iter.next() )
		{								
			iter.getDagPath( dagPath );
			transformFn.setObject( dagPath );

			MObject rollNodeObj = dgMod.createNode( "RollingNode" );
			MFnDependencyNode depNodeFn( rollNodeObj );

			dgMod.connect( transformFn.findPlug( "translateX" ), depNodeFn.findPlug( "distance") );
			dgMod.connect( transformFn.findPlug( "translateY" ), depNodeFn.findPlug( "radius" ) );

			dgMod.connect( depNodeFn.findPlug( "rotation" ), transformFn.findPlug( "rotateZ" ) );
		}

	return redoIt();
}

MStatus GoRollingCmd::undoIt()
{
return dgMod.undoIt();
}

MStatus GoRollingCmd::redoIt()
{
return dgMod.doIt();
}

