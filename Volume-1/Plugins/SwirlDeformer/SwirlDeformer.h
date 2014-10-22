//
// Copyright (C) 2001 David Gould 
//
#ifndef SWIRLDEFORMER_H
#define SWIRLDEFORMER_H

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
#include <maya/MPxDeformerNode.h>
#include <math.h>

class SwirlDeformer : public MPxDeformerNode
{
public:
	static  void *creator();
	static  MStatus initialize();

    virtual MStatus deform( MDataBlock &block,
									   MItGeometry &iter,
									   const MMatrix &mat,
									   unsigned int multiIndex );

	static MTypeId typeId;
	static MString typeName;

private:
	// Attributes
	static MObject startDist;
	static MObject endDist;
};

#endif
