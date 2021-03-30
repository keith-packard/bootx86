	# © 2021, Keith Packard and Mike Haertel
	#
	# All rights reserved.
	# 
	# Redistribution and use in source and binary forms, with or without
	# modification, are permitted provided that the following conditions are met:
	# 
	# 1. Redistributions of source code must retain the above copyright notice, this
	#    list of conditions and the following disclaimer.
	# 
	# 2. Redistributions in binary form must reproduce the above copyright notice,
	#    this list of conditions and the following disclaimer in the documentation
	#    and/or other materials provided with the distribution.
	# 
	# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
	# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
	# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
	# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
	# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
	# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
	# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
	# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
	# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
	# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
	
start:	.code16
	lgdtl gdt_desc
	mov $1, %eax
	mov %eax, %cr0
	ljmp $0x10, $1f			# far jump to 32-bit code segment
1:	.code32
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
