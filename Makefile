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
# Author : ILKER KURTULAN - Yasar Universty
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

#
# Use: make [TARGET] [PLATFORM-OVERRIDES]
#
# Build Targets:
#      <FILE>.i - Generates preprocessed output of implementation file
#      <FILE>.asm - Generates assembly output and final output executable 
#                   of implementation files
#      <FILE>.o - Generates the object file of source files
#      all - Compiles all object files whitout linking
#      build - Compiles and links all object files into final executable
#      clean - Removes all generated files
#
# Platform Overrides:
#      <Put a description of the supported Overrides here
#
#------------------------------------------------------------------------------
include sources.mk

# Platform Overrides
PLATFORM = HOST

# Architectures Specific Flags
LINKER_FILE = msp432p401r.lds
CPU = cortex-m4
ARCH = 
SPECS = nosys.specs

# Compiler Flags and Defines
CC = gcc
LD = ld
LDFLAGS = -Wl,-Map=$(TARGET).map
CFLAGS = -g -Wall -Werror -std=c99 -O0 -DHOST -DCOURSE1 -DVERBOSE
CPPFLAGS = $(INCLUDES)
TARGET = c1m2

OBJSO = $(SOURCES:.c=.o)
OBJSI = $(SOURCES:.c=.i)
OBJSASM = $(SOURCES:.c=.asm)
OBJSS = $(SOURCES:.c=.s)

ifeq ($(PLATFORM),MSP432)
	CC = arm-none-eabi-gcc
	LD = arm-none-eabi-ld
	LDFLAGS = -O0 -T $(LINKER_FILE) -DMSP432
	CFLAGS = -g -Wall -Werror -std=c99 -mcpu=$(CPU) -mthumb \
		-march=armv7e-m -mfloat-abi=hard -mfpu=fpv4-sp-d16 \
		--specs=$(SPECS)
	
else 
	CC = gcc
	LD = ld
	LDFLAGS = -Wl,-Map=$(TARGET).map
	CFLAGS = -g -Wall -Werror -std=c99 -O0 -DHOST -DCOURSE1 -DVERBOSE
endif

%.o: %.c
	$(CC) -c $< $(CFLAGS) $(LDFLAGS) $(CPPFLAGS) -o $@

$(TARGET).out: $(OBJSO)
	$(CC) $(OBJSO) $(CFLAGS) $(LDFLAGS) -o $@

%.i: %.c
	$(CC) -E $< $(CFLAGS) $(LDFLAGS) $(CPPFLAGS) -o $@
	
%.asm: %.c $(TARGET).out
	$(CC) -S $< $(CFLAGS) $(CPPFLAGS) -o $@
	objdump -d -M intel -S $(TARGET).out > $(TARGET).asm 
 
.PHONY: compile-all
compile-all: $(SOURCES)
	$(CC) -c $(SOURCES) $(CFLAGS) $(LDFLAGS) $(CPPFLAGS)

.PHONY: build
build: $(TARGET).out

.PHONY: clean
clean:
	rm -f $(OBJSO) $(OBJSI) $(OBJSASM) $(TARGET).out $(TARGET).o \
	$(TARGET).i $(TARGET).asm $(TARGET).map


