#
# Linux makefile for "Complete Maya Programming (Volume 2)" example plugins
# Copyright (c) 2005 David Gould (www.davidgould.com)
#
# Tested with Maya 6.0, but may work with other versions
#

SUBDIRS = CurveInfo1 CurveInfo2 CurveStar \
	  CurveSwirl DisplaceMesh MeshBlindData \
	  MeshInfo1 MeshInfo2 MeshInfo3 \
	  MeshInfo4 MeshInfo5 MeshInfo6 \
	  Molecule1 Molecule2 Molecule3 \
	  Molecule4 \
	  SelectRingContext1 SelectRingContext2 \
	  SelectVolumeContext1 \
	  SubdCube SubdInfo1 SubdToMesh \
	  SubdToNURBS SurfaceInfo1 SurfaceInfo2 \
	  Tube

all:
	set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i; done

clean:
	set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean; done
