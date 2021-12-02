
triangle.exec:	file format Mach-O 64-bit x86-64


Disassembly of section __TEXT,__text:

0000000100000fb8 start:
100000fb8: 48 bb 00 10 00 00 01 00 00 00       	movabs	rbx, 4294971392
100000fc2: e8 15 00 00 00              	call	21 <SYSTEM_PRINT>
100000fc7: eb 2b                       	jmp	43 <SYSTEM_EXIT>

0000000100000fc9 FAST_STRLEN:
100000fc9: 57                          	push	rdi
100000fca: 48 89 df                    	mov	rdi, rbx
100000fcd: 51                          	push	rcx
100000fce: 31 c9                       	xor	ecx, ecx
100000fd0: f7 d1                       	not	ecx
100000fd2: fc                          	cld
100000fd3: f2 ae                       	repne		scasb	al, byte ptr es:[rdi]
100000fd5: f7 d1                       	not	ecx
100000fd7: 89 c8                       	mov	eax, ecx
100000fd9: 59                          	pop	rcx
100000fda: 5f                          	pop	rdi
100000fdb: c3                          	ret

0000000100000fdc SYSTEM_PRINT:
100000fdc: 48 8d 33                    	lea	rsi, [rbx]
100000fdf: e8 e5 ff ff ff              	call	-27 <FAST_STRLEN>
100000fe4: 48 89 c2                    	mov	rdx, rax
100000fe7: b8 04 00 00 02              	mov	eax, 33554436
100000fec: bf 01 00 00 00              	mov	edi, 1
100000ff1: 0f 05                       	syscall
100000ff3: c3                          	ret

0000000100000ff4 SYSTEM_EXIT:
100000ff4: b8 01 00 00 02              	mov	eax, 33554433
100000ff9: bf 00 00 00 00              	mov	edi, 0
100000ffe: 0f 05                       	syscall

Disassembly of section __DATA,__data:

0000000100001000 MSG:
100001000: 48 65                       	gs
100001002: 6c                          	insb	byte ptr es:[rdi], dx
100001003: 6c                          	insb	byte ptr es:[rdi], dx
100001004: 6f                          	outsd	dx, dword ptr [rsi]
100001005: 2c 20                       	sub	al, 32
100001007: 57                          	push	rdi
100001008: 6f                          	outsd	dx, dword ptr [rsi]
100001009: 72 6c                       	jb	108 <MSG+0x77>
10000100b: 64 21 0a                    	and	dword ptr fs:[rdx], ecx
10000100e: 00                          	<unknown>
