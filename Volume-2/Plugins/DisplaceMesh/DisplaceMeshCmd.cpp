//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#include "DisplaceMeshCmd.h"
#include "DisplaceMeshNode.h"
#include <maya/MSelectionList.h>

const char *strengthFlag = "-s", *strengthLongFlag = "-strength";
const char *imageFilenameFlag = "-i", *imageFilenameLongFlag = "-image";

MSyntax DisplaceMeshCmd::newSyntax()
{
    MSyntax syntax;

    syntax.addFlag( strengthFlag, strengthLongFlag, MSyntax::kDouble );
    syntax.addFlag( imageFilenameFlag, imageFilenameLongFlag, MSyntax::kString );
	
	syntax.enableQuery( false );
	syntax.enableEdit( false );
		
	return syntax;
}

MStatus DisplaceMeshCmd::doIt( const MArgList &args )
{
	// Initialize values to defaults
	strength = DisplaceMeshNode::strengthDefault();
	imageFilename = DisplaceMeshNode::imageFilenameDefault(); 
		
	// Get the options from the command line
	MStatus stat;
	MArgDatabase argData( syntax(), args, &stat );
	if( !stat )
		return stat;

	if( argData.isFlagSet( strengthFlag ) )
		argData.getFlagArgument( strengthFlag, 0, strength );
	
	if( argData.isFlagSet( imageFilenameFlag ) )
		argData.getFlagArgument( imageFilenameFlag, 0, imageFilename );

	// Iterate over the meshes
	// Get a list of currently selected objects
	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	int nSelMeshes = 0;
	MDagPath dagPath;
	MItSelectionList iter( selection, MFn::kMesh );
	for ( ; !iter.isDone(); iter.next() )
	{
		nSelMeshes++;								

		// Get DAG path to mesh shape node
		iter.getDagPath( dagPath );		
		dagPath.extendToShape();
		
		break;
	}
	
	if( nSelMeshes == 0 )
	{
		MGlobal::displayWarning( "Select one or more meshes" );
		return MS::kFailure;
	}	
	
	CmpMeshModifierCmd::doIt( dagPath, DisplaceMeshNode::id );
	
	return MS::kSuccess;
}

void *DisplaceMeshCmd::creator()
{ 
	return new DisplaceMeshCmd; 
}

MStatus DisplaceMeshCmd::initModifierNode( MObject &node, MDagModifier &dagMod )
//
// This function takes the newly created mesh modifier node and intializes it. 
// It should record all the changes it makes to the node in the supplied dagMod object.
// This ensures that the changes can be undone.
//
{
	// @@@ to do, initialize the node
	//MGlobal::displayInfo( "displaceMesh1's initModifierNode is called" );
	//MGlobal::displayInfo( MString( "s: " ) + strength + " name: " + imageFilename );
	
	MFnDependencyNode depFn( node );
	MString name = depFn.name();
	
	
	dagMod.commandToExecute( MString( "setAttr " ) + name + ".strength " + strength );
	dagMod.commandToExecute( MString( "setAttr -type \"string\"" ) + name + ".imageFilename \"" + imageFilename + "\"" );
	
	return MS::kSuccess;
}

/*
	file -f -open -type "mayaAscii" "C:/DavidGould.com/Writing/Morgan Kaufmann/Complete Maya Programming II/Edition 0/Drafts/Projects/MayaProgramming/scenes/PlaneMeshDetailed.ma";addRecentFile("C:/DavidGould.com/Writing/Morgan Kaufmann/Complete Maya Programming II/Edition 0/Drafts/Projects/MayaProgramming/scenes/PlaneMeshDetailed.ma", "mayaAscii");
	displaceMesh -strength 0.1 -image "C:/DavidGould.com/Writing/Morgan Kaufmann/Complete Maya Programming II/Edition #1/Drafts/Plugins/DisplaceMesh/smiley.jpg";
*/
