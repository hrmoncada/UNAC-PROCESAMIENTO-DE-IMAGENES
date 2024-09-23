# https://gist.github.com/snim2/1419118
# Minimal Makefile which compiles multiple C files into individual executables.

FF = gfortran
#CC=gcc

RM = rm

FFLAGS = -c -Wall -O3

LDFLAGS = -lm

SOURCES = $(wildcard *.f90)

OBJECTS = $(SOURCES:.f90=.o)

EXECS = $(SOURCES:%.f90=%)

.PHONY: all
all: $(OBJECTS) $(EXECS)

.f90.o:
	$(FF) $(CFLAGS) $< -o $@

.o.: 
	$(FF) $^ $(LDFLAGS) -o $@

.PHONY: clean
clean:
	-@ $(RM) *.o 
	-@ $(RM) $(EXECS)
