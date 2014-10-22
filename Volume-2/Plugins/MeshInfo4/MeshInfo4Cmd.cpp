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
#include <maya/MItMeshFaceVertex.h>
#include <maya/MDagPath.h>

DeclareSimpleCommand( meshInfo4, "David Gould", "1.0" );

MStatus meshInfo4::doIt( const MArgList& args )
{
	MStatus stat = MS::kSuccess;

	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	MDagPath dagPath;
	MObject component;
	
	MColor c;
	
	MString txt;
	MItSelectionList iter( selection );
	for ( ; !iter.isDone(); iter.next() )
	{								
		iter.getDagPath( dagPath, component );
				
		MItMeshFaceVertex fvIter( dagPath, component, &stat );
		if( stat == MS::kSuccess )
		{
			txt += MString( "Object: " ) + dagPath.fullPathName() + "\n";	
									
			for( ; !fvIter.isDone(); fvIter.next() )
			{
				int vertId = fvIter.vertId();
				int faceId = fvIter.faceId();
				int faceVertId = fvIter.faceVertId();				
				
				txt += MString(" Face ") + faceId + ": mesh-relative-vertexID (" + vertId + "), face-relative-vertexID (" + faceVertId + ")\n";
				if( fvIter.hasColor() )
				{	
					fvIter.getColor( c );
					txt += MString("   Color: ") + c.r + ", " + c.g + ", " + c.b + "\n";	
				}
				else
					txt += MString("   no color\n");					
			}
		}
	}
	
	MGlobal::displayInfo( txt );

	return MS::kSuccess;
}
