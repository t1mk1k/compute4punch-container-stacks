SHELL = /bin/bash
#COMPILER = g++ -g
COMPILER = g++
CFLAGS = $(shell root-config --cflags)
LIBS   = $(shell root-config --glibs --libs) -lPhysics -lThread -lMinuit -lHtml -lVMC -lEG -lGeom


.SUFFIXES: .cc .o

all : M4Lepton

M4Lepton : M4Lepton.cc       			      
	${COMPILER} M4Lepton.cc -o $@ ${CFLAGS} ${LIBS} 
clean :
	rm M4Lepton
