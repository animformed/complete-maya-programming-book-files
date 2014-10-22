#ifndef _SquashNode
#define _SquashNode
//
// Copyright (C) 2001 David Gould 
// 
// File: SquashNode.h
//
// Dependency Graph Node: Squash
//
// Author: Maya SDK Wizard
//

#include <maya/MPxNode.h>
#include <maya/MFnNumericAttribute.h>
#include <maya/MTypeId.h> 

 
class Squash : public MPxNode
{
public:
						Squash();
	virtual				~Squash(); 

	virtual MStatus		compute( const MPlug& plug, MDataBlock& data );

	static  void*		creator();
	static  MStatus		initialize();

public:

	// There needs to be a MObject handle declared for each attribute that
	// the node will have.  These handles are needed for getting and setting
	// the values later.
	//
	static  MObject		input;		// Example input attribute
	static  MObject		output;		// Example output attribute


	// The typeid is a unique 32bit indentifier that describes this node.
	// It is used to save and retrieve nodes of this type from the binary
	// file format.  If it is not unique, it will cause file IO problems.
	//
	static	MTypeId		id;
};

#endif
