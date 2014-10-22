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
#include <maya/MItMeshEdge.h>
#include <maya/MDagPath.h>

DeclareSimpleCommand( meshInfo2, "David Gould", "1.0" );

MStatus meshInfo2::doIt( const MArgList& args )
{
	MStatus stat = MS::kSuccess;

	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	MDagPath dagPath;
	MObject component;
	
	int edgeCount, v0Index, v1Index, edgeIndex;
	MPoint v0, v1;
	
	MString txt;
	MItSelectionList iter( selection );
	for ( ; !iter.isDone(); iter.next() )
	{								
		iter.getDagPath( dagPath, component );
		
		MItMeshEdge edgeIter( dagPath, component, &stat );
		if( stat == MS::kSuccess )
		{
			txt += dagPath.fullPathName() + "\n";
				
			edgeCount = edgeIter.count();
			txt += MString("# Edges: ") + edgeCount + "\n";
			
			for( ; !edgeIter.isDone(); edgeIter.next() )
			{
				edgeIndex = edgeIter.index();
				
				v0Index = edgeIter.index(0);
				v1Index = edgeIter.index(1);
				
				v0 = edgeIter.point( 0, MSpace::kWorld );
				v1 = edgeIter.point( 1, MSpace::kWorld );
				
				txt = txt + "Edge " + edgeIndex + ": " + 
					v0Index + " (" + v0.x + ", " + v0.y + ", " + v0.z + ") " +
					v1Index + " (" + v1.x + ", " + v1.y + ", " + v1.z + ")\n";
			}
		}
	}
	
	MGlobal::displayInfo( txt );

	return MS::kSuccess;
}
