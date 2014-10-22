#
# Linux makefile for "Complete Maya Programming" example plugins
# Copyright (c) 2003 David Gould (www.davidgould.com)
#

C++ = c++
CFLAGS = -O3 -mpentiumpro -D_BOOL -DLINUX
C++FLAGS = $(CFLAGS) $(WARNFLAGS)
INCLUDES = -I. -I$(MAYA_LOCATION)/include -I/usr/X11R6/include
LD = $(C++) -shared $(C++FLAGS)
LIBS = -L$(MAYA_LOCATION)/lib -lOpenMaya -lOpenMayaAnim -lOpenMayaUI

OBJECTS = helloWorldCmd.o

.SUFFIXES: .cpp .o .so

.cpp.o:
	$(C++) -c $(INCLUDES) $(C++FLAGS) $<

.o.so:
	$(LD) -o $@ $< $(LIBS)

.cpp.so:
	$(LD) -o $@ $(INCLUDES) $< $(LIBS)

helloWorld.so: $(OBJECTS)
	$(LD) -o $@ $(OBJECTS) $(LIBS)

clean:
	-rm -f *.o *.so
