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
#include <maya/MVector.h>
#include <maya/MFnNurbsCurve.h>
#include <maya/MDagPath.h>

DeclareSimpleCommand( curveInfo2, "David Gould", "1.0" );

MStatus curveInfo2::doIt( const MArgList& args )
{
	MStatus stat = MS::kSuccess;

	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	MDagPath dagPath;
	MObject component;
	
	const int nSegs = 10;
	double start, end, t, tIncr;
	int seg;
	MPoint pt;
	MVector norm, tang;
	
	MString txt;
	MItSelectionList iter( selection );
	for ( ; !iter.isDone(); iter.next() )
	{								
		iter.getDagPath( dagPath, component );
		
		MFnNurbsCurve curveFn( dagPath, &stat );
		if( stat )
		{
			txt += dagPath.fullPathName() + "\n";
			
			curveFn.getKnotDomain( start, end );
			tIncr = (end - start) / nSegs;
			
			for( seg=0, t=start; seg < (nSegs+1); seg++, t+=tIncr )
			{
				curveFn.getPointAtParam( t, pt, MSpace::kWorld );
				norm = curveFn.normal( t, MSpace::kWorld );
				tang = curveFn.tangent( t, MSpace::kWorld );
				
				txt += MString("Segment: ") + seg + "\n";
				txt += MString("Position: (") + pt.x + ", " + pt.y + ", " + pt.z + ")\n";
				txt += MString("Normal: (") + norm.x + ", " + norm.y + ", " + norm.z + ")\n";
				txt += MString("Tangent: (") + tang.x + ", " + tang.y + ", " + tang.z + ")\n";
			}			
		}
	}
	
	MGlobal::displayInfo( txt );

	return MS::kSuccess;
}
