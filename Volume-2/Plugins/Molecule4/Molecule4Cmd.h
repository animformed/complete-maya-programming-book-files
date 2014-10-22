//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#ifndef MOLECULE4CMD_H
#define MOLECULE4CMD_H

#include <maya/MDagModifier.h>
#include <maya/MPxCommand.h>
#include <maya/MGlobal.h>
#include <maya/MSelectionList.h>
#include <maya/MItSelectionList.h>
#include <maya/MItMeshPolygon.h>
#include <maya/MItMeshVertex.h>
#include <maya/MDagPath.h>
#include <maya/MPoint.h>
#include <maya/MFnMesh.h>
#include <maya/MItMeshEdge.h>
#include <maya/MDagModifier.h>
#include <maya/MSyntax.h>
#include <maya/MArgDatabase.h>
#include <maya/MDistance.h>
#include <maya/MDagPathArray.h>

class Molecule4Cmd : public MPxCommand 
{
public:
	virtual MStatus	doIt( const MArgList& );
	virtual MStatus	redoIt();
	virtual MStatus	undoIt();
	virtual bool isUndoable() const { return true; }
	
	static void *creator() { return new Molecule4Cmd; }
	static MSyntax newSyntax();
	
private:
	// Command options
	MDistance radius;
	int segs;
	double ballRodRatio;
	
	// Utility members
	MDagModifier dagMods[2];
	MObjectArray moleculeNodes;
	MObjectArray meshShapeNodes;
};

#endif