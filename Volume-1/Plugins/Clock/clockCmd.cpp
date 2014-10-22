//
// Copyright (C) 2001 David Gould 
// 
#include <maya/MPxCommand.h>
#include <maya/MGlobal.h>
#include <maya/MFnPlugin.h>
#include <maya/MSelectionList.h>
#include <maya/MItSelectionList.h>
#include <maya/MDagPath.h>
#include <maya/MFnNurbsCurve.h>
#include <maya/MPoint.h>
#include <maya/MArgList.h>
#include <maya/MSyntax.h>
#include <maya/MArgDatabase.h>
#include <maya/MDGModifier.h>
#include <maya/MFnTransform.h>
#include <maya/MVector.h>
#include <maya/MEulerRotation.h>
#include <math.h>

class ClockCmd : public MPxCommand 
{
public:
	virtual MStatus	doIt ( const MArgList& );
	virtual MStatus undoIt();
 	virtual MStatus redoIt();
	virtual bool isUndoable() const;

	static void *creator() { return new ClockCmd; }
	static MSyntax newSyntax();

private:
	bool isQuery;	// Are we querying rather than editing?
	int prevTime, newTime;	// Previous time and the new time
	MDagPath hourHandPath, minuteHandPath;	// Paths to hour and minute hand objects

	int getTime();
	void setTime( const int time );
};

const char *timeFlag = "-t", *timeLongFlag = "-time";

MSyntax ClockCmd::newSyntax()
{
    MSyntax syntax;

    syntax.addFlag( timeFlag, timeLongFlag, MSyntax::kLong );
	syntax.enableQuery(true);
	syntax.enableEdit(true);

	return syntax;
}

const double PI = 3.1415926535;
const double TWOPI = 2.0 * PI;

MStatus ClockCmd::doIt ( const MArgList &args )
{ 
	MStatus stat;
	MArgDatabase argData( syntax(), args, &stat );
	if( !stat )
		return stat;

   	isQuery = argData.isQuery();

	if( argData.isFlagSet( timeFlag ) &&  !isQuery )
		argData.getFlagArgument( timeFlag, 0, newTime );

	// Get a list of currently selected objects
	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	MDagPath dagPath;
	MFnTransform transformFn;
	MString name;
	
	// Iterate over the transforms
	MItSelectionList iter( selection, MFn::kTransform );
	for ( ; !iter.isDone(); iter.next() )
		{								
			iter.getDagPath( dagPath );
			transformFn.setObject( dagPath );

			name = transformFn.name();
			if( name == MString("hour_hand") )
				hourHandPath = dagPath;
			else
				{
				if( name == MString("minute_hand") )
					minuteHandPath = dagPath;
				}
		}

	// Neither hour nor minute hand selected
	if( !hourHandPath.isValid() || !minuteHandPath.isValid() )
		{
		MGlobal::displayError( "Select hour and minute hands" );
		return MS::kFailure;
		}

	prevTime = getTime();

	if( isQuery )
		{
		setResult( prevTime );
		return MS::kSuccess;
		}

	return redoIt();
}

MStatus ClockCmd::undoIt()
{
setTime( prevTime );
return MS::kSuccess;
}

MStatus ClockCmd::redoIt()
{
setTime( newTime );
return MS::kSuccess;
}

int ClockCmd::getTime()
{
// Get the time from the rotation
MFnTransform transformFn;
transformFn.setObject( hourHandPath );
MEulerRotation rot;
transformFn.getRotation( rot );
		
// Determine the time and format it
int a = int(-rot.y * (1200.0 / TWOPI));
int time = (a / 100 * 100) + int( floor( (a % 100) * (6.0 / 10.0) + 0.5 ) );

return time;
}

void ClockCmd::setTime( const int time )
{
MFnTransform transformFn;

// Calculate the hour and minutes are
int hour = (time / 100) % 12;
int minutes = time % 100;

// Rotate the hour hand by the required amount
transformFn.setObject( hourHandPath );
transformFn.setRotation( MEulerRotation( MVector( 0.0, hour * (-TWOPI / 12) + minutes * (-TWOPI / 720.0), 0 )  ) );

// Rotate the minute hand by the required amount
transformFn.setObject( minuteHandPath );
transformFn.setRotation( MEulerRotation( MVector( 0.0, minutes * (-TWOPI / 60.0), 0 ) ) );
}

bool ClockCmd::isUndoable() const 
{ 
return isQuery ? false : true;
} 

MStatus initializePlugin( MObject obj )
{
	MFnPlugin plugin( obj, "David Gould", "1.0" );

	MStatus stat;
	stat = plugin.registerCommand( "clock", ClockCmd::creator, ClockCmd::newSyntax );
	if ( !stat )
		stat.perror( "registerCommand failed");

	return stat;
}

MStatus uninitializePlugin( MObject obj )
{
	MFnPlugin plugin( obj );

	MStatus	stat;
	stat = plugin.deregisterCommand( "clock" );
	if ( !stat )
		stat.perror( "deregisterCommand failed" );

	return stat;
}
