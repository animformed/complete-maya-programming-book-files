//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#include "Molecule4Cmd.h"
#include "Molecule4Node.h"

const char *radiusFlag = "-r", *radiusLongFlag = "-radius";
const char *segsFlag = "-s", *segsLongFlag = "-segments";
const char *ballRatioFlag = "-br", *ballRatioLongFlag = "-ballRatio";

MSyntax Molecule4Cmd::newSyntax()
{
    MSyntax syntax;

    syntax.addFlag( radiusFlag, radiusLongFlag, MSyntax::kDistance );
    syntax.addFlag( segsFlag, segsLongFlag, MSyntax::kLong );
    syntax.addFlag( ballRatioFlag, ballRatioLongFlag, MSyntax::kDouble );
	
	syntax.enableQuery( false );
	syntax.enableEdit( false );

	return syntax;
}

MStatus Molecule4Cmd::doIt( const MArgList &args )
{
	MStatus stat;
	
	// Initialize options to default values
	radius = Molecule4Node::radiusDefault();
	segs = Molecule4Node::segmentsDefault();
	ballRodRatio = Molecule4Node::ballRatioDefault();
	
	moleculeNodes.clear();
	meshShapeNodes.clear();
	
	// Get the options from the command line
	MArgDatabase argData( syntax(), args, &stat );
	if( !stat )
		return stat;

	if( argData.isFlagSet( radiusFlag ) )
		argData.getFlagArgument( radiusFlag, 0, radius );
	
	if( argData.isFlagSet( segsFlag ) )
		argData.getFlagArgument( segsFlag, 0, segs );

	if( argData.isFlagSet( ballRatioFlag ) )
		argData.getFlagArgument( ballRatioFlag, 0, ballRodRatio );
	
	// Get a list of currently selected objects
	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	MObject inMeshShape;
	MPlug outMeshPlug, inMeshPlug; 
	MFnDependencyNode nodeFn, molecule4NodeFn;
	MObject molecule4Node, newMeshTransform, newMeshShape;
	MFnDagNode dagFn;
		
	// Iterate over the meshes
	int nSelMeshes = 0;
	MDagPath dagPath;
	MItSelectionList iter( selection, MFn::kMesh );
	for ( ; !iter.isDone(); iter.next() )
	{
		nSelMeshes++;								
		iter.getDagPath( dagPath );
		
		// Get the mesh shape node
		dagPath.extendToShape();
		inMeshShape = dagPath.node();	
		
		// Get the world output mesh on the input mesh shape
		dagFn.setObject( dagPath );
		unsigned int instanceNum = dagPath.instanceNumber();
		MPlug outMeshesPlug = dagFn.findPlug( "worldMesh" );
		outMeshPlug = outMeshesPlug.elementByLogicalIndex( instanceNum ); 
		
		// Create new molecule4 node
		molecule4Node = dagMods[0].MDGModifier::createNode( Molecule4Node::id );
		moleculeNodes.append( molecule4Node );
		molecule4NodeFn.setObject( molecule4Node );
	
		MPlug inMeshPlug = molecule4NodeFn.findPlug( "inMesh" );
		dagMods[0].connect( outMeshPlug, inMeshPlug );

		// N.B. The transform and shape need to be created separately. When creating a mesh shape node a parent
		// transform is automatically created but unfortunately the shape node can't be accessed
		// by MFnDagNode since it, technically, doesn't exist yet.
		// By creating the two nodes separately, this ensures that the shape node exists to work on with MFnDagNode.
		//
		newMeshTransform = dagMods[0].createNode( "transform" );
		newMeshShape = dagMods[0].createNode( "mesh", newMeshTransform );
		meshShapeNodes.append( newMeshShape );
		
		dagMods[0].renameNode( newMeshTransform, "molecule" );		
		
		nodeFn.setObject( newMeshShape );
				
		// Connect output of molecule into new mesh
		outMeshPlug = molecule4NodeFn.findPlug( "outMesh", &stat );
		inMeshPlug = nodeFn.findPlug( "inMesh", &stat );
		stat = dagMods[0].connect( outMeshPlug, inMeshPlug );
	}
	
	if( nSelMeshes == 0 )
	{
		MGlobal::displayWarning( "Select one or more meshes" );
		return MS::kFailure;
	}

	// Create all the nodes and their connections
	dagMods[0].doIt();
	
	// N.B. Only now that the nodes have been created will their final names
	// be known. The second stage can be completed. This will update the 
	// molecule node attributes, ensure the new shape nodes are assigned the initial shading group,
	// and the molecule nodes are selected
	
	// Set the molecule node attributes
	unsigned int i;
	for( i=0; i < moleculeNodes.length(); i++ )
	{
		nodeFn.setObject( moleculeNodes[i] );
		dagMods[1].commandToExecute( MString("setAttr ") + nodeFn.name() + ".radius " + radius.value() );
		dagMods[1].commandToExecute( MString("setAttr ") + nodeFn.name() + ".segments " + segs );
		dagMods[1].commandToExecute( MString("setAttr ") + nodeFn.name() + ".ballRatio " + ballRodRatio );
	}
	
	// Ensure all the new shape nodes are included in the initialShadingGroup
	for( i=0; i < meshShapeNodes.length(); i++ )
	{
		nodeFn.setObject( meshShapeNodes[i] );
		dagMods[1].commandToExecute( MString( "sets -e -fe initialShadingGroup " ) + nodeFn.name() );
	}
	
	// Select the moleculeNodes
	MString cmd( "select -r" );
	for( i=0; i < moleculeNodes.length(); i++ )
	{
		nodeFn.setObject( moleculeNodes[i] );
		cmd += " " + nodeFn.name();	
	}

	dagMods[1].commandToExecute( cmd );

	dagMods[1].doIt();
	
	return MS::kSuccess;
}

MStatus	Molecule4Cmd::redoIt()
{
	int i;
	for( i=0; i < 2; i++ )
		dagMods[i].doIt();

	return MS::kSuccess;
}

MStatus	Molecule4Cmd::undoIt()
{
	int i;
	// Undo from most recent to least recent modifier
	// i.e. reverse order from doIt's
	for( i=1; i >= 0; i-- )
		dagMods[i].undoIt();

	return MS::kSuccess;
}

/*
string $moleculeScripts = "D:/DavidGould.com/Writing/Morgan Kaufmann/Complete Maya Programming II/Edition #1/Drafts/Latest/Plugins/Molecule4";
string $newScriptPath=$moleculeScripts + ";" +`getenv "MAYA_SCRIPT_PATH"`;
putenv "MAYA_SCRIPT_PATH" $newScriptPath;

unloadPlugin molecule4

molecule4
*/