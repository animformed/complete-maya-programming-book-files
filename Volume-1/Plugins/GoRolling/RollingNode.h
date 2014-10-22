//
// Copyright (C) 2001 David Gould 
//
#ifndef ROLLINGNODE_H
#define ROLLINGNODE_H

#include <maya/MPxNode.h>
#include <maya/MFnNumericAttribute.h>
#include <maya/MTypeId.h> 

class RollingNode : public MPxNode
{
public:
	virtual MStatus compute( const MPlug& plug, MDataBlock& data );

	static  void *creator();
	static  MStatus initialize();

public:
	static MObject distance;
	static MObject radius;
	static MObject rotation;

	static	MTypeId		id;
};

#endif
