//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#ifndef DISPLACEMESHCMD_H
#define DISPLACEMESHCMD_H

#include "CmpMeshModifierCmd.h"

class DisplaceMeshCmd : public CmpMeshModifierCmd
{
public:
	virtual MStatus doIt( const MArgList &args );
	
	virtual MStatus DisplaceMeshCmd::initModifierNode( MObject &node, MDagModifier &dagMod );

	static void *creator();
	static MSyntax newSyntax();

private:
	double strength;
	MString imageFilename; 
};

#endif