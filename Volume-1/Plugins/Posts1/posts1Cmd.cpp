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

class Posts1Cmd : public MPxCommand 
{
public:
	virtual MStatus	doIt ( const MArgList& );
	static void *creator() { return new Posts1Cmd; }
};

MStatus Posts1Cmd::doIt ( const MArgList & )
{ 
	const int nPosts = 5;
	const double radius = 0.5;
	const double height = 5.0;

	// Get a list of currently selected objects
	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	MDagPath dagPath;
	MFnNurbsCurve curveFn;
	double heightRatio = height / radius;

	// Iterate over the nurbs curves
	MItSelectionList iter( selection, MFn::kNurbsCurve );
	for ( ; !iter.isDone(); iter.next() )
		{								
			// Get the curve and attach it to the function set
			iter.getDagPath( dagPath );
			curveFn.setObject( dagPath );

			// Get the domain of the curve, i.e. its start and end parametric values
			double tStart, tEnd;
			curveFn.getKnotDomain( tStart, tEnd );

			MPoint pt;
			int i;
			double t;
			double tIncr = (tEnd - tStart) / (nPosts - 1);
			for( i=0, t=tStart; i < nPosts; i++, t += tIncr )
				{
				// Get point along curve at parametric position t 
				curveFn.getPointAtParam( t, pt, MSpace::kWorld );
				pt.y += 0.5 * height;

				MGlobal::executeCommand( MString( "cylinder -pivot ") + pt.x + " " + pt.y + " " + pt.z 
														  + " -radius " + radius + " -axis 0 1 0 -heightRatio " + heightRatio  );
				}
		}				

	return MS::kSuccess;
}

MStatus initializePlugin( MObject obj )
{
	MFnPlugin plugin( obj, "David Gould", "1.0" );

	MStatus stat;
	stat = plugin.registerCommand( "posts1", Posts1Cmd::creator );
	if ( !stat )
		stat.perror( "registerCommand failed");

	return stat;
}

MStatus uninitializePlugin( MObject obj )
{
	MFnPlugin plugin( obj );

	MStatus	stat;
	stat = plugin.deregisterCommand( "posts1" );
	if ( !stat )
		stat.perror( "deregisterCommand failed" );

	return stat;
}
