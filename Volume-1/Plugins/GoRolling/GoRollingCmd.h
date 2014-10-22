//
// Copyright (C) 2001 David Gould 
// 
#ifndef GOROLLINGCMD_H
#define GOROLLINGCMD_H

#include <maya/MPxCommand.h>
#include <maya/MDGModifier.h>
/*
#include <maya/MFnPlugin.h>
#include <maya/MFnNurbsCurve.h>
#include <maya/MPoint.h>
#include <maya/MArgList.h>
#include <maya/MSyntax.h>
#include <maya/MArgDatabase.h>
#include <maya/MVector.h>
#include <maya/MEulerRotation.h>
#include <math.h>
*/

class GoRollingCmd : public MPxCommand 
{
public:
	virtual MStatus	doIt ( const MArgList& );
	virtual MStatus undoIt();
 	virtual MStatus redoIt();
	virtual bool isUndoable() const { return true; }

	static void *creator() { return new GoRollingCmd; }
	static MSyntax newSyntax();

private:
	MDGModifier dgMod;
};

#endif