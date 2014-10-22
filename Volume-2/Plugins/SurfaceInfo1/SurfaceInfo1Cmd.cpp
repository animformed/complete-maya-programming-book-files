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
#include <maya/MFnNurbsSurface.h>
#include <maya/MDagPath.h>

DeclareSimpleCommand( surfaceInfo1, "David Gould", "1.0" );

MStatus surfaceInfo1::doIt( const MArgList& args )
{
	MStatus stat = MS::kSuccess;

	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	MDagPath dagPath;
	MObject component;
	
	const char *formTxt[] = { "Invalid", "Open", "Closed", "Periodic", "Last" };
	double startU, endU, startV, endV;
	unsigned int i, j, nCVsU, nCVsV, nKnotsU, nKnotsV;
	MPoint pt;
	MDoubleArray knots[2];
	
	MString txt;
	MItSelectionList iter( selection );
	for ( ; !iter.isDone(); iter.next() )
	{								
		iter.getDagPath( dagPath, component );
		
		MFnNurbsSurface surfaceFn( dagPath, &stat );
		if( stat )
		{
			txt += dagPath.fullPathName() + "\n";
			
			txt += MString("Area: ") + surfaceFn.area() + "\n";
			txt += MString("Degrees: ") + surfaceFn.degreeU() + ", " + surfaceFn.degreeV() + "\n";
			txt += MString("Spans: ") + surfaceFn.numSpansInU() + ", " + surfaceFn.numSpansInV() + "\n";
			txt += MString("Forms: ") + formTxt[ surfaceFn.formInU() ] + ", " + formTxt[ surfaceFn.formInV() ] + "\n";
			
			surfaceFn.getKnotDomain( startU, endU, startV, endV );
			txt += MString("Parametric Ranges: [") + startU + ", " + endU + "], [" + startV + ", " + endV + "]\n";
			
			nCVsU = surfaceFn.numCVsInU();
			nCVsV = surfaceFn.numCVsInV();			
			txt += MString("CVs: ") + nCVsU + ", " + nCVsV + "\n";

			for( i=0; i < nCVsU; i++ )
			{
				for( j=0; j < nCVsV; j++ )
				{
					surfaceFn.getCV( i, j, pt, MSpace::kWorld );
					txt += MString(" (") + pt.x + ", " + pt.y + ", " + pt.z + ")";
				}
			}
			txt += "\n";

			nKnotsU = surfaceFn.numKnotsInU();
			nKnotsV = surfaceFn.numKnotsInV();			
			txt += MString("Knots: ") + nKnotsU + ", " + nKnotsV + "\n";
			
			surfaceFn.getKnotsInU( knots[0] );
			surfaceFn.getKnotsInV( knots[1] );
			
			for( i=0; i < 2; i++ )
			{
				for( j=0; j < knots[i].length(); j++ )
				{
					txt += MString(" ") + knots[i][j];
				}
				txt += "\n";
			}
		}
	}
	
	MGlobal::displayInfo( txt );

	return MS::kSuccess;
}
