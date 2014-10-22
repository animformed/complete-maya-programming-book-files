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

class Posts4Cmd : public MPxCommand 
{
public:
	virtual MStatus	doIt ( const MArgList& );
	static void *creator() { return new Posts4Cmd; }
	static MSyntax newSyntax();
};

const char *numberFlag = "-n", *numberLongFlag = "-number";
const char *radiusFlag = "-r", *radiusLongFlag = "-radius";
const char *heightFlag = "-he", *heightLongFlag = "-height";
const char *helpFlag = "-h", *helpLongFlag = "-help";

MSyntax Posts4Cmd::newSyntax()
{
    MSyntax syntax;

    syntax.addFlag( numberFlag, numberLongFlag, MSyntax::kLong );
    syntax.addFlag( radiusFlag, radiusLongFlag, MSyntax::kDouble );
	syntax.addFlag( heightFlag, heightLongFlag, MSyntax::kDouble );
	syntax.addFlag( helpFlag, helpLongFlag );

	return syntax;
}

const char *helpText =
"\nThe posts4 command is used to create a series of posts(cylinders) along all the selected curves."
"\nIt is possible to set the number of posts, as well as their width and height."
"\nFor further details consult the help documentation."
"\nFor quick help use: help posts4";

MStatus Posts4Cmd::doIt ( const MArgList &args )
{ 
	int nPosts = 5;
	double radius = 0.5;
	double height = 5.0;

	MArgDatabase argData( syntax(), args );

    if( argData.isFlagSet( numberFlag ) )
		argData.getFlagArgument( numberFlag, 0, nPosts );

    if( argData.isFlagSet( radiusFlag ) )
		argData.getFlagArgument( radiusFlag, 0, radius );

    if( argData.isFlagSet( heightFlag ) )
		argData.getFlagArgument( heightFlag, 0, height );

    if( argData.isFlagSet( helpFlag ) )
		{
		setResult( helpText );
		return MS::kSuccess;
		}

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
	stat = plugin.registerCommand( "posts4", Posts4Cmd::creator, Posts4Cmd::newSyntax );
	if ( !stat )
		stat.perror( "registerCommand failed");

	return stat;
}

MStatus uninitializePlugin( MObject obj )
{
	MFnPlugin plugin( obj );

	MStatus	stat;
	stat = plugin.deregisterCommand( "posts4" );
	if ( !stat )
		stat.perror( "deregisterCommand failed" );

	return stat;
}
