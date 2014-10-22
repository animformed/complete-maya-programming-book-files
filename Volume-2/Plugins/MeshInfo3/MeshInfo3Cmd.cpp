//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#include <maya/MSimple.h>
#include <maya/MGlobal.h>
#include <maya/MItSelectionList.h>
#include <maya/MItMeshPolygon.h>
#include <maya/MDagPath.h>

DeclareSimpleCommand( meshInfo3, "David Gould", "1.0" );

MStatus meshInfo3::doIt( const MArgList& args )
{
	MStatus stat = MS::kSuccess;

	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	MDagPath dagPath;
	MObject component;
	
	int i, polyCount, polyIndex, vertCount;
	MPoint p;
	
	MString txt;
	MItSelectionList iter( selection );
	for ( ; !iter.isDone(); iter.next() )
	{								
		iter.getDagPath( dagPath, component );
		
		MItMeshPolygon polyIter( dagPath, component, &stat );
		if( stat == MS::kSuccess )
		{
			txt += MString( "Object: " ) + dagPath.fullPathName() + "\n";
				
			polyCount = polyIter.count();
			txt += MString("# Polygons: ") + polyCount + "\n";
			
			for( ; !polyIter.isDone(); polyIter.next() )
			{
				polyIndex = polyIter.index();
				txt += MString("Poly ") + polyIndex + "\n";
				
				vertCount = polyIter.polygonVertexCount();
				txt += MString(" # Verts: ") + vertCount + "\n";
				
				for( i=0; i < vertCount; i++ )
				{
					p = polyIter.point( i, MSpace::kWorld );				
					txt += MString(" (") + p.x + ", " + p.y + ", " + p.z + ")";
				}
				
				txt += "\n";
			}
		}
	}
	
	MGlobal::displayInfo( txt );

	return MS::kSuccess;
}
