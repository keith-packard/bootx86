_start:	.code16
	.byte 0x2e, 0x66, 0x0F, 0x01, 0x16	# lgdtl
	.word gdt_desc - _start
	mov $1, %eax
	mov %eax, %cr0
	.byte 0x66, 0xEA
	.long 1f
	.word 0x10
1:	.code32
_start32:	
	#mov $0x08, %eax		# TSS needed later for handling
	#ltr %ax			# exceptions and interrupts
	mov $0x18, %eax			# selector for 32-bit data segment
	mov %eax, %es			# propagate to all data segments
	mov %eax, %ss
	mov %eax, %ds
	mov %eax, %fs
	mov %eax, %gs
	fninit				# initialize x87 FPU
#	mov $top_of_stack, %esp
#	call main
	mov $'X', %al
2:	
	out %al, $0xe9
	jmp 2b
	hlt

gdt_desc:
	.word gdt_end - gdt - 1
	.long gdt

gdt:
	.quad 0x0000000000000000	# unused (null selector)
	.quad 0x0000000000000000	# 0x08: space for Task State Segment
	.quad 0x00CF9B000000FFFF        # 0x10: ring 0 32-bit code segment
	.quad 0x00CF93000000FFFF        # 0x18: ring 0 data segment
gdt_end:
