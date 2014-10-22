//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#include <maya/MStatus.h>
#include <maya/MPointArray.h>
#include <maya/MIntArray.h>
#include <maya/MFloatArray.h>

MStatus genBall( 
	const MPoint &centre,
	const double radius,
	const unsigned nSegs,
	
	int &nPolys,
	MPointArray &verts,
	MIntArray &polyCounts,
	MIntArray &polyConnects,
	
	const bool genUVs,
	MFloatArray &uCoords,
	MFloatArray &vCoords,
	MIntArray &fvUVIDs
);

MStatus genRod(
	const MPoint &p0,
	const MPoint &p1,
	const double radius,
	const unsigned nSegs,
	
	int &nPolys,
	MPointArray &verts,
	MIntArray &polyCounts,
	MIntArray &polyConnects,

	const bool genUVs,
	MFloatArray &uCoords,
	MFloatArray &vCoords,
	MIntArray &fvUVIDs
);
