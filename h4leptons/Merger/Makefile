SHELL = /bin/bash
#COMPILER = g++ -g
COMPILER = g++
CFLAGS = $(shell root-config --cflags)
LIBS   = $(shell root-config --glibs --libs) -lPhysics -lThread -lMinuit -lHtml -lVMC -lEG -lGeom


.SUFFIXES: .cc .o

all : MergeOutput

MergeOutput : MergeOutput.cc       			      
	${COMPILER} MergeOutput.cc -o $@ ${CFLAGS} ${LIBS} 
clean :
	rm MergeOutput
