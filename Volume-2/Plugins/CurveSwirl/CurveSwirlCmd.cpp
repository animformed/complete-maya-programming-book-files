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

class CurveSwirlCmd : public MPxCommand 
{
public:
	virtual MStatus	doIt ( const MArgList& );
	virtual MStatus	redoIt();
	virtual MStatus	undoIt();
	virtual bool isUndoable() const { return true; }

	static void *creator() { return new CurveSwirlCmd; }
	static MSyntax newSyntax();

private:
	// Command options
	MDistance radius;
	int nSpans;
	int nRevolutions;
	int degree;
	
	// Curve object created
	MObject curveTransform;
	
	void genCVs( const double radius, const int nCVs, 
				 const int revolutions, MPointArray &cvs );
};

const char *radiusFlag = "-r", *radiusLongFlag = "-radius";
const char *spansFlag = "-s", *spansLongFlag = "-spans";
const char *revolutionsFlag = "-rv", *revolutionsLongFlag = "-revolutions";
const char *degreeFlag = "-d", *degreeLongFlag = "-degree";

MSyntax CurveSwirlCmd::newSyntax()
{
    MSyntax syntax;

    syntax.addFlag( radiusFlag, radiusLongFlag, MSyntax::kDistance );
    syntax.addFlag( spansFlag, spansLongFlag, MSyntax::kLong );
    syntax.addFlag( revolutionsFlag, revolutionsLongFlag, MSyntax::kLong );
    syntax.addFlag( degreeFlag, degreeLongFlag, MSyntax::kLong );
    
	syntax.enableQuery( false );
	syntax.enableEdit( false );

	return syntax;
}

MStatus CurveSwirlCmd::doIt ( const MArgList &args )
{
	MStatus stat;
	
	// Initialize to default values
	radius.setValue( 1.0 );
	nSpans = 30;
	nRevolutions = 5;
	degree = 3;
	
	// Get the options from the command line
	MArgDatabase argData( syntax(), args, &stat );
	if( !stat )
		return stat;

	if( argData.isFlagSet( radiusFlag ) )
		argData.getFlagArgument( radiusFlag, 0, radius );
	
	if( argData.isFlagSet( spansFlag ) )
		argData.getFlagArgument( spansFlag, 0, nSpans );

	if( argData.isFlagSet( revolutionsFlag ) )
		argData.getFlagArgument( revolutionsFlag, 0, nRevolutions );

	if( argData.isFlagSet( degreeFlag ) )
		argData.getFlagArgument( degreeFlag, 0, degree );

	return redoIt();
}

void CurveSwirlCmd::genCVs(
	const double radius,
	const int nCVs,
	const int revolutions,
	MPointArray &cvs
)	
{
	cvs.clear();
		
	double azimIncr = revolutions * 2.0 * M_PI / (nCVs-1);
	double zenIncr = M_PI / (nCVs-1);
	
	MPoint p;
	double azimuth, zenith;
	double sinZenith;
	int cvi;
	
	azimuth = 0.0;
	zenith = 0.0;
	for( cvi=0; cvi < nCVs; cvi++, azimuth += azimIncr, zenith += zenIncr )
	{
		sinZenith = sin(zenith);
			
		p.x = radius * sinZenith * cos(azimuth);
		p.y = radius * cos(zenith);
		p.z = radius * sinZenith * sin(azimuth);
		
		cvs.append( p );
	}
}

MStatus	CurveSwirlCmd::redoIt()
{
	int nCVs = degree + nSpans;
	int multiplicity = degree; // Ensures that the curve begins and ends at first and last cvs
	
	MPointArray cvs;
	genCVs( radius.value(), nCVs, nRevolutions, cvs );	
	
	MDoubleArray knots;	
	int span, m;
	for( span=0; span <= nSpans; span++ )
	{
		knots.append( double(span) );
	
		// First or last knot
		if( span == 0 || span == nSpans )
		{
			// m is initialized to 1 since one knot has already been appended
			// above, that leaves multiplicity-1 knots to be appended
			for( m=1; m < multiplicity; m++ )
				knots.append( double(span) );
		}
	}
	
	MStatus stat;
	MFnNurbsCurve curveFn;
	curveTransform = curveFn.create( cvs, knots, degree, MFnNurbsCurve::kOpen, false, false, MObject::kNullObj, &stat );
	
	return stat;	
}

MStatus	CurveSwirlCmd::undoIt()
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
	stat = plugin.registerCommand( "curveSwirl", 
								   CurveSwirlCmd::creator,
								   CurveSwirlCmd::newSyntax );
	if ( !stat )
		stat.perror( "registerCommand failed");

	return stat;
}

MStatus uninitializePlugin( MObject obj )
{
	MFnPlugin plugin( obj );

	MStatus	stat;
	stat = plugin.deregisterCommand( "curveSwirl" );
	if ( !stat )
		stat.perror( "deregisterCommand failed" );

	return stat;
}