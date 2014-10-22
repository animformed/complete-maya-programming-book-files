//
// Copyright (C) 2001 David Gould 
//
#ifndef BASICLOCATOR_H
#define BASICLOCATOR_H

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
#include <math.h>

class BasicLocator : public MPxLocatorNode
{
public:
    BasicLocator();
    virtual ~BasicLocator(); 

    virtual MStatus compute( const MPlug& plug, MDataBlock& data );
    virtual void draw( M3dView & view, const MDagPath & path, M3dView::DisplayStyle style, M3dView::DisplayStatus status );
    
    virtual bool isBounded() const;
    virtual MBoundingBox boundingBox() const; 

    static void *creator();
    static MStatus initialize();

    static const MTypeId typeId;
    static const MString typeName;

    // Attributes
    static MObject xWidth;
    static MObject zWidth;
    static MObject dispType;

private:
    bool getCirclePoints( MPointArray &pts ) const;
};


#endif
