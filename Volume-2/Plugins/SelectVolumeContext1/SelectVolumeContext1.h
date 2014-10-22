//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#ifndef SELECTVOLUMECONTEXT1_H
#define SELECTVOLUMECONTEXT1_H

#include <maya/MPxContextCommand.h>
#include <maya/MPxContext.h>
#include <maya/MPxToolCommand.h>
#include <maya/MEvent.h>
#include <maya/MGlobal.h>
#include <maya/MCursor.h>
#include <maya/MSelectionMask.h>
#include <maya/MItMeshEdge.h>
#include <maya/MItMeshPolygon.h>
#include <maya/MFnSingleIndexedComponent.h>
#include <maya/MSelectionList.h>
#include <maya/MDagPath.h>
#include <maya/MItSelectionList.h>
#include <maya/MArgDatabase.h>
#include <maya/MArgList.h>
#include <maya/MPointArray.h>

//
//  ToolCommand
//
class SelectVolumeToolCmd1 : public MPxToolCommand
{
public:
	SelectVolumeToolCmd1();

	MStatus doIt( const MArgList &args );
	MStatus redoIt();
	MStatus undoIt();
	bool isUndoable() const { return true; }	
	MStatus	finalize();
		
	void setPrevSel( const MSelectionList &sel ) { prevSel = sel; }
	void setListAdjust( const MGlobal::ListAdjustment &la ) { listAdjust = la; }
	void addSphere( const MPoint &s );
	
	static void *creator();
	static MSyntax newSyntax();
	static const MString commandName;

private:
	MSelectionList prevSel; // Previous selection
	
	MGlobal::ListAdjustment listAdjust;
	MPointArray spheres;
	
	bool inVolume( const MPoint &p ) const;	
};

//
//  Context
//
class SelectVolumeContext1 : public MPxContext
{
public:
	SelectVolumeContext1();
	
	virtual void toolOnSetup( MEvent &event );
	virtual void toolOffCleanup();

	virtual MStatus	doPress( MEvent &event );
	virtual MStatus doDrag( MEvent &event );

	virtual void deleteAction();
	virtual void completeAction();
	virtual void abortAction();
	
	virtual bool processNumericalInput( const MDoubleArray &values,
										const MIntArray &flags,
										bool isAbsolute );
	virtual bool feedbackNumericalInput() const;
	virtual MSyntax::MArgType argTypeNumericalInput( unsigned index ) const;

	virtual void getClassName( MString &name ) const;
	
private:
	short pressX, pressY;
	short releaseX, releaseY;
	bool addNewSphere;
	MSelectionList prevSel;
	MObject volumeLocatorObj;
	MGlobal::ListAdjustment	listAdjust;
	MPointArray spheres;

	void updateViewport();
	void addSphere( const MPoint &s, bool updateLocator=true );
	void reset();
	MPoint intersectGround( const MPoint &rayOrigin,
							const MVector &rayDir );

	static const MString helpTxt;
};

//
//  Context Command
//
class SelectVolumeContextCmd1 : public MPxContextCommand
{
public:	
	virtual MPxContext *makeObj();
	
	static void *creator();
	static const MString commandName;
};

#endif