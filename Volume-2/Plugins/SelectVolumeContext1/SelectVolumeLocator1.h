//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#ifndef SELECTVOLUMELOCATOR1_H
#define SELECTVOLUMELOCATOR1_H

#include <maya/MPxLocatorNode.h> 
#include <maya/MString.h> 
#include <maya/MTypeId.h> 
#include <maya/MVector.h>
#include <maya/MDataBlock.h>
#include <maya/MDataHandle.h>
#include <maya/M3dView.h>
#include <maya/MDistance.h>
#include <maya/MFnUnitAttribute.h>
#include <maya/MFnNumericAttribute.h>
#include <maya/MFnMessageAttribute.h>
#include <maya/MFnTypedAttribute.h>
#include <maya/MPxManipContainer.h>
#include <maya/MPointArray.h>
#include <maya/MFloatPointArray.h>
#include <math.h>

class SelectVolumeLocator1 : public MPxLocatorNode
{
public:
	SelectVolumeLocator1();
	
    virtual void draw( M3dView &view, 
					   const MDagPath &path, 
					   M3dView::DisplayStyle style, 
					   M3dView::DisplayStatus status );
    
    virtual bool isBounded() const;
    virtual MBoundingBox boundingBox() const; 

    static void *creator();
    static MStatus initialize();

    static const MTypeId typeId;
    static const MString typeName;

	void addSphere( const MPoint &s );
	void setLastSphereRadius( const double rad );
	void deleteLastSphere();
	void refresh();
	
private:
	MPointArray spheres;	
	
	MPointArray circlePts;
	void generateCircle( const unsigned int nCirclePts );
	void drawSphere( const MPoint &s ) const;
	void drawTube( const MPoint &start, 
					   const MPoint &end ) const;

	static const int N_CIRCLEPTS;
	
    // Attributes
    static MObject tickle;
};

#endif
