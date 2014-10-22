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
#include <maya/MFnMesh.h>
#include <maya/MDagPath.h>

DeclareSimpleCommand( meshBlindData, "David Gould", "1.0" );

int newTemplateId()
{
	MFnMesh meshFn;
	static int templateId = 0;
	while( meshFn.isBlindDataTypeUsed( templateId ) )
		templateId++;
	return templateId;
}

MStatus meshBlindData::doIt( const MArgList& args )
{
	MStatus stat = MS::kSuccess;

	MSelectionList selection;
	MGlobal::getActiveSelectionList( selection );

	MDagPath dagPath;
	MObject component;
	
	MString txt;
	MItSelectionList iter( selection );
	for ( ; !iter.isDone(); iter.next() )
	{								
		iter.getDagPath( dagPath, component );
		
		MFnMesh meshFn( dagPath, &stat );
		if( stat )
		{
			MStringArray longNames;
			MStringArray shortNames;
			MStringArray dataTypes;
			longNames.append( "mortal" );
			shortNames.append( "mor" );
			dataTypes.append( "boolean" );
			
			int id0 = newTemplateId();
			meshFn.createBlindDataType( id0, longNames, shortNames, dataTypes );


			// Blind data assigned at the object-level can't be created using
			// the C++ API. Instead the blindDataType and polyBlindData MEL commands
			// are used. Create the "mortal" blind data
			//
			//MGlobal::executeCommand( MString( "blindDataType -id ") + id0 + " -dataType \"boolean\" -longDataName \"mortal\" -shortDataName \"mor\"" );
			
			
			// Create the "healing" blind data
			//			
			longNames[0] = "healing";
			shortNames[0] = "hel";
			dataTypes[0] = "double";
			
			int id1 = newTemplateId();
			meshFn.createBlindDataType( id1, longNames, shortNames, dataTypes );
			
			// Assign blind data
			//
			MGlobal::executeCommand( MString( "polyBlindData -id ") + id0 + " -associationType \"object\" -shape -longDataName \"mortal\" -booleanData 0" );
			
			// N.B. Must initialize all the faces with blind data otherwise
			// they will contain random values
			double healingData;
			int i;
			for( i=0; i < meshFn.numPolygons(); i++ )
			{
				switch( i )
				{
					case 4:
						healingData = 0.5;
						break;
					
					case 1:
						healingData = 1.0;
						break;
						
					default:
						healingData = 0.0;
						break;
				}
				
				meshFn.setDoubleBlindData( i, MFn::kMeshPolygonComponent, id1, "healing", healingData );
			}
			
			// Retrive information about the blind data templates
			int id;
			unsigned int j;
			for( i=0; i < 2; i++ )
			{
				id = (i == 0) ? id0 : id1;
				txt += MString( "\nBlind Data Template: " ) + id;
				
				meshFn.getBlindDataAttrNames( id, longNames, shortNames, dataTypes );
				for( j=0; j < longNames.length(); j++ )
					txt += MString( "\n  " ) + longNames[j] + " " + shortNames[j] + " " + dataTypes[j];
			}
						
			// Query the blind data
			// 
			txt += MString( "\nBlind Data: " ) + dagPath.fullPathName();
			MDagPath shapePath = dagPath;
			shapePath.extendToShape();
			MIntArray mortalData;
			MGlobal::executeCommand( MString( "polyQueryBlindData -id ") + id0 + " " + shapePath.fullPathName(), mortalData );
			txt += MString( "\n  Mortal: " ) + mortalData[0];
			
			for( i=0; i < meshFn.numPolygons(); i++ )
			{
				meshFn.getDoubleBlindData( i, MFn::kMeshPolygonComponent, id1, "healing", healingData );
				txt += MString( "\n  Healing: face[") + i + "] " + healingData;
			}
		}
	}
	
	MGlobal::displayInfo( txt );
	
	clearResult();
	
	return MS::kSuccess;
}
