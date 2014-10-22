//
// Copyright (C) 2001 David Gould 
// 
#ifndef MELTCMD_H
#define MELTCMD_H

#include <maya/MPxCommand.h>
#include <maya/MDGModifier.h>

class MeltCmd : public MPxCommand 
{
public:
	virtual MStatus	doIt ( const MArgList& );
	virtual MStatus undoIt();
 	virtual MStatus redoIt();
	virtual bool isUndoable() const { return true; }

	static void *creator() { return new MeltCmd; }
	static MSyntax newSyntax();

private:
	MDGModifier dgMod;
};

#endif