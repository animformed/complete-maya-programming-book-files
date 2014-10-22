//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#include <maya/MSimple.h>
#include <maya/MGlobal.h>
#include <maya/MItSelectionList.h>
#include <maya/MPoint.h>
#include <maya/MPointArray.h>
#include <maya/MVector.h>
#include <maya/MFnNurbsCurve.h>
#include <maya/MDagPath.h>
#include <maya/MDistance.h>
#include <maya/MSyntax.h>
#include <maya/MArgDatabase.h>
#include <math.h>

class CurveStarCmd : public MPxCommand 
{
public:
	virtual MStatus	doIt ( const MArgList& );
	virtual MStatus	redoIt();
	virtual MStatus	undoIt();
	virtual bool isUndoable() const { return true; }

	static void *creator() { return new CurveStarCmd; }
	static MSyntax newSyntax();

private:
	// Command options
	MDistance outerRadius;
	MDistance innerRadius;
	int spikes;
	int degree;
	int form;
	
	// Curve object created
	MObject curveTransform;
};

const char *outerRadiusFlag = "-or", *outerRadiusLongFlag = "-outerRadius";
const char *innerRadiusFlag = "-ir", *innerRadiusLongFlag = "-innerRadius";
const char *spikesFlag = "-s", *spikesLongFlag = "-spikes";
const char *degreeFlag = "-d", *degreeLongFlag = "-degree";
const char *formFlag = "-f", *formLongFlag = "-form";


MSyntax CurveStarCmd::newSyntax()
{
    MSyntax syntax;

    syntax.addFlag( outerRadiusFlag, outerRadiusLongFlag, MSyntax::kDistance );
    syntax.addFlag( innerRadiusFlag, innerRadiusLongFlag, MSyntax::kDistance );
    syntax.addFlag( spikesFlag, spikesLongFlag, MSyntax::kLong );
    syntax.addFlag( degreeFlag, degreeLongFlag, MSyntax::kLong );
    syntax.addFlag( formFlag, formLongFlag, MSyntax::kLong );
    
	syntax.enableQuery( false );
	syntax.enableEdit( false );

	return syntax;
}

MStatus CurveStarCmd::doIt ( const MArgList &args )
{
	MStatus stat;
	
	// Initialize to default values
	outerRadius.setValue( 1.0 );
	innerRadius.setValue( 0.5 );
	spikes = 5;
	degree = 1;
	form = 2;
	
	// Get the options from the command line
	MArgDatabase argData( syntax(), args, &stat );
	if( !stat )
		return stat;

	if( argData.isFlagSet( outerRadiusFlag ) )
		argData.getFlagArgument( outerRadiusFlag, 0, outerRadius );
	
	if( argData.isFlagSet( innerRadiusFlag ) )
		argData.getFlagArgument( innerRadiusFlag, 0, innerRadius );

	if( argData.isFlagSet( spikesFlag ) )
		argData.getFlagArgument( spikesFlag, 0, spikes );

	if( argData.isFlagSet( degreeFlag ) )
		argData.getFlagArgument( degreeFlag, 0, degree );
		
	if( argData.isFlagSet( formFlag ) )
		argData.getFlagArgument( formFlag, 0, form );

	return redoIt();
}


MStatus	CurveStarCmd::redoIt()
{	
	// Generate control vertices
	MPointArray cvs;
		
	// Create spikes
	int nSpikeCVs = 2 * spikes;
	double angleIncr = M_PI / spikes;
	MPoint p;
	double angle;
	double r;
	int i;
	for( i=0, angle=0.0;
		 i < nSpikeCVs; 
		 i++, angle+=angleIncr )
	{	
		r = (i & 1) ? outerRadius.value() : innerRadius.value();
		
		p.x = r * cos(angle);
		p.y = 0.0;
		p.z = r * sin(angle);
		
		cvs.append( p );
	}
			
	// Duplicate the "degree" number of initial control vertices
	for( i=0; i < degree; i++ )
		cvs.append( cvs[i] );
		
		
	// Generate knots
	MDoubleArray knots;
	
	int nSpans = cvs.length() - degree;
	int nKnots = nSpans + 2 * degree - 1;
	int ki;
	for( i=-(degree-1), ki=0; ki < nKnots; i++, ki++ ) 
		knots.append( double(i) );
		
	MFnNurbsCurve::Form f = (form == 0) ? MFnNurbsCurve::kOpen : 
			(( form == 1) ? MFnNurbsCurve::kClosed : MFnNurbsCurve::kPeriodic );
		
	MStatus stat;
	MFnNurbsCurve curveFn;
	curveTransform = curveFn.create( cvs, knots, degree, f, false, false, MObject::kNullObj, &stat );
	
	return stat;	
}

MStatus	CurveStarCmd::undoIt()
{
	MFnDagNode dagFn( curveTransform );
	MObject child;
	
	// N.B. It is important to delete the child shape before
	// the transform node, otherwise Maya will crash.
	child = dagFn.child(0);
	MGlobal::deleteNode( child );
	MGlobal::deleteNode( curveTransform );
	
	return MS::kSuccess;
}

MStatus initializePlugin( MObject obj )
{
	MFnPlugin plugin( obj, "David Gould", "1.0" );

	MStatus stat;
	stat = plugin.registerCommand( "curveStar", 
								   CurveStarCmd::creator,
								   CurveStarCmd::newSyntax );
	if ( !stat )
		stat.perror( "registerCommand failed");

	return stat;
}

MStatus uninitializePlugin( MObject obj )
{
	MFnPlugin plugin( obj );

	MStatus	stat;
	stat = plugin.deregisterCommand( "curveStar" );
	if ( !stat )
		stat.perror( "deregisterCommand failed" );

	return stat;
}