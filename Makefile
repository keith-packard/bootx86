ASFLAGS = --32

boot: boot.o ldscript
	ld -melf_i386 -nostartfiles -nostdlib -Map=boot.map -T ldscript -o $@ boot.o

boot.bin: boot
	objcopy -O binary boot $@

clean:
	rm -f boot boot.o boot.bin

run: boot.bin
	qemu-system-i386 -bios boot.bin
