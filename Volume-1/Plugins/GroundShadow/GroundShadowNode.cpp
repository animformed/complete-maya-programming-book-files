//
// Copyright (C) 2001 David Gould 
// 
#include "GroundShadowNode.h"
#include <maya/MPlug.h>
#include <maya/MDataBlock.h>
#include <maya/MDataHandle.h>
#include <maya/MGlobal.h>
#include <maya/MFnUnitAttribute.h>
#include <maya/MFnGenericAttribute.h>
#include <maya/MFnNurbsSurfaceData.h>
#include <maya/MFnNurbsSurface.h>
#include <maya/MPointArray.h>
#include <maya/MAngle.h>
#include <maya/MItGeometry.h>
#include <maya/MMatrix.h>
#include <assert.h>
#include <float.h>

const MTypeId GroundShadowNode::id( 0x00335 );

MObject GroundShadowNode::lightPosition;
MObject GroundShadowNode::castingSurface;
MObject GroundShadowNode::shadowSurface;
MObject GroundShadowNode::groundHeight;
 
MStatus GroundShadowNode::compute( const MPlug& plug, MDataBlock& data )
{
MStatus stat;
 
if( plug == shadowSurface )
	{
	MDataHandle groundHeightHnd = data.inputValue( groundHeight );
	MDataHandle lightPositionHnd = data.inputValue( lightPosition );
	MDataHandle castingSurfaceHnd = data.inputValue( castingSurface );
    MDataHandle shadowSurfaceHnd = data.outputValue( shadowSurface );
	
	shadowSurfaceHnd.copy( castingSurfaceHnd );

	double gHeight = groundHeightHnd.asDouble();
	MVector lightPoint( lightPositionHnd.asDouble3() );
	
	MVector planeNormal( 0.0, 1.0, 0.0 );
	MVector planePoint( 0.0, gHeight, 0.0 );
	double c = planeNormal * planePoint;

	MPoint surfPoint;
	double denom, t;
	MItGeometry iter( shadowSurfaceHnd, false );
	for( ; !iter.isDone(); iter.next() )
		{
		surfPoint = iter.position( MSpace::kWorld );
		
		denom = planeNormal * (surfPoint - lightPoint);
		if( denom != 0.0 )
			{
			t = (c - (planeNormal * lightPoint)) / denom;
			surfPoint = lightPoint + t * (surfPoint - lightPoint);
			}

		iter.setPosition( surfPoint, MSpace::kWorld );
		}

	data.setClean( plug );
	}
else 
	stat  = MS::kUnknownParameter;

return stat;
}

void *GroundShadowNode::creator()
{
return new GroundShadowNode();
}

MStatus GroundShadowNode::initialize()
{
MFnNumericAttribute nAttr;
lightPosition = nAttr.create( "lightPosition", "lpos", MFnNumericData::k3Double, 0.0 );
nAttr.setKeyable( true );

MFnUnitAttribute uAttr;
groundHeight = uAttr.create( "groundHeight", "grnd", MFnUnitAttribute::kDistance, 0.0 );
uAttr.setKeyable( true );

MFnGenericAttribute gAttr;
castingSurface = gAttr.create( "castingSurface", "csrf" );
gAttr.addAccept( MFnData::kMesh );
gAttr.addAccept( MFnData::kNurbsSurface );
gAttr.setHidden( true );

shadowSurface = gAttr.create( "shadowSurface", "ssrf" );
gAttr.addAccept( MFnData::kMesh );
gAttr.addAccept( MFnData::kNurbsSurface );
gAttr.setHidden( true );
gAttr.setStorable( false );

addAttribute( groundHeight );
addAttribute( lightPosition );
addAttribute( castingSurface );
addAttribute( shadowSurface );

attributeAffects( groundHeight, shadowSurface );
attributeAffects( lightPosition, shadowSurface );
attributeAffects( castingSurface, shadowSurface );

return MS::kSuccess;
}