#******************************************************************************
# Copyright (C) 2017 by Alex Fosdick - University of Colorado
#
# Redistribution, modification or use of this software in source or binary
# forms is permitted as long as the files maintain this copyright. Users are 
# permitted to modify this and use it to learn about the field of embedded
# software. Alex Fosdick and the University of Colorado are not liable for any
# misuse of this material. 
#
#*****************************************************************************

#------------------------------------------------------------------------------
# Assignment 2 : Introduction to Embedded Software
#
# Use: make [TARGET] [PLATFORM-OVERRIDES]
#
# Build Targets:
#      <Put a description of the supported targets here>
#
# Platform Overrides:
#      <Put a description of the supported Overrides here
#
#------------------------------------------------------------------------------
include sources.mk

ifeq ($(PLATFORM),HOST)
	CC = -DHOST
else
	CC = -T msp432p401r.lds
endifd

# Platform Overrides
PLATFORM = 

# Architectures Specific Flags
LINKER_FILE = 
CPU = 
ARCH = 
SPECS = 

# Compiler Flags and Defines
MSP432 = -T msp432p401r.lds
Target = -DHOST
CC = 
LD = 
LDFLAGS = 
CFLAGS = 
CPPFLAGs =
W = -Wall



#Varaible decleraction

USE_NANO = --specs=nano.specs
CC=arm-none-eabi-gcc


#make all section will execute our default operation
.PHONY : compile-all
compile-all:
	gcc -c main.c memory.c
	

#In this part ,the native compiler or the msp432 will be executed.
	
memory.o PLATFORM=MSP432:
	$(CC) main.c -o c1m2.out
	./c1m2.out

build PLAFTORM=HOST:
	gcc -o c1m2.out main.c
	./c1m2.out

main.asm PLATFORM=HOST:
	
memory.i PLATFORM=HOST:

%.i:
	gcc -E c1m2 main.c
	
%.asm:
	gcc -S c1m2 main.c
	
%.o:
	gcc -o c1m2 main.c


.PHONY : build
build:
	gcc -o c1m2 main.o memory.o




