//
// Copyright (C) 2001 David Gould 
// 
#ifndef GROUNDSHADOWCMD_H
#define GROUNDSHADOWMD_H

#include <maya/MPxCommand.h>
#include <maya/MDagModifier.h>

class GroundShadowCmd : public MPxCommand 
{
public:
	virtual MStatus	doIt ( const MArgList& );
	virtual MStatus undoIt();
 	virtual MStatus redoIt();
	virtual bool isUndoable() const { return true; }

	static void *creator() { return new GroundShadowCmd; }
	static MSyntax newSyntax();

private:
	MDagModifier dagMod;
};

#endif