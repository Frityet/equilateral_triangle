SECTION .text

GLOBAL start
start:
    MOV     RBX, MSG
    CALL    SYSTEM_PRINT
    JMP     SYSTEM_EXIT
SECTION .data
MSG     DB  "Hello, World!", 0xA, 0x0


%include "PRINT.ASM"

%include "EXIT.ASM"
