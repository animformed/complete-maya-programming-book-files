//
// Copyright (c) 2002 David Gould
//
#ifndef BASICLOCATORMANIP_H
#define BASICLOCATORMANIP_H

#include <maya/MString.h> 
#include <maya/MTypeId.h> 
#include <maya/MPlug.h>
#include <maya/MVector.h>
#include <maya/M3dView.h>
#include <maya/MMatrix.h>
#include <maya/MDistance.h>
#include <maya/MPxManipContainer.h> 
#include <maya/MFnDistanceManip.h>
#include <maya/MManipData.h>
#include <math.h>

class BasicLocatorManip : public MPxManipContainer
{
public:  
    virtual MStatus createChildren();
    virtual MStatus connectToDependNode(const MObject & node);
    virtual void draw(M3dView & view, const MDagPath & path, M3dView::DisplayStyle style,M3dView::DisplayStatus status); 

    static void * creator();

    MManipData startPointCallback(unsigned index) const;
    MManipData sideDirectionCallback(unsigned index) const;
    MManipData backDirectionCallback(unsigned index) const;
  
    MVector nodeTranslation() const;
    MVector worldOffset(MVector vect) const;

    static const MTypeId typeId;
    static const MString typeName;

    MManipData centerPointCallback(unsigned index) const;

    // Paths to child manipulators
    MDagPath xWidthDagPath;
    MDagPath zWidthDagPath;
    MDagPath typeDagPath;

    // Object that the manipulator will be operating on
    MObject targetObj;
};

#endif