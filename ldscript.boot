SECTIONS {
	.text 0xffff0000: { *(.text*) }
	.data 0x00000000: { *(.data) }
	.bss		: { *(.bss) }
	.ljmp 0xFFFFFFF0: { BYTE(0xEA) BYTE(0) BYTE(0) BYTE(0) BYTE(0xf0) BYTE(0) BYTE(0) BYTE(0) LONG(0) LONG(0) }
}
