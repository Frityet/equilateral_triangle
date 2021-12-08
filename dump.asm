
triangle.exec:	file format Mach-O 64-bit x86-64


Disassembly of section __TEXT,__text:

0000000100000ea8 start:
100000ea8: 48 8d 3d 72 01 00 00        	lea	rdi, [rip + 370]
100000eaf: e8 6f 00 00 00              	call	111 <INITIALISE_TRIANGLE>
100000eb4: e8 8e 00 00 00              	call	142 <GET_X_TEST>
100000eb9: 0f 0b                       	ud2
100000ebb: 48 bb 21 10 00 00 01 00 00 00       	movabs	rbx, 4294971425
100000ec5: e8 cb 00 00 00              	call	203 <CHECK_TRIANGLE>
100000eca: 48 83 f8 01                 	cmp	rax, 1
100000ece: 74 14                       	je	20 <start.EQUAL>
100000ed0: 48 bb 17 10 00 00 01 00 00 00       	movabs	rbx, 4294971415
100000eda: e8 2c 00 00 00              	call	44 <SYSTEM_PRINT>
100000edf: e9 10 01 00 00              	jmp	272 <SYSTEM_EXIT>

0000000100000ee4 start.EQUAL:
100000ee4: 48 bb 00 10 00 00 01 00 00 00       	movabs	rbx, 4294971392
100000eee: e8 18 00 00 00              	call	24 <SYSTEM_PRINT>
100000ef3: e9 fc 00 00 00              	jmp	252 <SYSTEM_EXIT>

0000000100000ef8 FAST_STRLEN:
100000ef8: 57                          	push	rdi
100000ef9: 48 89 df                    	mov	rdi, rbx
100000efc: 51                          	push	rcx
100000efd: 31 c9                       	xor	ecx, ecx
100000eff: f7 d1                       	not	ecx
100000f01: fc                          	cld
100000f02: f2 ae                       	repne		scasb	al, byte ptr es:[rdi]
100000f04: f7 d1                       	not	ecx
100000f06: 89 c8                       	mov	eax, ecx
100000f08: 59                          	pop	rcx
100000f09: 5f                          	pop	rdi
100000f0a: c3                          	ret

0000000100000f0b SYSTEM_PRINT:
100000f0b: 48 8d 33                    	lea	rsi, [rbx]
100000f0e: e8 e5 ff ff ff              	call	-27 <FAST_STRLEN>
100000f13: 48 89 c2                    	mov	rdx, rax
100000f16: b8 04 00 00 02              	mov	eax, 33554436
100000f1b: bf 01 00 00 00              	mov	edi, 1
100000f20: 0f 05                       	syscall
100000f22: c3                          	ret

0000000100000f23 INITIALISE_TRIANGLE:
100000f23: 66 c7 07 02 00              	mov	word ptr [rdi], 2
100000f28: 66 c7 47 02 01 00           	mov	word ptr [rdi + 2], 1
100000f2e: 66 c7 47 04 05 00           	mov	word ptr [rdi + 4], 5
100000f34: 66 c7 47 06 05 00           	mov	word ptr [rdi + 6], 5
100000f3a: 66 c7 47 08 07 00           	mov	word ptr [rdi + 8], 7
100000f40: 66 c7 47 0a 01 00           	mov	word ptr [rdi + 10], 1
100000f46: c3                          	ret

0000000100000f47 GET_X_TEST:
100000f47: 48 8b 77 02                 	mov	rsi, qword ptr [rdi + 2]
100000f4b: 0f 0b                       	ud2
100000f4d: c3                          	ret

0000000100000f4e DISTANCE_BETWEEN_POINTS:
100000f4e: 41 50                       	push	r8
100000f50: 49 89 d8                    	mov	r8, rbx
100000f53: 41 51                       	push	r9
100000f55: 49 89 f9                    	mov	r9, rdi
100000f58: 48 31 c0                    	xor	rax, rax
100000f5b: 48 31 db                    	xor	rbx, rbx
100000f5e: 49 8b 01                    	mov	rax, qword ptr [r9]
100000f61: 49 8b 18                    	mov	rbx, qword ptr [r8]
100000f64: 48 29 d8                    	sub	rax, rbx
100000f67: 48 f7 e0                    	mul	rax
100000f6a: 50                          	push	rax
100000f6b: 48 31 c0                    	xor	rax, rax
100000f6e: 48 31 db                    	xor	rbx, rbx
100000f71: 49 8b 41 02                 	mov	rax, qword ptr [r9 + 2]
100000f75: 49 8b 58 02                 	mov	rbx, qword ptr [r8 + 2]
100000f79: 48 29 d8                    	sub	rax, rbx
100000f7c: 48 f7 e0                    	mul	rax
100000f7f: 5b                          	pop	rbx
100000f80: 48 01 d8                    	add	rax, rbx
100000f83: f2 0f 10 00                 	movsd	xmm0, qword ptr [rax]
100000f87: f2 0f 51 c0                 	sqrtsd	xmm0, xmm0
100000f8b: f3 48 0f 2d c0              	cvtss2si	rax, xmm0
100000f90: 41 59                       	pop	r9
100000f92: 41 58                       	pop	r8
100000f94: c3                          	ret

0000000100000f95 CHECK_TRIANGLE:
100000f95: 41 50                       	push	r8
100000f97: 49 89 d8                    	mov	r8, rbx
100000f9a: 49 8d 18                    	lea	rbx, [r8]
100000f9d: 49 8d 78 04                 	lea	rdi, [r8 + 4]
100000fa1: e8 a8 ff ff ff              	call	-88 <DISTANCE_BETWEEN_POINTS>
100000fa6: 41 51                       	push	r9
100000fa8: 49 89 c1                    	mov	r9, rax
100000fab: 49 8b 58 04                 	mov	rbx, qword ptr [r8 + 4]
100000faf: 49 8b 78 08                 	mov	rdi, qword ptr [r8 + 8]
100000fb3: e8 96 ff ff ff              	call	-106 <DISTANCE_BETWEEN_POINTS>
100000fb8: 41 52                       	push	r10
100000fba: 49 89 c2                    	mov	r10, rax
100000fbd: 49 8b 18                    	mov	rbx, qword ptr [r8]
100000fc0: 49 8b 78 08                 	mov	rdi, qword ptr [r8 + 8]
100000fc4: e8 85 ff ff ff              	call	-123 <DISTANCE_BETWEEN_POINTS>
100000fc9: 41 53                       	push	r11
100000fcb: 49 89 c3                    	mov	r11, rax
100000fce: 4d 39 d1                    	cmp	r9, r10
100000fd1: 75 0c                       	jne	12 <CHECK_TRIANGLE.DONE_FALSE>
100000fd3: 4d 39 da                    	cmp	r10, r11
100000fd6: 75 07                       	jne	7 <CHECK_TRIANGLE.DONE_FALSE>
100000fd8: 4d 39 d1                    	cmp	r9, r10
100000fdb: 75 02                       	jne	2 <CHECK_TRIANGLE.DONE_FALSE>
100000fdd: eb 07                       	jmp	7 <CHECK_TRIANGLE.DONE_TRUE>

0000000100000fdf CHECK_TRIANGLE.DONE_FALSE:
100000fdf: b8 00 00 00 00              	mov	eax, 0
100000fe4: eb 05                       	jmp	5 <CLEANUP>

0000000100000fe6 CHECK_TRIANGLE.DONE_TRUE:
100000fe6: b8 01 00 00 00              	mov	eax, 1

0000000100000feb CLEANUP:
100000feb: 41 5b                       	pop	r11
100000fed: 41 5a                       	pop	r10
100000fef: 41 59                       	pop	r9
100000ff1: 41 58                       	pop	r8
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
100001009: 72 6c                       	jb	108 <TRIANGLE_1+0x56>
10000100b: 64 21 0a                    	and	dword ptr fs:[rdx], ecx
10000100e: 00 45 71                    	add	byte ptr [rbp + 113], al

000000010000100f EQUAL_MSG:
10000100f: 45 71 75                    	jno	117 <TRIANGLE_1+0x66>
100001012: 61                          	<unknown>
100001013: 6c                          	insb	byte ptr es:[rdi], dx
100001014: 21 0a                       	and	dword ptr [rdx], ecx
100001016: 00 55 6e                    	add	byte ptr [rbp + 110], dl

0000000100001017 UNEQUAL_MSG:
100001017: 55                          	push	rbp
100001018: 6e                          	outsb	dx, byte ptr [rsi]
100001019: 65 71 75                    	jno	117 <TRIANGLE_1+0x70>
10000101c: 61                          	<unknown>
10000101d: 6c                          	insb	byte ptr es:[rdi], dx
10000101e: 21 0a                       	and	dword ptr [rdx], ecx
100001020: 00                          	<unknown>

Disassembly of section __DATA,__bss:

0000000100001021 TRIANGLE_1:
...
