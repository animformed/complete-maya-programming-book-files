//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#ifndef MOLECULE4NODE_H
#define MOLECULE4NODE_H

#include <maya/MPxNode.h>
#include <maya/MDistance.h>

class Molecule4Node : public MPxNode
{
public:	
	virtual MStatus compute( const MPlug &plug, MDataBlock &data );
	static  void *creator();
	static  MStatus initialize();

	static MObject radius;
	static MObject segments;
	static MObject ballRatio;
	static MObject inMesh;
	static MObject outMesh;
	
	static MTypeId id;
	
	static MDistance radiusDefault();
	static int segmentsDefault();
	static double ballRatioDefault();
};

#endif