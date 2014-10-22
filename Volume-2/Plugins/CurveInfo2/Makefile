#
# Linux makefile for "Complete Maya Programming (Volume 2)" example plugins
# Copyright (c) 2005 David Gould (www.davidgould.com)
#
# Tested with Maya 6.0, but may work with other versions
#

C++ = c++
CFLAGS = -O3 -pipe -D_BOOL -DLINUX -mcpu=pentium4
C++FLAGS = $(CFLAGS) $(WARNFLAGS) -Wno-deprecated -fno-gnu-keywords
INCLUDES = -I. -I$(MAYA_LOCATION)/include -I/usr/X11R6/include
LD = $(C++) -shared $(NO_TRANS_LINK) $(C++FLAGS)
LIBS = -L$(MAYA_LOCATION)/lib -lOpenMaya -lOpenMayaAnim -lOpenMayaUI

OBJECTS = CurveInfo2Cmd.o

.SUFFIXES: .cpp .o .so

.cpp.o:
	$(C++) -c $(INCLUDES) $(C++FLAGS) $<

.o.so:
	$(LD) -o $@ $< $(LIBS)

.cpp.so:
	$(LD) -o $@ $(INCLUDES) $< $(LIBS)

CurveInfo2Cmd.so: $(OBJECTS)
	$(LD) -o $@ $(OBJECTS) $(LIBS)

clean:
	-rm -f *.o *.so
