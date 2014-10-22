#
# Linux makefile for "Complete Maya Programming" example plugins
# Copyright (c) 2003 David Gould (www.davidgould.com)
#

SUBDIRS = BasicLocator BasicLocator2 Clock GoRolling GroundShadow \
	  HelloWorld HelloWorld2 Melt Posts1 Posts2 Posts3 \
	  Posts4 Posts5 Squash SwirlDeformer SwirlDeformer2

all:
	set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i; done

clean:
	set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean; done
