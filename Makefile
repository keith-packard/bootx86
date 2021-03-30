ASFLAGS = --32

all: bios.bin boot

bios: bios.o ldscript.bios
	ld -melf_i386 -nostartfiles -nostdlib -Map=bios.map -T ldscript.bios -o $@ bios.o

bios.bin: bios
	objcopy -O binary bios $@

boot: boot.o ldscript.boot
	ld -melf_i386 -nostartfiles -nostdlib -Map=boot.map -T ldscript.boot -o $@ boot.o

boot.bin: boot
	objcopy -O binary boot $@

clean:
	rm -f boot boot.o boot.bin bios bios.o bios.bin

run-qemu: bios.bin boot
	qemu-system-i386 -machine type=pc-i440fx-3.1 -bios bios.bin -kernel boot

run-bochs: boot.bin bochsrc
	bochs -f bochsrc
