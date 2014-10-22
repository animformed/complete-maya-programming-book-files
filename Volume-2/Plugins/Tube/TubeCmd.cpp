//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#include <maya/MPxCommand.h>
#include <maya/MGlobal.h>
#include <maya/MFnPlugin.h>
#include <maya/MPoint.h>
#include <maya/MPointArray.h>
#include <maya/MFnNurbsSurface.h>
#include <maya/MDGModifier.h>
#include <maya/MSyntax.h>
#include <maya/MArgDatabase.h>
#include <maya/MDistance.h>
#include <maya/MFnDagNode.h>
#include <maya/MFnTransform.h>
#include <math.h>

class TubeCmd : public MPxCommand 
{
public:
	virtual MStatus	doIt( const MArgList& );
	virtual MStatus redoIt();
	virtual MStatus undoIt();
	virtual bool isUndoable() const { return true; }
	
	static void *creator() { return new TubeCmd; }
	static MSyntax newSyntax();
	
private:
	// Command options
	MDistance innerRadius, outerRadius;
	MDistance height;
	int circumSpans, heightSpans;
	int degree;
			
	// Surfaces created
	MObjectArray objTransforms;
	
	
	enum Part { INNER_SIDE, OUTER_SIDE, 
				TOP_CAP, BOTTOM_CAP,
				// ... add other parts here
				N_PARTS };
	MObject createPart( const Part part );
	
};

const char *innerRadiusFlag = "-ir", *innerRadiusLongFlag = "-innerRadius";
const char *outerRadiusFlag = "-or", *outerRadiusLongFlag = "-outerRadius";
const char *heightFlag = "-h", *heightLongFlag = "-height";
const char *circumSpansFlag = "-cs", *circumSpansLongFlag = "-circumferenceSpans";
const char *heightSpansFlag = "-hs", *heightSpansLongFlag = "-heightSpans";
const char *degreeFlag = "-d", *degreeLongFlag = "-degree";


MSyntax TubeCmd::newSyntax()
{
    MSyntax syntax;

	syntax.addFlag( innerRadiusFlag, innerRadiusLongFlag, MSyntax::kDistance );
	syntax.addFlag( outerRadiusFlag, outerRadiusLongFlag, MSyntax::kDistance );
	syntax.addFlag( heightFlag, heightLongFlag, MSyntax::kDistance );
	syntax.addFlag( circumSpansFlag, circumSpansLongFlag, MSyntax::kLong );
	syntax.addFlag( heightSpansFlag, heightSpansLongFlag, MSyntax::kLong );
	syntax.addFlag( degreeFlag, degreeLongFlag, MSyntax::kLong );
	
	syntax.enableQuery( false );
	syntax.enableEdit( false );

	return syntax;
}

MObject TubeCmd::createPart( const Part part )
{
	int uSpans, vSpans;
	double angleDir;
	double radius = outerRadius.value();
	double innerRad = innerRadius.value();
	double elevation;
	
	switch( part )
	{
		case INNER_SIDE:
			uSpans = circumSpans;
			vSpans = heightSpans;
			angleDir = 1.0;
			radius = innerRadius.value();
			break;
			
		case OUTER_SIDE:
			uSpans = circumSpans;
			vSpans = heightSpans;
			angleDir = -1.0;
			break;
			
		case TOP_CAP:
			uSpans = circumSpans;
			vSpans = 1;
			angleDir = -1.0;
			elevation = height.value();
			break;
			
		case BOTTOM_CAP:
			uSpans = circumSpans;
			vSpans = 1;
			angleDir = 1.0;
			elevation = 0.0;
			break;
	}
	
	// Setup control vertices
	// 
	MPointArray cvs;
	
	int nCVsU = degree + uSpans;
	int nCVsV = degree + vSpans;
	
	MPoint pt;
	double angleIncr = angleDir * (M_PI * 2.0) / nCVsU;
	double vStart, vIncr;
	if( part == INNER_SIDE || part == OUTER_SIDE )
	{
		vStart = 0.0;
		vIncr = height.value() / (nCVsV-1);
	}
	else
	{
		vStart = radius;
		vIncr = (innerRad - radius) / (nCVsV-1);
	}
		
	double angle, v;
	int i, j;
	for( i=0, angle=0.0; i < nCVsU; i++, angle+=angleIncr )
	{		
		for( j=0, v=vStart; j < nCVsV; j++, v+=vIncr )
		{
			switch( part )
			{
				case INNER_SIDE:
				case OUTER_SIDE:
					pt.x = radius * cos(angle);
					pt.z = radius * sin(angle);
					pt.y = v;
					break;
			
				case TOP_CAP:
				case BOTTOM_CAP:
					pt.x = v * cos(angle);
					pt.z = v * sin(angle);
					pt.y = elevation;
					break;				
			}
			
			cvs.append( pt );
		}
	}
	
	// Duplicate the "degree" number of columns of initial control vertices
	int nDuplicates = degree * nCVsV;
	for( i=0; i < nDuplicates; i++ )
		cvs.append( cvs[i] );
					
	// Setup u knot vector
	//
	MDoubleArray knotsU;
	int nCVsAlongU = nCVsU + degree;
	int nSpans = nCVsAlongU - degree;
	int nKnots = nSpans + 2 * degree - 1;
	int ki;
	for( i=-(degree-1), ki=0; ki < nKnots; i++, ki++ ) 
		knotsU.append( double(i) );
		
	// Setup v knot vector
	//
	const int multiplicity = degree;
	MDoubleArray knotsV;	
	int span, m;
	for( span=0; span <= vSpans; span++ )
	{
		knotsV.append( double(span) );
	
		// First or last knot
		if( span == 0 || span == vSpans )
		{
			// m is initialized to 1 since one knot has already been appended
			// above, that leaves multiplicity-1 knots to be appended
			for( m=1; m < multiplicity; m++ )
				knotsV.append( double(span) );
		}
	}

	// Create the surface
	// 
	MStatus stat;
	MFnNurbsSurface surfaceFn;
	MObject objTransform = surfaceFn.create( cvs, knotsU, knotsV, degree, degree, 
						 MFnNurbsSurface::kPeriodic, MFnNurbsSurface::kOpen,
						 false, MObject::kNullObj, &stat );
	if( !stat )
		stat.perror( "Unable to create mesh" );

	return objTransform;
}

MStatus TubeCmd::doIt( const MArgList &args )
{
	MStatus stat;
	
	// Initialize options to default values
	innerRadius.setValue( 0.5 );
	outerRadius.setValue( 1.0 );
	height.setValue( 3.0 );
	circumSpans = 6;
	heightSpans = 2;
	degree = 3;
		
	// Get the options from the command line
	MArgDatabase argData( syntax(), args, &stat );
	if( !stat )
		return stat;

	if( argData.isFlagSet( innerRadiusFlag ) )
		argData.getFlagArgument( innerRadiusFlag, 0, innerRadius );
	
	if( argData.isFlagSet( outerRadiusFlag ) )
		argData.getFlagArgument( outerRadiusFlag, 0, outerRadius );

	if( argData.isFlagSet( heightFlag ) )
		argData.getFlagArgument( heightFlag, 0, height );

	if( argData.isFlagSet( circumSpansFlag ) )
		argData.getFlagArgument( circumSpansFlag, 0, circumSpans );

	if( argData.isFlagSet( heightSpansFlag ) )
		argData.getFlagArgument( heightSpansFlag, 0, heightSpans );

	if( argData.isFlagSet( degreeFlag ) )
		argData.getFlagArgument( degreeFlag, 0, degree );
		
	return redoIt();
}

MStatus	TubeCmd::redoIt()
{
	MStatus stat;
	MString cmd;
	
	objTransforms.clear();
	
	MFnDagNode dagFn;
	MObject objTransform;
	unsigned int i;
	for( i=0; i < N_PARTS; i++ )
	{
		objTransform = createPart( (Part)i );
		objTransforms.append( objTransform );
		
		MFnDagNode dagFn( objTransform );
		
		// Put surface into the initial shading group
		cmd = "sets -e -fe initialShadingGroup ";
		cmd += dagFn.name();
		MGlobal::executeCommand( cmd );
	}		

	// Create the parent "tube" transform
	//
	MFnTransform transformFn;
	MObject tubeTransform;
	tubeTransform = transformFn.create();
	transformFn.setName( "tube" );
	
	// Parent all the surfaces to the "tube" transform
	//
	for( i=0; i < objTransforms.length(); i++ )
		transformFn.addChild( objTransforms[i] );
	
	// Add "tube" transform to the list
	objTransforms.append( tubeTransform );
	
	// Select the "tube" transform
	//MGlobal::select( tubeTransform, MGlobal::kReplaceList  );
	cmd = MString( "select -r " ) + transformFn.name();
	MGlobal::executeCommand( cmd );
	
	return MS::kSuccess;
}


MStatus	TubeCmd::undoIt()
{
	MDGModifier dgMod;
	MFnDagNode dagFn;
	MObject child;
	
	unsigned int i;
	for( i=0; i < objTransforms.length(); i++ )
	{
		// N.B. It is important to delete the child shape before
		// the transform node, otherwise Maya will crash.
		dagFn.setObject( objTransforms[i] );
		child = dagFn.child( 0 );
		if( !child.isNull() )
			dgMod.deleteNode( child );
		
		dgMod.deleteNode( objTransforms[i] );
	}
	
	return dgMod.doIt();
}

MStatus initializePlugin( MObject obj )
{
	MFnPlugin plugin( obj, "David Gould", "1.0" );

	MStatus stat;
	stat = plugin.registerCommand( "tube", 
								   TubeCmd::creator,
								   TubeCmd::newSyntax );
	if ( !stat )
		MGlobal::displayError( MString( "registerCommand failed: " ) + stat.errorString() );

	return stat;
}

MStatus uninitializePlugin( MObject obj )
{
	MFnPlugin plugin( obj );

	MStatus	stat;
	stat = plugin.deregisterCommand( "tube" );
	if ( !stat )
		MGlobal::displayError( MString( "deregisterCommand failed: " ) + stat.errorString() );

	return stat;
}