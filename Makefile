#All section will invoke default commands.


USE_NANO = --specs=nano.specs
CC=-T msp432p401r.lds
CC=-DMSP432 or -DHOST




all:



#In this part ,the native compiler or the msp432 will be executed.
	
memory.o PLATFORM=MSP432:
	make build PLATFORM=MSP432
	gcc stats.c -o c1m2.out
	./c1m2.out

make build PLAFTORM=HOST:
	make build PLATFORM=HOST
	gcc stats.c -o c1m2.out
	./c1m2.out

clean:
	-rm -rf *o c1m2

	
	
