//
//  This file accompanies the book "Complete Maya Programming (Volume 2)"
//  For further information visit http://www.davidgould.com
// 
//  Copyright (C) 2004 David Gould 
//  All rights reserved.
//
#include <maya/MFnPlugin.h>
#include "SelectVolumeContext1.h"
#include "SelectVolumeLocator1.h"

MStatus initializePlugin( MObject obj )
{
	MFnPlugin plugin( obj, "David Gould", "1.0" );

	MStatus stat;

	stat = plugin.registerNode( SelectVolumeLocator1::typeName,
								SelectVolumeLocator1::typeId,
								&SelectVolumeLocator1::creator, &SelectVolumeLocator1::initialize, 
								MPxNode::kLocatorNode );
	if ( !stat )
	{
		stat.perror( "registerNode failed");
		return stat;
	}
		
	stat = plugin.registerContextCommand( SelectVolumeContextCmd1::commandName,
										  SelectVolumeContextCmd1::creator,
										  SelectVolumeToolCmd1::commandName,
										  SelectVolumeToolCmd1::creator,
										  SelectVolumeToolCmd1::newSyntax );
	if ( !stat )
		stat.perror( "registerContextCommand failed");

	return stat;
}

MStatus uninitializePlugin( MObject obj )
{
	MFnPlugin plugin( obj );

	MStatus stat;

	stat = plugin.deregisterNode( SelectVolumeLocator1::typeId );
	if( !stat ) 
	{
		stat.perror( "deregisterNode failed" );
		return stat;
	}
	
	stat = plugin.deregisterContextCommand( SelectVolumeContextCmd1::commandName,
											SelectVolumeToolCmd1::commandName );
	if ( !stat )
		stat.perror( "deregisterContextCommand failed" );

	return stat;
}

/*
loadPlugin "C:/DavidGould.com/Writing/Morgan Kaufmann/Complete Maya Programming II/Edition #1/Drafts/Plugins/SelectVolumeContext1/Debug/selectVolumeContext1.mll";

file -f -open -type "mayaBinary" "C:/DavidGould.com/Writing/Morgan Kaufmann/Complete Maya Programming II/Edition 0/Drafts/Projects/MayaProgramming/scenes/tmp9.mb";addRecentFile("C:/DavidGould.com/Writing/Morgan Kaufmann/Complete Maya Programming II/Edition 0/Drafts/Projects/MayaProgramming/scenes/tmp9.mb", "mayaBinary");
setToolTo `selectVolumeContext1`;


selectVolumeToolCmd1 -sphere 0.5 0 0.5 0.35 -sphere 0 0 0 0.25;

selectVolumeToolCmd1 -sphere 0.35 0 0.35 0.1 -sphere 0 0 0 0.25;
selectVolumeToolCmd1 -listAdjust 3 -sphere 0.35 0 0.35 0.1;

file -f -new;loadPlugin "C:/DavidGould.com/Writing/Morgan Kaufmann/Complete Maya Programming II/Edition #1/Drafts/Plugins/SelectVolumeContext1/Debug/selectVolumeContext1.mll";

file -f -open -type "mayaBinary" "C:/DavidGould.com/Writing/Morgan Kaufmann/Complete Maya Programming II/Edition 0/Drafts/Projects/MayaProgramming/scenes/tmp9.mb";addRecentFile("C:/DavidGould.com/Writing/Morgan Kaufmann/Complete Maya Programming II/Edition 0/Drafts/Projects/MayaProgramming/scenes/tmp9.mb", "mayaBinary");
setToolTo `selectVolumeContext1`;

unloadPlugin selectVolumeContext1;



createNode selectVolumeLocator1;


*/