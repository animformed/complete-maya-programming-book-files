//
// Copyright (C) 2001 David Gould 
//
#ifndef MELTNODE_H
#define MELTNODE_H

#include <maya/MPxNode.h>
#include <maya/MFnNumericAttribute.h>
#include <maya/MTypeId.h> 

class MeltNode : public MPxNode
{
public:
	virtual MStatus compute( const MPlug& plug, MDataBlock& data );

	static  void *creator();
	static  MStatus initialize();

	static const MTypeId id;

public:
	static MObject inputSurface;
	static MObject outputSurface;
	static MObject amount;
};

#endif
