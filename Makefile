
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


