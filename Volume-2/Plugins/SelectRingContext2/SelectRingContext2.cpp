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
#include <maya/MArgDatabase.h>
#include <maya/MArgList.h>

//
//  ToolCommand
//

class SelectRingToolCmd2 : public MPxToolCommand
{
public:
	SelectRingToolCmd2();

	MStatus doIt( const MArgList &args );
	MStatus redoIt();
	MStatus undoIt();
	bool isUndoable() const { return true; }	
	MStatus	finalize();
	
	enum SelType { RING, LOOP };
	
	void setSelEdges( bool on ) { selEdges = on; }
	void setSelFaces( bool on ) { selFaces = on; }
	void setSelVertices( bool on ) { selVertices = on; }
	void setCurrentSelection( MSelectionList &curSel ) { prevSel = curSel; }
	void setSelectedEdgeObject( const MDagPath &dagPath ) { selEdgeObject = dagPath; }
	void setSelectedEdgeComponent( const MObject &component ) { selEdgeComp = component; }
	void setListAdjust( const MGlobal::ListAdjustment &la ) { listAdjust = la; }
	void setSelType( SelType type ) { selType = (int)type; }
	
	static void *creator();
	static MSyntax newSyntax();
	static const MString commandName;

private:
	MSelectionList prevSel; // Previous selection
	
	MDagPath selEdgeObject;
	MObject selEdgeComp;
	MGlobal::ListAdjustment listAdjust;
	bool selEdges;
	bool selFaces;
	bool selVertices;
	int selType;

	enum Location { NEXT, PREVIOUS, OPPOSITE };
	int navigateFace( const MDagPath &dagPath, 
					  const int faceIndex, 
					  const int edgeIndex, 
					  const Location loc );
};

const MString SelectRingToolCmd2::commandName( "selectRingToolCmd2" );

const char *edgeFlag = "-ed", *edgeLongFlag = "-edge";
const char *selEdgesFlag = "-se", *selEdgesLongFlag = "-selectEdges";
const char *selFacesFlag = "-sf", *selFacesLongFlag = "-selectFaces";
const char *selVerticesFlag = "-sv", *selVerticesLongFlag = "-selectVertices";
const char *listAdjustFlag = "-la", *listAdjustLongFlag = "-listAdjust";
const char *selTypeFlag = "-st", *selTypeLongFlag = "-selectType";

MSyntax SelectRingToolCmd2::newSyntax()
{
    MSyntax syntax;

	syntax.addFlag( edgeFlag, edgeLongFlag, MSyntax::kString );
	syntax.addFlag( selEdgesFlag, selEdgesLongFlag, MSyntax::kBoolean );
	syntax.addFlag( selFacesFlag, selFacesLongFlag, MSyntax::kBoolean );
	syntax.addFlag( selVerticesFlag, selVerticesLongFlag, MSyntax::kBoolean );
	syntax.addFlag( listAdjustFlag, listAdjustLongFlag, MSyntax::kUnsigned );
	syntax.addFlag( selTypeFlag, selTypeLongFlag, MSyntax::kUnsigned );
	
	return syntax;
}

void *SelectRingToolCmd2::creator()
{
	return new SelectRingToolCmd2;
}

SelectRingToolCmd2::SelectRingToolCmd2()
{
	setCommandString( SelectRingToolCmd2::commandName );
}
	
MStatus SelectRingToolCmd2::doIt( const MArgList &args )
{
	//MGlobal::displayInfo( "doIt" );
	
	MStatus stat;

	MGlobal::getActiveSelectionList( prevSel );	

	// Initialize to default values
	selEdges = true;
	selFaces = false;
	selVertices = false;
	selEdgeObject = MDagPath();
	selEdgeComp = MObject::kNullObj;
	listAdjust = MGlobal::kReplaceList;
	selType = RING;
		
	// Get the options from the command line
	MArgDatabase argData( syntax(), args, &stat );
	if( !stat )
		return stat;

	if( argData.isFlagSet( edgeFlag ) )
	{
		MString edgeSpec;
		argData.getFlagArgument( edgeFlag, 0, edgeSpec );
		
		MSelectionList sel;
		sel.add( edgeSpec );
		sel.getDagPath( 0, selEdgeObject, selEdgeComp );
		//MFnSingleIndexedComponent si( selEdgeComp );
		//MGlobal::displayInfo( MString("doing stuff on ") + selEdgeObject.fullPathName() + " " + si.element(0) );
	}

	if( argData.isFlagSet( selEdgesFlag ) )
		argData.getFlagArgument( selEdgesFlag, 0, selEdges );
	
	if( argData.isFlagSet( selFacesFlag ) )
		argData.getFlagArgument( selFacesFlag, 0, selFaces );

	if( argData.isFlagSet( selVerticesFlag ) )
		argData.getFlagArgument( selVerticesFlag, 0, selVertices );

	if( argData.isFlagSet( listAdjustFlag ) )
	{
		unsigned value;
		argData.getFlagArgument( listAdjustFlag, 0, value );
		listAdjust = MGlobal::ListAdjustment( value );
	}

	if( argData.isFlagSet( selTypeFlag ) )
		argData.getFlagArgument( selTypeFlag, 0, selType );
	
	return redoIt();
}

MStatus SelectRingToolCmd2::redoIt()
{	
	//MGlobal::displayInfo( "redoIt" );

	MItMeshPolygon polyIter( selEdgeObject );
	MItMeshEdge edgeIter( selEdgeObject, selEdgeComp );

	//MFnSingleIndexedComponent si( selEdgeComp );
	//MGlobal::displayInfo( MString("doing stuff on ") + selEdgeObject.fullPathName() + " " + si.element(0) );
	
	MFnSingleIndexedComponent indexedCompFn;
	MObject newComponent;		
	MSelectionList newSel;
	MIntArray edges;
	MIntArray faces;
	unsigned int i;
	const int initEdgeIndex = edgeIter.index();
	int initFaceIndex;
	int prevIndex, lastIndex;
	int faceIndex, edgeIndex;
	int newFaceIndex, newEdgeIndex;
	int nInitEdgeVisits;
	
	MIntArray remainFaces;
	MIntArray remainEdges;
	
	if( selType == RING )
	{
		nInitEdgeVisits = 0;
		
		// Push the face+edge combo on both sides 
		// of the current edge onto the stack
		edgeIter.getConnectedFaces( faces );
		if( faces.length() > 1 )
		{
			remainFaces.append( faces[1] );
			remainEdges.append( initEdgeIndex );
		}
		initFaceIndex = faces[0];
		remainFaces.append( initFaceIndex );
		remainEdges.append( initEdgeIndex );
		
		while( remainFaces.length() )
		{
			// Pop the face and edge indices
			lastIndex = remainFaces.length() - 1;
			faceIndex = remainFaces[ lastIndex ];
			edgeIndex = remainEdges[ lastIndex ];
			remainFaces.remove( lastIndex );
			remainEdges.remove( lastIndex );
			
			// If the current edge the initial edge
			if( faceIndex == initFaceIndex && 
				edgeIndex == initEdgeIndex )
			{
				// Reached back to the initial edge, so the loop is closed
				if( ++nInitEdgeVisits == 2 )
					break;
			}
			
			// Add edge to the new selection list
			if( selEdges )
			{
				newComponent = indexedCompFn.create( MFn::kMeshEdgeComponent );
				indexedCompFn.addElement( edgeIndex );
				newSel.add( selEdgeObject, newComponent );
			}
			
			// Add vertices to the new selection list
			if( selVertices )
			{
				newComponent = indexedCompFn.create( MFn::kMeshVertComponent );
				edgeIter.setIndex( edgeIndex, prevIndex );
				indexedCompFn.addElement( edgeIter.index(0) );
				indexedCompFn.addElement( edgeIter.index(1) );
				newSel.add( selEdgeObject, newComponent );
			}
			
			if( faceIndex != -1 ) // Not a boundary edge
			{
				// Add face to the new selection list
				if( selFaces )
				{
					newComponent = indexedCompFn.create( MFn::kMeshPolygonComponent );
					indexedCompFn.addElement( faceIndex );
					newSel.add( selEdgeObject, newComponent );		
				}
				
				// Get edge opposite the current edge
				//
				newEdgeIndex = navigateFace( selEdgeObject, faceIndex, 
											 edgeIndex, OPPOSITE );
				
				// Get the face on the other side of the opposite edge
				//
				edgeIter.setIndex( newEdgeIndex, prevIndex );
				edgeIter.getConnectedFaces( faces );
				
				newFaceIndex = -1; // Initialize to a boundary edge
				if( faces.length() > 1 )
					newFaceIndex = (faceIndex == faces[0]) ? 
									faces[1] : faces[0];
									
				// Push face and edge onto list
				remainFaces.append( newFaceIndex );
				remainEdges.append( newEdgeIndex );
			}
		}
	}
	else // Ring
	{
		int reflEdgeIndex;
		int newReflEdgeIndex;
		int initReflEdgeIndex;
		MIntArray remainReflEdges;
		
		nInitEdgeVisits = 0;
		
		// Push the face+edge+reflect combo on both sides 
		// of the current edge onto the stack
		//edgeIter.setIndex( initEdgeIndex, prevIndex );
		edgeIter.getConnectedFaces( faces );
		initFaceIndex = faces[0];
		for( i=0; i < 2; i++ )
		{
			remainFaces.append( initFaceIndex );
			remainEdges.append( initEdgeIndex );
			remainReflEdges.append(
				navigateFace( selEdgeObject, initFaceIndex, initEdgeIndex, 
							(i == 0) ? PREVIOUS : NEXT ) );
		}				
		initReflEdgeIndex = remainReflEdges[1];
				
		while( remainFaces.length() )
		{
			// Pop the face, edge, and reflEdge indices
			lastIndex = remainFaces.length() - 1;
			faceIndex = remainFaces[ lastIndex ];
			edgeIndex = remainEdges[ lastIndex ];
			reflEdgeIndex = remainReflEdges[ lastIndex ];
			remainFaces.remove( lastIndex );
			remainEdges.remove( lastIndex );
			remainReflEdges.remove( lastIndex );
									
			//MGlobal::displayInfo( MString("Face: ") + faceIndex + " edge: " + edgeIndex + " reflEdgeIndex: " + reflEdgeIndex );
		
			// If the current edge the initial edge
			if( faceIndex == initFaceIndex && 
				edgeIndex == initEdgeIndex &&
				reflEdgeIndex == initReflEdgeIndex )
			{
				// Reached back to the initial edge, so the ring is closed
				if( ++nInitEdgeVisits == 2 )
					break;
			}
										
			// Add edge to the new selection list
			if( selEdges )
			{
				newComponent = indexedCompFn.create( MFn::kMeshEdgeComponent );
				indexedCompFn.addElement( edgeIndex );
				newSel.add( selEdgeObject, newComponent );
			}
			
			// Add vertices to the new selection list
			if( selVertices )
			{
				newComponent = indexedCompFn.create( MFn::kMeshVertComponent );
				edgeIter.setIndex( edgeIndex, prevIndex );
				indexedCompFn.addElement( edgeIter.index(0) );
				indexedCompFn.addElement( edgeIter.index(1) );
				newSel.add( selEdgeObject, newComponent );
			}
			
			// Add face to the new selection list
			if( selFaces )
			{
				newComponent = indexedCompFn.create( MFn::kMeshPolygonComponent );
				indexedCompFn.addElement( faceIndex );
				newSel.add( selEdgeObject, newComponent );		
			}
			
			// Get the face on opposite side of reflEdge
			edgeIter.setIndex( reflEdgeIndex, prevIndex );
			edgeIter.getConnectedFaces( faces );

			// Only if there are two faces can their be an opposite face
			if( faces.length() > 1 )
			{
				newFaceIndex = (faceIndex == faces[0]) ?
								faces[1] : faces[0];			

				int edgePrev = navigateFace( selEdgeObject, newFaceIndex, reflEdgeIndex, PREVIOUS );
				int edgeNext = navigateFace( selEdgeObject, newFaceIndex, reflEdgeIndex, NEXT );
				
				// Determine which of the edges touches the original edge
				//
				edgeIter.setIndex( edgeIndex, prevIndex );
				if( edgeIter.connectedToEdge( edgePrev ) )
				{
					newEdgeIndex = edgePrev;
					newReflEdgeIndex = navigateFace( selEdgeObject, newFaceIndex, newEdgeIndex, PREVIOUS );
				}
				else
				{
					newEdgeIndex = edgeNext;
					newReflEdgeIndex = navigateFace( selEdgeObject, newFaceIndex, newEdgeIndex, NEXT );
				}
				
				// Push face, edge, and reflEdge onto list
				remainFaces.append( newFaceIndex );
				remainEdges.append( newEdgeIndex );
				remainReflEdges.append( newReflEdgeIndex );
			}
			
		}
	}	
		
	// Set the active selection to the one previous to edge loop selection
	MGlobal::setActiveSelectionList( prevSel, MGlobal::kReplaceList );

	// Update this selection based on the list adjustment setting
	MGlobal::selectCommand( newSel, listAdjust );

	return MS::kSuccess;	
}

int SelectRingToolCmd2::navigateFace( 
	const MDagPath &dagPath, 
	const int faceIndex, 
	const int edgeIndex, 
	const Location loc )
{
	int prevIndex;
	
	MItMeshPolygon polyIter( dagPath );
	polyIter.setIndex( faceIndex, prevIndex );
	
	// Get the face's edges
	MIntArray edges;
	polyIter.getEdges( edges );
				
	// Find the edge in the current face
	unsigned int i;
	for( i=0; i < edges.length(); i++ )
	{
		if( edgeIndex == edges[i] )
		{
			int offset;
			if( loc == OPPOSITE )
				offset = edges.length() / 2;
			else
				offset = (loc == NEXT) ? 1 : -1;
			
			return edges[ (i + offset) % edges.length() ];
		}
	}
	
	return -1; // Should never reach here
}

MStatus SelectRingToolCmd2::undoIt()
{
	return MGlobal::setActiveSelectionList( prevSel, MGlobal::kReplaceList);
}

MStatus SelectRingToolCmd2::finalize()
{
	MArgList command;
	command.addArg( commandString() );

	command.addArg( MString(edgeFlag) );
	MSelectionList sel;
	sel.add( selEdgeObject, selEdgeComp );
	MStringArray edges;
	sel.getSelectionStrings( edges );
	command.addArg( edges[0] );

	command.addArg( MString(selEdgesFlag) );
	command.addArg( selEdges );

	command.addArg( MString(selFacesFlag) );
	command.addArg( selFaces );

	command.addArg( MString(selVerticesFlag) );
	command.addArg( selVertices );

	command.addArg( MString(listAdjustFlag) );
	command.addArg( (int)listAdjust );
	
	command.addArg( MString(selTypeFlag) );
	command.addArg( selType );
	
	return MPxToolCommand::doFinalize( command );
}

//
//  Context
//
class SelectRingContext2 : public MPxContext
{
public:
	SelectRingContext2();
	
	virtual void toolOnSetup( MEvent &event );
	virtual void toolOffCleanup();

	virtual MStatus	doPress( MEvent &event );
	virtual MStatus	doRelease( MEvent &event );
	
	virtual void getClassName( MString &name ) const;

	MGlobal::ListAdjustment	listAdjust;
	bool selVertices;
	bool selEdges;
	bool selFaces;
	int selType;
	
private:
	MGlobal::MSelectionMode prevSelMode;
	MSelectionMask prevCompMask;
	MSelectionMask prevObjMask;
	
	short pressX, pressY;
	short releaseX, releaseY;
	int clickBoxSize;
	
	static const MString helpTxt;
};

const MString SelectRingContext2::helpTxt( "Click on an edge" );

SelectRingContext2::SelectRingContext2()
{
	listAdjust = MGlobal::kReplaceList;
	selVertices = false;
	selEdges = true;
	selFaces = false;
	selType = SelectRingToolCmd2::RING;
	
	setTitleString( "Select Ring Tool" );
	setImage( "selectRingContext2.xpm", MPxContext::kImage1 );
}

void SelectRingContext2::getClassName( MString &name ) const
{ 
	name = "selectRingContext2";
}

void SelectRingContext2::toolOnSetup( MEvent &event )
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

void SelectRingContext2::toolOffCleanup()
{
	// Restore previous selection mode and masks
	MGlobal::setSelectionMode( prevSelMode );
	if( prevSelMode == MGlobal::kSelectComponentMode )
		MGlobal::setComponentSelectionMask( prevCompMask );
	else
		MGlobal::setObjectSelectionMask( prevObjMask );	
}

MStatus SelectRingContext2::doPress( MEvent &event )
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

MStatus SelectRingContext2::doRelease( MEvent &event )
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
		
	// Only use the first edge in the selection
	MItSelectionList selIter( origEdgesSel, MFn::kMeshEdgeComponent );
	if( !selIter.isDone() )
	{
		MDagPath dagPath;
		MObject component;	
		selIter.getDagPath( dagPath, component );
		
		SelectRingToolCmd2 &cmd = *(SelectRingToolCmd2 *) newToolCommand();
		cmd.setCurrentSelection( curSel );
		cmd.setSelectedEdgeObject( dagPath );
		cmd.setSelectedEdgeComponent( component );
		cmd.setListAdjust( listAdjust );
		cmd.setSelEdges( selEdges );
		cmd.setSelFaces( selFaces );
		cmd.setSelVertices( selVertices );
		cmd.setSelType( SelectRingToolCmd2::SelType(selType) );
		cmd.redoIt();
		cmd.finalize();
	}
		
	return MS::kSuccess;		
}

//
//  Context Command
//
class SelectRingContextCmd2 : public MPxContextCommand
{
public:	
	SelectRingContextCmd2();
	virtual MPxContext *makeObj();
	virtual	MStatus	doEditFlags();
	virtual MStatus	doQueryFlags();
	virtual MStatus	appendSyntax();

	static void *creator();
	static const MString commandName;

protected:
	SelectRingContext2 *lastMadeCtx;
};

const MString SelectRingContextCmd2::commandName( "selectRingContext2" );

SelectRingContextCmd2::SelectRingContextCmd2()
{
	lastMadeCtx = NULL;
}

MPxContext *SelectRingContextCmd2::makeObj()
{
	lastMadeCtx = new SelectRingContext2();
	return lastMadeCtx;
}

void *SelectRingContextCmd2::creator()
{
	return new SelectRingContextCmd2;
}

//
// The context object's name is the last argument to the command
// when the command is queried or edited. What isn't clear is what 
// happens when this object doesn't match lastMadeCtx.
// 
// From tests, it appears that Maya won't create a new instance
// of this context command (unlike MPxCommands, which create a new instance
// each time the command is called) but instead will use the same command
// instance whenever the object lastMadeCtx is accessed. This means
// that the context object and context command are matched and whenever
// the context object is queried or edited it will be done using
// the same context command. As such, the context object passed
// to the command will be the same as its lastMadeCtx context
// object.
//
// Should you need to get the context object name passed to
// the command, use the following code.
//	
//	MStringArray objNames;
//	pars.getObjects( objNames );
//  MGlobal::displayInfo( objNames[0] );
//

MStatus	SelectRingContextCmd2::doEditFlags()
{
	MArgParser pars = parser();

	if( pars.isFlagSet( selEdgesFlag ) )
		pars.getFlagArgument( selEdgesFlag, 0, lastMadeCtx->selEdges );
	
	if( pars.isFlagSet( selFacesFlag ) )
		pars.getFlagArgument( selFacesFlag, 0, lastMadeCtx->selFaces );

	if( pars.isFlagSet( selVerticesFlag ) )
		pars.getFlagArgument( selVerticesFlag, 0, lastMadeCtx->selVertices );
	
	if( pars.isFlagSet( selTypeFlag ) )
		pars.getFlagArgument( selTypeFlag, 0, lastMadeCtx->selType );

	return MS::kSuccess;
}

MStatus	SelectRingContextCmd2::doQueryFlags()
{
	MArgParser pars = parser();

	if( pars.isFlagSet(selVerticesFlag) )
		setResult( lastMadeCtx->selVertices );
	
	if( pars.isFlagSet(selEdgesFlag) )
		setResult( lastMadeCtx->selEdges );

	if( pars.isFlagSet(selFacesFlag) )
		setResult( lastMadeCtx->selFaces );

	if( pars.isFlagSet(selTypeFlag) )
		setResult( lastMadeCtx->selType );
		
	return MS::kSuccess;
}

MStatus	SelectRingContextCmd2::appendSyntax()
{
	MSyntax syn = syntax();
	
	syn.addFlag( selEdgesFlag, selEdgesLongFlag, MSyntax::kBoolean );
	syn.addFlag( selFacesFlag, selFacesLongFlag, MSyntax::kBoolean );
	syn.addFlag( selVerticesFlag, selVerticesLongFlag, MSyntax::kBoolean );
	syn.addFlag( selTypeFlag, selTypeLongFlag, MSyntax::kUnsigned );

	return MS::kSuccess;
}

//
// Plugin 
//
MStatus initializePlugin( MObject obj )
{
	MFnPlugin plugin( obj, "David Gould", "1.0" );

	MStatus stat;
	stat = plugin.registerContextCommand( SelectRingContextCmd2::commandName,
										  SelectRingContextCmd2::creator,
										  SelectRingToolCmd2::commandName,
										  SelectRingToolCmd2::creator,
										  SelectRingToolCmd2::newSyntax );
	if ( !stat )
		stat.perror( "registerContextCommand failed");

	return stat;
}

MStatus uninitializePlugin( MObject obj )
{
	MFnPlugin plugin( obj );

	MStatus stat;
	stat = plugin.deregisterContextCommand( SelectRingContextCmd2::commandName,
											SelectRingToolCmd2::commandName );
	if ( !stat )
		stat.perror( "deregisterContextCommand failed" );

	return stat;
}


/*
loadPlugin "C:/DavidGould.com/Writing/Morgan Kaufmann/Complete Maya Programming II/Edition #1/Drafts/Plugins/SelectRingContext2/Debug/selectRingContext2.mll";
file -f -open -type "mayaBinary" "C:/DavidGould.com/Writing/Morgan Kaufmann/Complete Maya Programming II/Edition 0/Drafts/Projects/MayaProgramming/scenes/efface.mb";addRecentFile("C:/DavidGould.com/Writing/Morgan Kaufmann/Complete Maya Programming II/Edition 0/Drafts/Projects/MayaProgramming/scenes/efface.mb", "mayaBinary");

setToolTo `selectRingContext2`;
*/