//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#include "SelectVolumeLocator1.h"
#include <maya/MGlobal.h>
#include <maya/MPointArray.h>
#include <maya/MFnDagNode.h>

MObject SelectVolumeLocator1::tickle;

const MTypeId SelectVolumeLocator1::typeId( 0x00339 );
const MString SelectVolumeLocator1::typeName( "selectVolumeLocator1" );
const int SelectVolumeLocator1::N_CIRCLEPTS = 20;

SelectVolumeLocator1::SelectVolumeLocator1()
{
	generateCircle( N_CIRCLEPTS );
}

void SelectVolumeLocator1::draw( M3dView &view, 
								 const MDagPath & path,
								 M3dView::DisplayStyle style, 
								 M3dView::DisplayStatus status )
{ 
	view.beginGL(); 
	glPushAttrib( GL_CURRENT_BIT );

	if( spheres.length() )
	{
		unsigned int i;
		for( i=0; i < spheres.length(); i++ )
			drawSphere( spheres[i] );

		// N.B. Must ensure that sphere.length() is at least 1 otherwise
		// the value will wrap around: (0 - 1 = max unsigned). This will
		// result in a really large loop
		//
		for( i=0; i < spheres.length()-1; i++ )
			drawTube( spheres[i], spheres[i+1] );
	}
		
	glPopAttrib();
	view.endGL();       
}

void SelectVolumeLocator1::addSphere( const MPoint &s )
{
	spheres.append( s );
}

void SelectVolumeLocator1::deleteLastSphere()
{
	if( spheres.length() )
		spheres.remove( spheres.length()-1 );
}


void SelectVolumeLocator1::setLastSphereRadius( const double rad )
{
	if( spheres.length() )
		spheres[ spheres.length()-1 ].w = rad;
}


const double M_2PI = M_PI * 2.0;

void SelectVolumeLocator1::generateCircle( const unsigned int nCirclePts )
{
	circlePts.setSizeIncrement( nCirclePts );
   
	MPoint pt;
	const double angleIncr = M_2PI / (nCirclePts - 1);
	double angle = 0.0;
	unsigned int i=0;
	for( ; i < nCirclePts; i++, angle+=angleIncr )
	{
		pt.x = cos( angle );
		pt.y = sin( angle );
		circlePts.append( pt );
	}
}

void SelectVolumeLocator1::drawSphere( const MPoint &s ) const
{
	unsigned int i;
	
	// Y plane
	glBegin(GL_LINE_STRIP);
	for( i=0; i < circlePts.length(); i++ )
		glVertex3d( s.x + s.w * circlePts[i].x, s.y, s.z + s.w * circlePts[i].y );
	glEnd();

	// Z plane
	glBegin(GL_LINE_STRIP);
	for( i=0; i < circlePts.length(); i++ )
		glVertex3d( s.x + s.w * circlePts[i].x, s.y + s.w * circlePts[i].y, s.z );
	glEnd();

	// X plane
	glBegin(GL_LINE_STRIP);
	for( i=0; i < circlePts.length(); i++ )
		glVertex3d( s.x, s.y + s.w * circlePts[i].x, s.z + s.w * circlePts[i].y );
	glEnd();
}

void SelectVolumeLocator1::drawTube( const MPoint &start, 
									 const MPoint &end ) const
{	
	MPoint p0 = start;
	MPoint p1 = end;
	p0.w = p1.w = 1.0;
	
	MVector uAxis, vAxis, wAxis;
	uAxis = p1 - p0;
	uAxis.normalize();
	wAxis = MVector( 0.0, 1.0, 0.0 );
	vAxis = wAxis ^ uAxis;
	wAxis = uAxis ^ vAxis;
	
	unsigned int i;
	MPoint pt;
	
	MPointArray startPts, endPts;
	startPts.setSizeIncrement( circlePts.length() );
	endPts.setSizeIncrement( circlePts.length() );
	for( i=0; i < circlePts.length(); i++ )
	{
		pt = p0 + start.w * circlePts[i].x * vAxis + start.w * circlePts[i].y * wAxis;
		startPts.append( pt );
		
		pt = p1 + end.w * circlePts[i].x * vAxis + end.w * circlePts[i].y * wAxis;
		endPts.append( pt );
	}

	
	// Start plane
	glBegin(GL_LINE_STRIP);
	for( i=0; i < startPts.length(); i++ )
	{
		pt = startPts[i];
		glVertex3d( pt.x, pt.y, pt.z );
	}
	glEnd();
	
	// End plane
	glBegin(GL_LINE_STRIP);
	for( i=0; i < endPts.length(); i++ )
	{
		pt = endPts[i];
		glVertex3d( pt.x, pt.y, pt.z );
	}
	glEnd();
	
	const int incr = startPts.length() / 4;
	
	// Lines joining the two planes
	glBegin(GL_LINES);
	for( i=0; i < endPts.length(); i+=incr )
	{
		pt = startPts[i];
		glVertex3d( pt.x, pt.y, pt.z );
		pt = endPts[i];
		glVertex3d( pt.x, pt.y, pt.z );
	}
	glEnd();	
}

bool SelectVolumeLocator1::isBounded() const
{ 
	return true;
}

MBoundingBox SelectVolumeLocator1::boundingBox() const
//
// N.B. It is important to have this bounding box function otherwise zoom selected and 
// zoom all won't work correctly.
//
{   
	MBoundingBox bbox;
	MPoint pt;
	double rad;
	unsigned int i;
	for( i=0; i < spheres.length(); i++ )
	{
		pt = spheres[i];
		rad = pt.w;
		pt.w = 1.0;
		
		bbox.expand( pt - MPoint( rad, rad, rad ) );
		bbox.expand( pt + MPoint( rad, rad, rad ) );
	}
		
	return bbox;
}

void *SelectVolumeLocator1::creator()
{
	return new SelectVolumeLocator1();
}

void SelectVolumeLocator1::refresh()
//
// Changing any of the locator's attributes will cause the
// locator to be tagged as needing a refresh. The attribute
// "tickle" has been added for just this purpose.
//
{
	MStatus stat;
	MObject thisNode = thisMObject();
	MFnDagNode dagFn( thisNode  );  

	MPlug tkPlug = dagFn.findPlug( tickle, &stat );
	int tkValue;
	tkPlug.getValue( tkValue );
	tkPlug.setValue( tkValue + 1 ); // Not a problem if value overflows (wraps around), it simply has to change values
}


MStatus SelectVolumeLocator1::initialize()
{ 
	MFnNumericAttribute numFn;
	tickle = numFn.create( "tk", "tickle", MFnNumericData::kInt );
	numFn.setDefault( 0 );
	numFn.setHidden( true );
	addAttribute( tickle );

	return MS::kSuccess;
}