BASE=arm-none-eabi
CC=$(BASE)-gcc
ASM=$(BASE)-as
LD=$(BASE)-ld
OBJCOPY=$(BASE)-objcopy

TARGET=arm926ej-s

build:
	$(ASM) -mcpu=$(TARGET) -g startup.s -o startup.o
	$(CC) -c -mcpu=$(TARGET) -g hello.c -o hello.o
	$(LD) -T hello.ld hello.o startup.o -o hello.elf
	$(OBJCOPY) -O binary hello.elf hello.bin

run:
	echo "To exit, hit crtl-a, x"
	qemu-system-arm -M versatilepb -m 32M -nographic -kernel hello.bin

clean:
	rm -f *.o *.elf *.bin *.out

all: build run

