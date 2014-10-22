//
// Copyright (C) 2001 David Gould 
//
#ifndef GROUNDSHADOWNODE_H
#define GROUNDSHADOWNODE_H

#include <maya/MPxNode.h>
#include <maya/MFnNumericAttribute.h>
#include <maya/MTypeId.h> 

class GroundShadowNode : public MPxNode
{
public:
	virtual MStatus compute( const MPlug& plug, MDataBlock& data );

	static  void *creator();
	static  MStatus initialize();

	static const MTypeId id;

public:
	static MObject lightPosition;
	static MObject castingSurface;
	static MObject shadowSurface;
	static MObject groundHeight;
};

#endif
