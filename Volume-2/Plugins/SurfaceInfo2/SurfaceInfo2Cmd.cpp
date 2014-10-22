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

DeclareSimpleCommand( surfaceInfo2, "David Gould", "1.0" );

MStatus surfaceInfo2::doIt( const MArgList& args )
{
	MStatus stat = MS::kSuccess;

	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	MDagPath dagPath;
	MObject component;
	
	const int nSegs = 3;
	double startU, endU, startV, endV;
	unsigned int segU, segV;
	double u, v, uIncr, vIncr;
	MPoint pt;
	MVector norm, tangU, tangV;
	
	MString txt;
	MItSelectionList iter( selection );
	for ( ; !iter.isDone(); iter.next() )
	{								
		iter.getDagPath( dagPath, component );
		
		MFnNurbsSurface surfaceFn( dagPath, &stat );
		if( stat )
		{
			txt += dagPath.fullPathName() + "\n";
			
			surfaceFn.getKnotDomain( startU, endU, startV, endV );
			uIncr = (endU - startU) / nSegs;
			vIncr = (endV - startV) / nSegs;
			
			for( segU=0, u=startU; segU < (nSegs+1); segU++, u+=uIncr )
			{
				for( segV=0, v=startV; segV < (nSegs+1); segV++, v+=vIncr )
				{
					surfaceFn.getPointAtParam( u, v, pt, MSpace::kWorld );
					norm = surfaceFn.normal( u, v, MSpace::kWorld );
					norm.normalize();
					surfaceFn.getTangents( u, v, tangU, tangV, MSpace::kWorld );
					tangU.normalize();
					tangV.normalize();
					
					txt += MString("Sample: (") + u + ", " + v + ")\n";
					txt += MString("  Position: (") + pt.x + ", " + pt.y + ", " + pt.z + ")\n";
					txt += MString("  Normal: (") + norm.x + ", " + norm.y + ", " + norm.z + ")\n";
					txt += MString("  Tangent U: (") + tangU.x + ", " + tangU.y + ", " + tangU.z + ")\n";	
					txt += MString("  Tangent V: (") + tangV.x + ", " + tangV.y + ", " + tangV.z + ")\n";	
				}
			}
		}
	}
	
	MGlobal::displayInfo( txt );

	return MS::kSuccess;
}