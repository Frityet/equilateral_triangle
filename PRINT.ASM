SECTION .text

[GLOBAL  FAST_STRLEN]
FAST_STRLEN:
    PUSH    RDI
    MOV     RDI, RBX ; Move function arguments

    PUSH    RCX
    XOR     ECX, ECX
    NOT     ECX         ; Initialise ECX to the max 32 bit number or -1

    ; Go through the string and find the null byte
    ; This instruction goes through the EDI regiser (where our string is stored)
    ; Through each iteration it decrements ECX, even for the null byte
    ; To convert this to the real length of the string, we must reverse all bits
    ; in the register, which is equal to the absolute value - 1.
    CLD
    REPNE   SCASB   

    ; Reverse bits and then decrement to get the real length
    NOT     ECX
 
    MOV     EAX, ECX

    POP     RCX
    POP     RDI
    RET

GLOBAL  SYSTEM_PRINT
SYSTEM_PRINT:
    LEA     RSI, [REL RBX]          ; Load the address of the string
    CALL    FAST_STRLEN             ; Get the length
    MOV     RDX, RAX                ; Load the length for the syscall
    MOV     RAX, SYS_WRITE_ADDR     ; Load the address of the syscall
    MOV     RDI, 0x1                ; STDOUT
    ;UD2
    SYSCALL
    RET

SECTION .data
SYS_WRITE_ADDR  EQU 0x2000004 