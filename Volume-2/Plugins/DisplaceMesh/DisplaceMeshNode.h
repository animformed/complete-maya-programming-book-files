//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#ifndef DISPLACEMESHNODE_H
#define DISPLACEMESHNODE_H

#include "CmpMeshModifierNode.h"

class DisplaceMeshNode : public CmpMeshModifierNode
{
public:	
	virtual MStatus compute( const MPlug &plug, MDataBlock &data );
	static  void *creator();
	static  MStatus initialize();
	
	static MTypeId id;

	static MObject strength;
	static MObject imageFilename;

	static double strengthDefault();
	static MString imageFilenameDefault();
};

#endif
