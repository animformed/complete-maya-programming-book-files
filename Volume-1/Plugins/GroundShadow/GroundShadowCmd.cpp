#include "GroundShadowCmd.h"
#include "GroundShadowNode.h"
#include <maya/MSelectionList.h>
#include <maya/MGlobal.h>
#include <maya/MDagPath.h>
#include <maya/MFnTransform.h>
#include <maya/MItSelectionList.h>
#include <maya/MPlug.h>
#include <maya/MPlugArray.h>
#include <maya/MTime.h>
#include <maya/MFnSet.h>
#include <assert.h>

MStatus GroundShadowCmd::doIt ( const MArgList &args )
{ 
MStatus stat;
MSelectionList selection;

// Get the initial shading group
MObject shadingGroupObj;
selection.clear();  // N.B. Ensure the selection is list empty beforehand since getSelectionListByName()  will append the matching objects
MGlobal::getSelectionListByName( "initialShadingGroup", selection );
selection.getDependNode( 0, shadingGroupObj );
MFnSet shadingGroupFn( shadingGroupObj );

// Get a list of currently selected objects
selection.clear();
MGlobal::getActiveSelectionList( selection );
MItSelectionList iter( selection );

// Find the first point light
MDagPath lightTransformPath;
MPlug pointLightTranslatePlug;
iter.setFilter( MFn::kPointLight );
for ( iter.reset(); !iter.isDone(); iter.next() )
	{
	iter.getDagPath( lightTransformPath );
	
	lightTransformPath.pop();

	MFnDagNode dagNodeFn( lightTransformPath );
	pointLightTranslatePlug = dagNodeFn.findPlug( "translate" );

	break;
	}

if( !lightTransformPath.isValid() )
	{
	MGlobal::displayError( "\nSelect a point light." );
	return MS::kFailure;
	}

unsigned int count;

// Iterate over all the geometric nodes
iter.setFilter( MFn::kGeometric );
for ( iter.reset(), count=0; !iter.isDone(); iter.next(), count++ )
	{
	MDagPath geomShapePath;
	iter.getDagPath( geomShapePath );
	
	MDagPath geomTransformPath( geomShapePath );
	geomTransformPath.pop();
					
	MFnDagNode geomShapeFn( geomShapePath );
	MObject newGeomTransform = geomShapeFn.duplicate( false, false );
	
	// Set the to shape node
	MFnDagNode newGeomShapeFn( newGeomTransform );
	newGeomShapeFn.setObject( newGeomShapeFn.child(0) );

	// Parent the new shapde node to the previous transform
	dagMod.reparentNode( newGeomShapeFn.object(), geomTransformPath.node() );

	// Assign the new surface to the shading group
    shadingGroupFn.addMember( newGeomShapeFn.object() );

	// Create groundShadow node
	MObject shadowNode = dagMod.MDGModifier::createNode( GroundShadowNode::id );
	assert( !shadowNode.isNull() );
	MFnDependencyNode shadowNodeFn( shadowNode );

	MPlug castingSurfacePlug = shadowNodeFn.findPlug( "castingSurface" );
	MPlug shadowSurfacePlug = shadowNodeFn.findPlug( "shadowSurface" );
	MPlug lightPositionPlug = shadowNodeFn.findPlug( "lightPosition" );

	MString outGeomPlugName, inGeomPlugName;
	
	switch( geomShapePath.apiType() )
		{
		case MFn::kMesh:
			outGeomPlugName = "worldMesh";
			inGeomPlugName = "inMesh";
			break;
					
		case MFn::kNurbsSurface:
			outGeomPlugName = "worldSpace";
			inGeomPlugName = "create";
			break;	
		}
	
	MPlug outGeomPlug = geomShapeFn.findPlug( outGeomPlugName ); 
	unsigned int instanceNum = geomShapePath.instanceNumber();
	outGeomPlug.selectAncestorLogicalIndex( instanceNum ); // Set the plug to the correct element in the array

	MPlug inGeomPlug = newGeomShapeFn.findPlug( inGeomPlugName );

	dagMod.connect( pointLightTranslatePlug, lightPositionPlug );
	dagMod.connect( outGeomPlug, castingSurfacePlug );
	dagMod.connect( shadowSurfacePlug, inGeomPlug );
	}

if( count == 0 )
	{
	MGlobal::displayError( "\nSelect one or more geometric objects." );
	return MS::kFailure;
	}

return redoIt();
}

MStatus GroundShadowCmd::redoIt()
{
return dagMod.doIt();
}

MStatus GroundShadowCmd::undoIt()
{
return dagMod.undoIt();
}


