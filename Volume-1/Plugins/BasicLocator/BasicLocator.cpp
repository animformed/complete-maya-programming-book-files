//
// Copyright (C) 2001 David Gould 
// 
#include "BasicLocator.h"
#include <maya/MGlobal.h>
#include <maya/MPointArray.h>
#include <maya/MFnDagNode.h>

const MTypeId BasicLocator::typeId( 0x00336 );
const MString BasicLocator::typeName( "basicLocator" );

MObject BasicLocator::xWidth;
MObject BasicLocator::zWidth;
MObject BasicLocator::dispType;

const double M_2PI = M_PI * 2.0;

bool BasicLocator::getCirclePoints( MPointArray &pts ) const
{
MStatus stat;
MObject thisNode = thisMObject();
MFnDagNode dagFn( thisNode  );  

MPlug xWidthPlug = dagFn.findPlug( xWidth, &stat );
float xWidthValue;
xWidthPlug.getValue( xWidthValue );

MPlug zWidthPlug = dagFn.findPlug( zWidth, &stat );
float zWidthValue;
zWidthPlug.getValue( zWidthValue );

MPlug typePlug = dagFn.findPlug( dispType, &stat );
short typeValue;
typePlug.getValue( typeValue );

unsigned int nCirclePts;

switch( typeValue )
   {
   case 0:
       nCirclePts = 4;
       break;
   case 1:
       nCirclePts = 5;
       break;
   default:
       nCirclePts = 20;
       break;
   }

pts.clear();
pts.setSizeIncrement( nCirclePts );
   
MPoint pt;
pt.y = 0.0;
   
const double angleIncr = M_2PI / (nCirclePts - 1);
double angle = 0.0;
unsigned int i=0;
for( ; i < nCirclePts; i++, angle+=angleIncr )
	{
	pt.x = xWidthValue * cos( angle );
	pt.z = zWidthValue * sin( angle );
	pts.append( pt );
	}

return true;
}

void BasicLocator::draw( M3dView & view, const MDagPath & path,
M3dView::DisplayStyle style, M3dView::DisplayStatus status )
{ 
view.beginGL(); 
glPushAttrib( GL_CURRENT_BIT );

MPointArray pts;
getCirclePoints( pts );

glBegin(GL_LINE_STRIP);
for( unsigned int i=0; i < pts.length(); i++ )
	glVertex3f( float(pts[i].x), float(pts[i].y), float(pts[i].z) );
glEnd();

glBegin(GL_LINES);
	glVertex3f( -0.5f, 0.0f, 0.0f );
	glVertex3f( 0.5f, 0.0f, 0.0f );

	glVertex3f( 0.0f, 0.0f, -0.5f );
	glVertex3f( 0.0f, 0.0f, 0.5f );
glEnd();

glPopAttrib();
view.endGL();       
}

bool BasicLocator::isBounded() const
{ 
return true;
}

MBoundingBox BasicLocator::boundingBox() const
//
// N.B. It is important to have this bounding box function otherwise zoom selected and 
// zoom all won't work correctly.
//
{   
MPointArray pts;
getCirclePoints( pts );

MBoundingBox bbox;
for( unsigned int i=0; i < pts.length(); i++ )
	bbox.expand( pts[i] );
return bbox;
}


void *BasicLocator::creator()
{
return new BasicLocator();
}

MStatus BasicLocator::initialize()
{ 
MFnUnitAttribute unitFn;    
MFnNumericAttribute numFn;
MStatus stat;
    
xWidth = unitFn.create( "xWidth", "xw", MFnUnitAttribute::kDistance );
unitFn.setDefault( MDistance(1.0, MDistance::uiUnit()) );
unitFn.setMin( MDistance(0.0, MDistance::uiUnit()) );
unitFn.setKeyable( true );
stat = addAttribute( xWidth );
if (!stat) 
    {
	stat.perror( "Unable to add \"xWidth\" attribute" );
	return stat;
    } 

zWidth = unitFn.create( "zWidth", "zw", MFnUnitAttribute::kDistance );
unitFn.setDefault( MDistance(1.0, MDistance::uiUnit()) );
unitFn.setMin( MDistance(0.0, MDistance::uiUnit()) );
unitFn.setKeyable( true );
stat = addAttribute( zWidth );
if (!stat) 
    {
	stat.perror( "Unable to add \"zWidth\" attribute" );
	return stat;
    } 

dispType = numFn.create( "dispType", "att", MFnNumericData::kShort );
numFn.setDefault( 0);
numFn.setMin( 0 );
numFn.setMax( 2 );
numFn.setKeyable( true );
stat = addAttribute( dispType );
if (!stat) 
    {
	stat.perror( "Unable to add \"dispType\" attribute" );
	return stat;
    }

return MS::kSuccess;
}