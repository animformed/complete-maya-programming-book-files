//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#include "MoleculeUtils.h"
#include <maya/MTypes.h>
#include <maya/MGlobal.h>
#include <maya/MVector.h>
#include <math.h>

int linearIndex( 
	const int r, 
	const int c,
	const int nRows, 
	const int nCols
)
{
	return ((r % nRows) * nCols) + (c % nCols);
}

MStatus genBall( 
	const MPoint &centre,
	const double radius,
	const unsigned int nSegs,
	
	int &nPolys,
	MPointArray &verts,
	MIntArray &polyCounts,
	MIntArray &polyConnects,

	const bool genUVs,
	MFloatArray &uCoords,
	MFloatArray &vCoords,
	MIntArray &fvUVIDs
)	
{
	verts.clear();
	polyCounts.clear();
	polyConnects.clear();

	if( genUVs )
	{
		uCoords.clear();
		vCoords.clear();
		fvUVIDs.clear();
	}
	
	int nAzimuthSegs = nSegs * 2;
	int nZenithSegs = nSegs;
	
	int nAzimuthPts = nAzimuthSegs; // Last point corresponds to the first
	int nZenithPts = nZenithSegs + 1; // Last point is at other pole
	
	double azimIncr = 2.0 * M_PI / nAzimuthSegs;
	double zenIncr = M_PI / nZenithSegs;

	MPoint p;
	double azimuth, zenith;
	double sinZenith;
	int azi, zeni;
	
	for( zeni=0, zenith=0.0; 
		 zeni < nZenithPts; 
		 zeni++, zenith += zenIncr )
	{
		for( azi=0, azimuth=0.0; 
			 azi < nAzimuthPts; 
			 azi++, azimuth += azimIncr )
		{
			sinZenith = sin(zenith);
			
			p.x = radius * sinZenith * cos(azimuth);
			p.y = radius * cos(zenith);
			p.z = radius * sinZenith * sin(azimuth);
		
			verts.append( p );
		}
	}
	
	// Generate the uv coordinates
	int nUCols = nAzimuthSegs + 1;
	int nVRows = nZenithSegs + 1;

	if( genUVs )
	{	
		int nUVCoords = nUCols * nVRows;	
		uCoords.setLength( nUVCoords );
		uCoords.clear();
		vCoords.setLength( nUVCoords );
		vCoords.clear();
		
		float uIncr = 1.0f / nAzimuthSegs;
		float vIncr = 1.0f / nZenithSegs;
		float u, v;
		int ui, vi;
		
		for( vi=0, v=0.0; vi < nVRows; vi++, v += vIncr )
		{
			for( ui=0, u=0.0; ui < nUCols; ui++, u += uIncr )
			{			
				uCoords.append( u );
				vCoords.append( v );
			}
		}			
	}
	
	// Calculate the number of polygons
	nPolys = nAzimuthSegs * nZenithSegs;
	
	// Each face has four points
	polyCounts.setLength( nPolys );
	int i;
	for( i=0; i < nPolys; i++ )
		polyCounts[i] = 4;
	
	// Generate the faces
	for( zeni=0; zeni < nZenithSegs; zeni++ )
	{
		for( azi=0; azi < nAzimuthSegs; azi++ )
		{
			//MGlobal::displayInfo( MString( "\n" ) + azi + "," + zeni );
			
			polyConnects.append( linearIndex( zeni, azi, nZenithPts, nAzimuthPts ) );
			polyConnects.append( linearIndex( zeni, azi+1, nZenithPts, nAzimuthPts ) );
			polyConnects.append( linearIndex( zeni+1, azi+1, nZenithPts, nAzimuthPts ) );
			polyConnects.append( linearIndex( zeni+1, azi, nZenithPts, nAzimuthPts ) );
	
			if( genUVs )
			{
				fvUVIDs.append( linearIndex( zeni, azi, nVRows, nUCols ) );
				fvUVIDs.append( linearIndex( zeni, azi+1, nVRows, nUCols ) );
				fvUVIDs.append( linearIndex( zeni+1, azi+1, nVRows, nUCols ) );
				fvUVIDs.append( linearIndex( zeni+1, azi, nVRows, nUCols ) );
			}
		}
	}	
	
	return MS::kSuccess;
}

MStatus genRod(
	const MPoint &p0,
	const MPoint &p1,
	const double radius,
	const unsigned int nSegs,
	
	int &nPolys,
	MPointArray &verts,
	MIntArray &polyCounts,
	MIntArray &polyConnects,

	const bool genUVs,
	MFloatArray &uCoords,
	MFloatArray &vCoords,
	MIntArray &fvUVIDs
)
{
	verts.clear();
	polyCounts.clear();
	polyConnects.clear();
	if( genUVs )
	{
		uCoords.clear();
		vCoords.clear();
		fvUVIDs.clear();
	}
	
	unsigned int nCirclePts = nSegs; 
	unsigned int nVerts = 2 * nCirclePts;
	
	// Calculate the local axiis of the rod
	MVector vec( p1 - p0 );
	MVector up( 0.0, 1.0, 0.0 );
	MVector xAxis, yAxis, zAxis;
	
	yAxis = vec.normal();
	if( up.isParallel( yAxis, 0.1 ) )
		up = MVector( 1.0, 0.0, 0.0 );
	xAxis = yAxis ^ up;
	zAxis = (xAxis ^ yAxis).normal();
	xAxis = (yAxis ^ zAxis ).normal(); 
	
	// Calculate the vertex positions
	verts.setLength( nVerts );
	double angleIncr = 2.0 * M_PI / nSegs;
	double angle;
	MPoint p;
	double x, z;
	unsigned int i;
	for( i=0, angle=0.0; i < nCirclePts; i++, angle += angleIncr )
	{
		// Calculate position in circle
		x = radius * cos( angle );
		z = radius * sin( angle );
		
		p = p0 + x * xAxis + z * zAxis;

		verts[ i ] = p;
		
		p += vec;

		verts[ i + nCirclePts ] = p;
	}
	
	// Generate the uv coordinates
	int nUCols = nSegs + 1;
	int nVRows = 2;

	if( genUVs )
	{	
		int nUVCoords = nUCols * nVRows;	
		uCoords.setLength( nUVCoords );
		uCoords.clear();
		vCoords.setLength( nUVCoords );
		vCoords.clear();
		
		float uIncr = 1.0f / nSegs;
		float u, v;	
		int ui, vi;
		
		for( vi=0, v=0.0; vi < nVRows; vi++, v += 1.0 )
		{
			for( ui=0, u=0.0; ui < nUCols; ui++, u += uIncr )
			{			
				uCoords.append( u );
				vCoords.append( v );
			}
		}
	}
		
	nPolys = nSegs;
	
	// Generate polycounts
	polyCounts.setLength( nPolys );
	for( i=0; i < polyCounts.length(); i++ )
		polyCounts[i] = 4;
	
	// Generate polyconnects
	polyConnects.setLength( nPolys * 4 );
	polyConnects.clear();
	for( i=0; i < nSegs; i++ )
	{
		polyConnects.append( linearIndex( 0, i, 2, nCirclePts ) );
		polyConnects.append( linearIndex( 0, i+1, 2, nCirclePts ) );
		polyConnects.append( linearIndex( 1, i+1, 2, nCirclePts ) );
		polyConnects.append( linearIndex( 1, i, 2, nCirclePts ) );

		if( genUVs )
		{
			fvUVIDs.append( linearIndex( 0, i, nVRows, nUCols ) );
			fvUVIDs.append( linearIndex( 0, i+1, nVRows, nUCols ) );
			fvUVIDs.append( linearIndex( 1, i+1, nVRows, nUCols ) );
			fvUVIDs.append( linearIndex( 1, i, nVRows, nUCols ) );
		}
	}
		
	return MS::kSuccess;
}