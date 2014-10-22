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
#include <maya/MFnNurbsCurve.h>
#include <maya/MDagPath.h>

DeclareSimpleCommand( curveInfo1, "David Gould", "1.0" );

MStatus curveInfo1::doIt( const MArgList& args )
{
	MStatus stat = MS::kSuccess;

	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	MDagPath dagPath;
	MObject component;
	
	const char *formTxt[] = { "Invalid", "Open", "Closed", "Periodic", "Last" };
	double start, end;
	int i, nCVs, nKnots;
	MPoint pt;
	double knot;
	
	MString txt;
	MItSelectionList iter( selection );
	for ( ; !iter.isDone(); iter.next() )
	{								
		iter.getDagPath( dagPath, component );
		
		MFnNurbsCurve curveFn( dagPath, &stat );
		if( stat )
		{
			txt += dagPath.fullPathName() + "\n";
			
			txt += MString("Length: ") + curveFn.length() + "\n";
			txt += MString("Degree: ") + curveFn.degree() + "\n";
			txt += MString("Form: ") + formTxt[ curveFn.form() ] + "\n";
			txt += MString("Spans: ") + curveFn.numSpans() + "\n";
			
			curveFn.getKnotDomain( start, end );
			txt += MString("MinValue: ") + start + " MaxValue: " + end + "\n";
			
			nCVs = curveFn.numCVs();
			txt += MString("CVs: ") + nCVs + "\n";
			for( i=0; i < nCVs; i++ )
			{
				curveFn.getCV( i, pt, MSpace::kWorld );
				txt += MString(" (") + pt.x + ", " + pt.y + ", " + pt.z + ")";
			}
			txt += "\n";
			
			nKnots = curveFn.numKnots();
			txt += MString("Knots: ") + nKnots + "\n";
			for( i=0; i < nKnots; i++ )
			{
				knot = curveFn.knot( i );
				txt += MString(" ") + knot;
			}
			txt += "\n";			
		}
	}
	
	MGlobal::displayInfo( txt );

	return MS::kSuccess;
}
