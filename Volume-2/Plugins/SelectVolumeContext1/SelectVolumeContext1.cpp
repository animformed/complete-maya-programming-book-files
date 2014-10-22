//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
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
#include <maya/MItDag.h>
#include <maya/MItMeshVertex.h>
#include <maya/MDistance.h>
#include <maya/MFeedbackLine.h>
#include <limits>
#include "SelectVolumeContext1.h"
#include "SelectVolumeLocator1.h"

//
//  ToolCommand
//
const MString SelectVolumeToolCmd1::commandName( "selectVolumeToolCmd1" );

const char *sphereFlag = "-sp", *sphereLongFlag = "-sphere";
const char *listAdjustFlag = "-la", *listAdjustLongFlag = "-listAdjust";

MSyntax SelectVolumeToolCmd1::newSyntax()
{
    MSyntax syntax;

	syntax.addFlag( sphereFlag, sphereLongFlag, 
					MSyntax::kDistance, MSyntax::kDistance, MSyntax::kDistance,
					MSyntax::kDistance );
	syntax.makeFlagMultiUse( sphereFlag );
	
	syntax.addFlag( listAdjustFlag, listAdjustLongFlag, MSyntax::kUnsigned );
	
	return syntax;
}

void *SelectVolumeToolCmd1::creator()
{
	return new SelectVolumeToolCmd1;
}

SelectVolumeToolCmd1::SelectVolumeToolCmd1()
{
	setCommandString( SelectVolumeToolCmd1::commandName );
}
	
MStatus SelectVolumeToolCmd1::doIt( const MArgList &args )
{
	//MGlobal::displayInfo( "doIt" );

	// Initialize to default values
	listAdjust = MGlobal::kReplaceList;
	
	// Get the options from the command line
	MStatus stat;
	MArgDatabase argData( syntax(), args, &stat );
	if( !stat )
		return stat;

	const unsigned int nUses = argData.numberOfFlagUses( sphereFlag );
	MArgList sphereFlagArgs;
	MDistance dist;
	MPoint s;
	unsigned int i, j;
	for( i=0; i < nUses; i++ )
	{
		argData.getFlagArgumentList( sphereFlag, i, sphereFlagArgs );
		s = MPoint::origin;
		for( j=0; j < sphereFlagArgs.length(); j++ )
		{
			sphereFlagArgs.get( j, dist );
			s[j] = dist.value();
		}
		
		addSphere( s );
	}
	
	if( argData.isFlagSet( listAdjustFlag ) )
	{
		unsigned value;
		argData.getFlagArgument( listAdjustFlag, 0, value );
		listAdjust = MGlobal::ListAdjustment( value );
	}
	
	return redoIt();
}

MStatus SelectVolumeToolCmd1::redoIt()
{	
	//MGlobal::displayInfo( "redoIt" );

	MSelectionList newSel;
	
	MStatus stat;
	MPoint pt;
	MDagPath dagPath;
	//
	// Have to use filtering since both transforms and mesh shapes
	// are valid for the MItMeshVertex function set. Given a mesh
	// both its parent transform and mesh shape will be initialized
	// with the MItMeshVertex, so the same mesh will be traversed twice.
	// This is particularly problematic for toggling selections since
	// the selection will be toggled on when the transform is encountered
	// then toggled off when the mesh shape is encountered, thereby
	// producing no visible result.
	//
	// By filtering only MFn::kMesh, transforms are excluded.
	//	
	MItDag dagIter( MItDag::kDepthFirst, MFn::kMesh );
	for( ; !dagIter.isDone(); dagIter.next() )
	{
		dagIter.getPath( dagPath );
		
		MItMeshVertex vertIter( dagPath, MObject::kNullObj, &stat );
		if( !stat )
			continue;
		
		// Determine if the dag node is visible.
		// N.B Visibility is inherited so all 
		// parents must be checked.
		bool isVisible = true;
		MDagPath searchPath( dagPath );
		do
		{
			MFnDagNode dagFn( searchPath );
			
			MPlug visPlug = dagFn.findPlug( "visibility" );
			MPlug intPlug = dagFn.findPlug( "intermediateObject" );
			bool vis, interm;
			visPlug.getValue( vis );
			intPlug.getValue( interm );
			
			if( !vis || interm )
			{
				isVisible = false;
				break;
			}
						
		} while( searchPath.pop() );
		
		if( !isVisible )
			continue;
		
		//MGlobal::displayInfo( MString( " dagPath: " ) + dagPath.fullPathName() );
			
		MFnSingleIndexedComponent indexedCompFn;
		MObject newComponent;
		newComponent = indexedCompFn.create( MFn::kMeshVertComponent );
				
		for( ; !vertIter.isDone(); vertIter.next() )
		{
			pt = vertIter.position( MSpace::kWorld );
			if( inVolume( pt ) )
				indexedCompFn.addElement( vertIter.index() );	
		}
		
		if( !indexedCompFn.isEmpty() )
			newSel.add( dagPath, newComponent );
	}

	// Restore the previous selection
	MGlobal::setActiveSelectionList( prevSel, MGlobal::kReplaceList );

	// Update this selection based on the list adjustment setting
	MGlobal::selectCommand( newSel, listAdjust );
	
	return MS::kSuccess;
}

MStatus SelectVolumeToolCmd1::undoIt()
{
	return MGlobal::setActiveSelectionList( prevSel, MGlobal::kReplaceList);
}

MStatus SelectVolumeToolCmd1::finalize()
{
	MArgList command;
	command.addArg( commandString() );

	command.addArg( MString(listAdjustFlag) );
	command.addArg( (int)listAdjust );

	MPoint s;
	unsigned int i;
	for( i=0; i < spheres.length(); i++ )
	{
		s = spheres[i];
		command.addArg( MString(sphereFlag) );
		command.addArg( s.x );
		command.addArg( s.y );
		command.addArg( s.z );
		command.addArg( s.w );
	}	
	
	return MPxToolCommand::doFinalize( command );
}

void SelectVolumeToolCmd1::addSphere( const MPoint &s )
{
	spheres.append(s);
}

bool SelectVolumeToolCmd1::inVolume( const MPoint &p ) const
{
	double dist;
	MPoint pt;
	unsigned int i;
	for( i=0; i < spheres.length(); i++ )
	{
		pt = spheres[i];
		pt.w = 1.0;
		dist = pt.distanceTo( p );
		if( dist <= spheres[i].w )
			return true;
	}
	
	double len;
	double projDist;
	double t, rad;
	double startRad, endRad;
	MPoint start, end;
	MPoint projPt;
	MVector vecToPt, vecCentre;
	MVector vecProjPtToPt;
	for( i=0; i < spheres.length()-1; i++ )
	{
		start = spheres[i];
		end = spheres[i+1];
		startRad = start.w;
		endRad = end.w;
		start.w = 1.0;
		end.w = 1.0;
		
		vecToPt = p - start;
		vecCentre = end - start;
		
		len = vecCentre.length();
		
		vecCentre.normalize();
		projDist = vecToPt * vecCentre;
		// Point projects onto the line between the spheres
		if( projDist >= 0.0 && projDist <= len )
		{
			// Calculate where the point projects onto the line
			projPt = start + projDist * vecCentre;
			
			// The vector from the projected point to the point
			// being tested
			vecProjPtToPt = p - projPt;
			
			// Calculate parametric distance
			t = projDist / len;
			// Calculate the maximum distance the point can
			// be along the cylinder at the projection point
			rad = (1 - t) * startRad + t * endRad;
			
			// If the point isn't too far away
			if( vecProjPtToPt.length() <= rad )
				return true;
		}
	}		
	
	return false;
}


//
//  Context
//
const MString SelectVolumeContext1::helpTxt( "Click and drag to create spheres. Press Enter to finish." );

SelectVolumeContext1::SelectVolumeContext1()
{
	setTitleString( "Select Volume Tool" );
	setImage( "selectVolumeContext1.xpm", MPxContext::kImage1 );
}

void SelectVolumeContext1::getClassName( MString &name ) const
{ 
	name = "selectVolumeContext1";
}

void SelectVolumeContext1::toolOnSetup( MEvent &event )
{
	reset();
	
	setHelpString( helpTxt );
	setCursor( MCursor::editCursor );
}

void SelectVolumeContext1::toolOffCleanup()
{
	reset();
}

MStatus SelectVolumeContext1::doPress( MEvent &event )
{
	//MGlobal::displayInfo( "doPress" );
	
	if( event.mouseButton() != MEvent::kLeftMouse )
		return MS::kFailure;
			
	// Get the position of the mouse click
	event.getPosition( pressX, pressY );
		
	addNewSphere = true;
	
	return MS::kSuccess;		
}

MStatus SelectVolumeContext1::doDrag( MEvent &event )
{
	//MGlobal::displayInfo( MString( "doDrag" ) ); // start pos: " ) + sphereCentre.x + ", " + sphereCentre.y + ", " + sphereCentre.z + " extent: " + sphereExtent.x + ", " + sphereExtent.y + ", " + sphereExtent.z );

	short dragX, dragY;
	event.getPosition( dragX, dragY );

	// Must move more than 2 pixels outside of first click
	// for it to be considered. This prevents a single click
	// producing a very small sphere.
	if( abs( pressX - dragX ) <= 2 && abs( pressY - dragY ) <= 2 )
		return MS::kFailure;
		
	MPoint pressW, dragW;
	MVector pressWV, dragWV;
	
	M3dView view = M3dView::active3dView();
	view.viewToWorld( pressX, pressY, pressW, pressWV );
	view.viewToWorld( dragX, dragY, dragW, dragWV );	
	
	MPoint sphereCentre = intersectGround( pressW, pressWV );
	MPoint sphereExtent = intersectGround( dragW, dragWV );
		
	double dist = sphereCentre.distanceTo( sphereExtent );

	// Add new sphere if requested
	if( addNewSphere )
	{
		// First sphere created so get the modifier keys
		if( spheres.length() == 0 )
		{
			listAdjust = MGlobal::kReplaceList;
		
			// Determine which modifier keys were pressed
			if( event.isModifierShift() || event.isModifierControl() ) 
			{
				if( event.isModifierShift() ) 
				{
					if( event.isModifierControl() ) 
						listAdjust = MGlobal::kAddToList; // Shift+Ctrl: Merge selection
					else
						listAdjust = MGlobal::kXORWithList; // Shift: Toggle selection (XOR)
				} 
				else
				{
					if( event.isModifierControl() )
						listAdjust = MGlobal::kRemoveFromList; // Ctrl: Remove selection
				}
			}
			
			// Get the current selection
			MGlobal::getActiveSelectionList( prevSel );
		}
				
		MPoint sphere = sphereCentre;
		sphere.w = 0.0; // Set radius to 0
		addSphere( sphere );
		addNewSphere = false;
	}
	
	MFnDependencyNode depFn( volumeLocatorObj );
	SelectVolumeLocator1 *loc = (SelectVolumeLocator1 *) depFn.userNode();
		
	// Set sphere radius	
	if( spheres.length() )
		spheres[ spheres.length()-1 ].w = dist;
	loc->setLastSphereRadius( dist );
	
	updateViewport();
			
	return MS::kSuccess;
}

void SelectVolumeContext1::deleteAction()
{
	//MGlobal::displayInfo( "deleteAction" );
	
	if( spheres.length() )
		spheres.remove( spheres.length()-1 );

	if( !volumeLocatorObj.isNull() )
	{
		MFnDependencyNode depFn( volumeLocatorObj );
		SelectVolumeLocator1 *loc = (SelectVolumeLocator1 *) depFn.userNode();
		loc->deleteLastSphere();
				
		updateViewport();
	}	
}

void SelectVolumeContext1::completeAction()
{	
	// Create tool command
	SelectVolumeToolCmd1 &cmd = *(SelectVolumeToolCmd1 *) newToolCommand();
	
	// Need to explicitly set the previous selection since
	// the creation of the custom locator will have
	// affected the current selection.
	//
	cmd.setPrevSel( prevSel );
	cmd.setListAdjust( listAdjust );
	
	unsigned int i;
	for( i=0; i < spheres.length(); i++ )
		cmd.addSphere( spheres[i] );
	
	cmd.redoIt();
	cmd.finalize();
	
	reset();
}

void SelectVolumeContext1::abortAction()
{	
	reset();
}

bool SelectVolumeContext1::processNumericalInput( 
	const MDoubleArray &values,
	const MIntArray &flags,
	bool isAbsolute )
{
	unsigned int nValues = values.length() > 4 ? 4 : values.length();
	
	// Initialize to default sphere
	MPoint newSphere( 0.0, 0.0, 0.0, 0.25 ); 
	// Set values from numerical input
	unsigned int i;
	for( i=0; i < nValues; i++ )
	{
		if( !ignoreEntry( flags, i ) )
			newSphere[i] = values[i];
	}
	
	addSphere( newSphere );
	updateViewport();
	feedbackNumericalInput();
	
	return true;
}

bool SelectVolumeContext1::feedbackNumericalInput() const
{
	MString className;
	getClassName( className );
	
	MFeedbackLine::setTitle( className );
	MFeedbackLine::setFormat( "^6.3f ^6.3f ^6.3f ^6.3f" );

	MPoint sphere;
	if( spheres.length() )
		sphere = spheres[ spheres.length()-1 ];
	
	unsigned int i;
	for( i=0; i < 4; i++ )
		MFeedbackLine::setValue( i, sphere[i] );

	return true;
}

MSyntax::MArgType SelectVolumeContext1::argTypeNumericalInput(
	unsigned index ) const
{
	return MSyntax::kDistance;
}

void SelectVolumeContext1::reset()
{
	listAdjust = MGlobal::kReplaceList;
	prevSel.clear();
	spheres.clear();
	if( !volumeLocatorObj.isNull() )
	{
		MGlobal::removeFromModel( volumeLocatorObj );
		volumeLocatorObj = MObject::kNullObj;
	}
}

void SelectVolumeContext1::addSphere( const MPoint &s, bool updateLocator )
{
	spheres.append( s );
	
	if( updateLocator )
	{
		// Create a custom locator		
		if( volumeLocatorObj.isNull() )
		{
			MFnDagNode dagFn;
			MObject transformObj = dagFn.create( SelectVolumeLocator1::typeId );
			volumeLocatorObj = dagFn.child( 0 );
		}

		MFnDependencyNode depFn( volumeLocatorObj );
		SelectVolumeLocator1 *loc = (SelectVolumeLocator1 *) depFn.userNode();
		loc->addSphere( s );
	}	
}

void SelectVolumeContext1::updateViewport()
{
	if( !volumeLocatorObj.isNull() )
	{
		MFnDependencyNode depFn( volumeLocatorObj );
		SelectVolumeLocator1 *loc = (SelectVolumeLocator1 *) depFn.userNode();
		loc->refresh();
	}
	
	M3dView view = M3dView::active3dView();
	view.refresh();
}

MPoint SelectVolumeContext1::intersectGround( const MPoint &rayOrigin,
											  const MVector &rayDir )
{
    // Calculate the intersection of the world ray and the ground plane
	MPoint hitPt;
	MVector groundNorm( 0.0, 1.0, 0.0 );
	double denom = groundNorm * rayDir; // Dot product
	if( fabs( denom ) < 1.0e-8 ) // Vector isn't parallel to the ground plane if denom != 0 (tolerance takes into account precision problems)
	{
		double d = 0.0; // groundNorm . groundPoint
		double t = (d - (groundNorm * rayOrigin)) / denom;
		hitPt = rayOrigin + t * rayDir;
	}

	return hitPt;
}

//
//  Context Command
//
const MString SelectVolumeContextCmd1::commandName( "selectVolumeContext1" );

MPxContext *SelectVolumeContextCmd1::makeObj()
{
	return new SelectVolumeContext1();
}

void *SelectVolumeContextCmd1::creator()
{
	return new SelectVolumeContextCmd1;
}
