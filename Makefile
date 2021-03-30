ASFLAGS = --32

boot: boot.o
	ld -melf_i386 -nostartfiles -nostdlib -Map=boot.map -T ldscript -o $@ boot.o

clean:
	rm -f boot boot.o

run: boot
	qemu-system-i386 -bios boot.bin
