//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#include <maya/MPxContextCommand.h>
#include <maya/MPxContext.h>
#include <maya/MEvent.h>
#include <maya/MFnPlugin.h>
#include <maya/MGlobal.h>
#include <maya/MCursor.h>
#include <maya/MSelectionMask.h>
#include <maya/MItMeshEdge.h>
#include <maya/MItMeshPolygon.h>
#include <maya/MFnSingleIndexedComponent.h>
#include <maya/MSelectionList.h>
#include <maya/MDagPath.h>
#include <maya/MItSelectionList.h>

//
//  Context
//
class SelectRingContext1 : public MPxContext
{
public:
	SelectRingContext1();
	
	virtual void toolOnSetup( MEvent &event );
	virtual void toolOffCleanup();

	virtual MStatus	doPress( MEvent &event );
	virtual MStatus	doRelease( MEvent &event );

private:
	MGlobal::MSelectionMode prevSelMode;
	MSelectionMask prevCompMask;
	MSelectionMask prevObjMask;
	
	MGlobal::ListAdjustment	listAdjust;
	short pressX, pressY;
	short releaseX, releaseY;
	int clickBoxSize;
	
	static const MString helpTxt;
};

const MString SelectRingContext1::helpTxt( "Click on an edge" );

SelectRingContext1::SelectRingContext1()
{
	setTitleString( "Select Ring Tool" );
	
	//setImage( "selectRingTool.xpm", MPxContext::kImage1 );
}

void SelectRingContext1::toolOnSetup( MEvent &event )
{
	// Get the GUI's click box size
	MGlobal::executeCommand( "selectPref -query -clickBoxSize", clickBoxSize );
	
	setHelpString( helpTxt );
	setCursor( MCursor::editCursor );

	// Record current selection mode and masks
	prevSelMode = MGlobal::selectionMode();
	if( prevSelMode == MGlobal::kSelectComponentMode )
		prevCompMask = MGlobal::componentSelectionMask();	
	else
		prevObjMask = MGlobal::objectSelectionMask();	
}

void SelectRingContext1::toolOffCleanup()
{
	// Restore previous selection mode and masks
	MGlobal::setSelectionMode( prevSelMode );
	if( prevSelMode == MGlobal::kSelectComponentMode )
		MGlobal::setComponentSelectionMask( prevCompMask );
	else
		MGlobal::setObjectSelectionMask( prevObjMask );	
}

MStatus SelectRingContext1::doPress( MEvent &event )
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
	
	// Get the position of the mouse click
	event.getPosition( pressX, pressY );

	return MS::kSuccess;		
}

MStatus SelectRingContext1::doRelease( MEvent &event )
{
	// Get the mouse release position
	event.getPosition( releaseX, releaseY );

	// Didn't select a single point
	if( abs(pressX - releaseX) > 1 || abs(pressY - releaseY) > 1 )
	{
		MGlobal::displayWarning( "Click on a single edge" );
		return MS::kFailure;
	}
	
	// Set the selection surface area
	int halfClickBoxSize = clickBoxSize / 2;
	pressX -= halfClickBoxSize;
	pressY -= halfClickBoxSize;
	releaseX = pressX + clickBoxSize;
	releaseY = pressY + clickBoxSize;
	 
	/*
	// Record previous selection state
	prevSelMode = MGlobal::selectionMode();
	prevCompMask = MGlobal::componentSelectionMask();
	*/

	// Get the current selection
	MSelectionList curSel;
	MGlobal::getActiveSelectionList( curSel );

	//MGlobal::displayInfo( MString("Dim: ") + start_x + " " + start_y + " " + last_x + " " + last_y );
	
	// Change to object selection mode
	MGlobal::setSelectionMode( MGlobal::kSelectObjectMode );
	MGlobal::setComponentSelectionMask( MSelectionMask( MSelectionMask::kSelectObjectsMask ) );

	// Select the object under the selection area
	MGlobal::selectFromScreen( pressX, pressY, releaseX, releaseY, MGlobal::kReplaceList);
	MGlobal::executeCommand( "hilite" );
	
	// Change selection mode to mesh edges
	MGlobal::setSelectionMode( MGlobal::kSelectComponentMode );
	MGlobal::setComponentSelectionMask( MSelectionMask( MSelectionMask::kSelectMeshEdges ) );
	
	// Select the edges
	MGlobal::selectFromScreen( pressX, pressY, releaseX, releaseY, MGlobal::kReplaceList );
								   
	// Get the list of selected edges
	MSelectionList origEdgesSel;
	MGlobal::getActiveSelectionList( origEdgesSel );	
	
	MSelectionList newEdgesSel;
	MDagPath dagPath;
	MObject component;	
	
	// Only use the first edge in the selection
	MItSelectionList selIter( origEdgesSel, MFn::kMeshEdgeComponent );
	if( !selIter.isDone() )
	{
		selIter.getDagPath( dagPath, component );
		
		MIntArray faces;
		MItMeshEdge edgeIter( dagPath, component );
		
		MIntArray edgesVisited, facesVisited;
		int edgeIndex, faceIndex;
		int prevIndex;
		unsigned int i;
		bool finished = false;
		while( !finished )
		{
			edgeIndex = edgeIter.index();
			edgesVisited.append( edgeIndex );
			
			// Create an edge component the current edge
			MFnSingleIndexedComponent indexedCompFn;
			MObject newComponent = indexedCompFn.create( MFn::kMeshEdgeComponent );
			indexedCompFn.addElement( edgeIndex );
			newEdgesSel.add( dagPath, newComponent );
			
			//MGlobal::displayInfo( MString("ADDING: ") + edgeIter.index() );
			
			edgeIter.getConnectedFaces( faces );
			faceIndex = faces[0];
			if( faces.length() > 1 )
			{
				// Select the face that hasn't already been visited
				for( i=0; i < facesVisited.length(); i++ )
				{
					if( faceIndex == facesVisited[i] )
					{
						faceIndex = faces[1];
						break;
					}
				}
			}
				
			//MGlobal::displayInfo( MString("FACE: ") + faceIndex );
			facesVisited.append( faceIndex );
			
			MItMeshPolygon polyIter( dagPath );
		
			polyIter.setIndex( faceIndex, prevIndex );
		
			//MGlobal::displayInfo( MString( "faces: " ) + faces[0] + " " + faces[1] );
		
			MIntArray edges;
			polyIter.getEdges( edges );
		
			// Determine the face-relative index of the current
			// edge
			unsigned int edgeFaceIndex = 0;
			for( i=0; i < edges.length(); i++ )
			{
				if( edges[i] == edgeIter.index() )
				{
					edgeFaceIndex = i;
					break;
				}
			}
			
			// Determine the edge that is opposite the current edge
			edgeIndex = edges[ (edgeFaceIndex + (edges.length() / 2) ) % edges.length() ];
			
			//int index = edgeIter.index();
			//MGlobal::displayInfo( MString( "sel edge index: " ) + index + " next edge: " + edgeIndex );	
			
			// Set the current edge to the opposite edge
			edgeIter.setIndex( edgeIndex, prevIndex );	

			// Determine if the edge has already been visited
			for( i=0; i < edgesVisited.length(); i++ )
			{
				if( edgeIndex == edgesVisited[i] )
				{
					finished = true;
					break;
				}							
			}
		}
	}
	
	// Set the active selection to the one previous to edge loop selection
	MGlobal::setActiveSelectionList( curSel, MGlobal::kReplaceList);

	// Update this selection based on the list adjustment setting
	MGlobal::selectCommand( newEdgesSel, listAdjust );

	return MS::kSuccess;		
}

//
//  Context Command
//
class SelectRingContextCmd1 : public MPxContextCommand
{
public:	
	virtual MPxContext *makeObj();
	static void *creator();
};

MPxContext *SelectRingContextCmd1::makeObj()
{
	return new SelectRingContext1();
}

void *SelectRingContextCmd1::creator()
{
	return new SelectRingContextCmd1;
}

//
// Plugin 
//
MStatus initializePlugin( MObject obj )
{
	MFnPlugin plugin( obj, "David Gould", "1.0" );

	MStatus stat;
	stat = plugin.registerContextCommand( "selectRingContext1",
										  SelectRingContextCmd1::creator );
	if ( !stat )
		stat.perror( "registerContextCommand failed");

	return stat;
}

MStatus uninitializePlugin( MObject obj )
{
	MFnPlugin plugin( obj );

	MStatus stat;
	stat = plugin.deregisterContextCommand( "selectRingContext1" );
	if ( !stat )
		stat.perror( "deregisterContextCommand failed" );

	return stat;
}


/*
loadPlugin "C:/DavidGould.com/Writing/Morgan Kaufmann/Complete Maya Programming II/Edition #1/Drafts/Plugins/SelectRingContext1/Debug/selectRingContext1.mll";
file -f -open -type "mayaBinary" "C:/DavidGould.com/Writing/Morgan Kaufmann/Complete Maya Programming II/Edition 0/Drafts/Projects/MayaProgramming/scenes/efface.mb";addRecentFile("C:/DavidGould.com/Writing/Morgan Kaufmann/Complete Maya Programming II/Edition 0/Drafts/Projects/MayaProgramming/scenes/efface.mb", "mayaBinary");

string $selRingCtx = `selectRingContext1`;
setToolTo $selRingCtx;
*/
