//
// Copyright (c) 2002 David Gould
//
#include "BasicLocatorManip.h"
#include <maya/MFnStateManip.h>
#include <iostream.h>

const MTypeId BasicLocatorManip::typeId( 0x00338 );

//
// N.B. The name MUST have "Manip" appended to the locator/node name it will affect. 
// Without this Maya won't be able to find it.
//
const MString BasicLocatorManip::typeName( "basicLocatorManip" ); 

void* BasicLocatorManip::creator()
{
return new BasicLocatorManip();
}

MStatus BasicLocatorManip::createChildren()
// 
// Create the base manipulators that you can interactively change
//
{
MStatus stat = MStatus::kSuccess;

xWidthDagPath = addDistanceManip( "xWidthManip", "xW");
MFnDistanceManip xWidthFn( xWidthDagPath );
xWidthFn.setStartPoint( MVector(0.0, 0.0, 0.0) );
xWidthFn.setDirection( MVector(1.0, 0.0, 0.0) );

zWidthDagPath = addDistanceManip( "zWidthManip", "zW");
MFnDistanceManip zWidthFn( zWidthDagPath );
zWidthFn.setStartPoint( MVector(0.0, 0.0, 0.0) );
zWidthFn.setDirection( MVector(0.0, 0.0, 1.0) );

typeDagPath = addStateManip( "typeManip", "tM");
MFnStateManip typeFn( typeDagPath );
typeFn.setMaxStates( 3 );

return stat;
}

MStatus BasicLocatorManip::connectToDependNode( const MObject &node )
//
// Connect the manipulators to the node's plugs. Also setup any
// callbacks for placing and displaying the manipulator components.
// 
{
MStatus stat;

targetObj = node;
/*
MFnDagNode dagNodeFn(node);
dagNodeFn.getPath(fNodePath);
*/

MFnDependencyNode nodeFn(node); 
    
MFnDistanceManip xWidthFn( xWidthDagPath );
MPlug xWidthPlug = nodeFn.findPlug( "xWidth", &stat );
xWidthFn.connectToDistancePlug( xWidthPlug );

addPlugToManipConversionCallback( xWidthFn.startPointIndex(), 
													(plugToManipConversionCallback)centerPointCallback );

addPlugToManipConversionCallback( xWidthFn.directionIndex(), 
													(plugToManipConversionCallback)sideDirectionCallback ); 

MFnDistanceManip zWidthFn( zWidthDagPath );
MPlug zWidthPlug = nodeFn.findPlug( "zWidth" );
zWidthFn.connectToDistancePlug( zWidthPlug );

addPlugToManipConversionCallback( zWidthFn.startPointIndex(), 
													 (plugToManipConversionCallback)centerPointCallback );

addPlugToManipConversionCallback( zWidthFn.directionIndex(),
													(plugToManipConversionCallback)backDirectionCallback ); 

MFnStateManip typeFn( typeDagPath );
MPlug typePlug = nodeFn.findPlug( "dispType" );
typeFn.connectToStatePlug( typePlug );

addPlugToManipConversionCallback( typeFn.positionIndex(), 
													(plugToManipConversionCallback)centerPointCallback );

// Finish up by calling the base classes connectToDependNode method
// This function must be called only once
stat = finishAddingManips();
MPxManipContainer::connectToDependNode(node);

return stat;
}

void BasicLocatorManip::draw( M3dView &view, const MDagPath &path, 
												M3dView::DisplayStyle style, M3dView::DisplayStatus status )
//
// Do any custom drawing here. In this case I just display text labels for 
// the manipulators.
//
{ 
// This must be called before any other drawing
MPxManipContainer::draw(view, path, style, status);

MFnDependencyNode nodeFn( targetObj ); //fNodePath.node()); 
MPlug xWidthPlug = nodeFn.findPlug( "xWidth" );
float xWidth;
xWidthPlug.getValue( xWidth );

MPlug zWidthPlug = nodeFn.findPlug( "zWidth" );
float zWidth;
zWidthPlug.getValue( zWidth );

view.beginGL(); 
glPushAttrib( GL_CURRENT_BIT );
    
char str[100];
MVector TextVector;
MString distanceText;

strcpy(str, "XWidth"); 
distanceText = str;
MVector xWidthTrans = nodeTranslation();
TextVector = xWidthTrans;
TextVector += worldOffset( MVector(xWidth , 0, 0) );
view.drawText(distanceText, TextVector, M3dView::kLeft);
    
strcpy(str, "ZWidth"); 
distanceText = str;
MVector zWidthTrans = nodeTranslation();
TextVector = zWidthTrans;
TextVector += worldOffset( MVector( 0, 0, zWidth ) );
view.drawText(distanceText, TextVector, M3dView::kLeft);

strcpy(str, "Type"); 
distanceText = str;
TextVector = nodeTranslation();
TextVector += worldOffset( MVector( 0, 0.1, 0 ) );
view.drawText( distanceText, TextVector, M3dView::kLeft );

glPopAttrib();
view.endGL();
}

MManipData BasicLocatorManip::centerPointCallback(unsigned index) const
{
MFnNumericData numData;
MObject numDataObj = numData.create( MFnNumericData::k3Double );
MVector vec = nodeTranslation();
numData.setData( vec.x, vec.y, vec.z );
return MManipData( numDataObj );
}

MManipData BasicLocatorManip::sideDirectionCallback( unsigned index ) const
{
MFnNumericData numData;
MObject numDataObj = numData.create(MFnNumericData::k3Double);
MVector vec = worldOffset( MVector(1, 0, 0) );
numData.setData( vec.x, vec.y, vec.z );
return MManipData( numDataObj );
}

MManipData BasicLocatorManip::backDirectionCallback(unsigned index) const
{
MFnNumericData numData;
MObject numDataObj = numData.create(MFnNumericData::k3Double);
MVector vec = worldOffset(MVector(0, 0, 1));
numData.setData(vec.x, vec.y, vec.z);
return MManipData(numDataObj);
}

MVector BasicLocatorManip::nodeTranslation() const
//
// Returns a vector that contains the node's world position
//
{
MDagPath path;
MFnDagNode dagFn( targetObj ); //fNodePath );
dagFn.getPath( path );
path.pop();

MFnTransform transformFn( path );
return transformFn.translation( MSpace::kWorld );
}

MVector BasicLocatorManip::worldOffset(MVector vect) const
//
// Returns a vector that represents the offset between the node
// and the given vector.
//
{
MDagPath path;
MFnDagNode transform( targetObj ); //fNodePath);
transform.getPath(path);
    
MVector axis;
MVector pos(path.inclusiveMatrix() * MVector(0, 0, 0));
axis = vect * path.inclusiveMatrix();
axis = axis - pos;
return axis; 
}