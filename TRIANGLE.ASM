STRUC POINT
    .X:     RESW 0x1
    .Y:     RESW 0x1

ENDSTRUC

STRUC TRIANGLE
    .POINT1:
    .POINT1.X:  RESW 0x1
    .POINT1.Y:  RESW 0x1

    .POINT2:
    .POINT2.X:  RESW 0x1
    .POINT2.Y:  RESW 0x1

    .POINT3:
    .POINT3.X:  RESW 0x1
    .POINT3.Y:  RESW 0x1
ENDSTRUC

[SECTION .text]

[GLOBAL INITIALISE_TRIANGLE]
INITIALISE_TRIANGLE:
    MOV     WORD [REL RDI + TRIANGLE.POINT1.X], 0x2
    MOV     WORD [REL RDI + TRIANGLE.POINT1.Y], 0x1

    MOV     WORD [REL RDI + TRIANGLE.POINT2.X], 0x5
    MOV     WORD [REL RDI + TRIANGLE.POINT2.Y], 0x5

    MOV     WORD [REL RDI + TRIANGLE.POINT3.X], 0x7
    MOV     WORD [REL RDI + TRIANGLE.POINT3.Y], 0x1
    RET

[GLOBAL GET_X_TEST]
GET_X_TEST:
    MOV     RSI, [RDI + TRIANGLE.POINT1.Y]
    UD2
    RET

[SECTION .text]

; Gets the distance between 2 points
; RBX: POINT 1
; RDI: POINT 2

     
;        Distance formula:
;    /-------------------------
;\  / (x2 - x1)^2 + (y2 - y1)^2
; \/
[GLOBAL DISTANCE_BETWEEN_POINTS]
DISTANCE_BETWEEN_POINTS:

    ;We need the RBX and RDI registers
    ;for the MUL instruction
    PUSH        R8
    MOV         R8, RBX
    PUSH        R9
    MOV         R9, RDI


    ; Clear used registers ;
    XOR         RAX, RAX 
    XOR         RBX, RBX

    ; (x2 - x1)^2
    MOV         RAX, [R9 + POINT.X]     ;X2
    MOV         RBX, [R8 + POINT.X]     ;X1
    SUB         RAX, RBX                ;X2 - X1
    MUL         RAX                     ;Multiply RAX by RAX (squaring)

    PUSH        RAX                     ;Store value on the stack

    XOR         RAX, RAX
    XOR         RBX, RBX

    ; (y2 - y1)^2
    MOV         RAX, [R9 + POINT.Y]     ;Y2
    MOV         RBX, [R8 + POINT.Y]     ;Y1
    SUB         RAX, RBX                ;Y2 - Y1
    MUL         RAX

    POP         RBX             ;Store the value of the first equation ((x2-x1)^2) in RBX, so we can subtract it from this equation ((y2 - y1)^2)

    ; (x2 - x1)^2 + (y2 - y1)^2

    ADD         RAX, RBX

    ; Now we do floating point fuckery
    ; May god have mercy on my soul
    MOVSD       XMM0, [RAX]   ; Load the output from (x2 - x1)^2 + (y2 - y1)^2 into the floating point register
    SQRTSD      XMM0, XMM0  ; Square root, result is in XMM1
    CVTSS2SI    RAX, XMM0   ; Convert the val to an int, rounding up to work

    POP         R9
    POP         R8
    RET


; Checks if the triangle is equilateral
; RBX: Triangle (struc)
[GLOBAL CHECK_TRIANGLE]
CHECK_TRIANGLE:
    PUSH    R8
    MOV     R8, RBX

    LEA     RBX, [REL R8 + TRIANGLE.POINT1]
    LEA     RDI, [REL R8 + TRIANGLE.POINT2]
    CALL    DISTANCE_BETWEEN_POINTS
    PUSH    R9
    MOV     R9, RAX                 ; Distance between points 1 - 2

    MOV     RBX, [R8 + TRIANGLE.POINT2]
    MOV     RDI, [R8 + TRIANGLE.POINT3]
    CALL    DISTANCE_BETWEEN_POINTS
    PUSH    R10
    MOV     R10, RAX                ; Distance between points 2 - 3

    MOV     RBX, [R8 + TRIANGLE.POINT1]
    MOV     RDI, [R8 + TRIANGLE.POINT3]
    CALL    DISTANCE_BETWEEN_POINTS
    PUSH    R11
    MOV     R11, RAX                ; Distance between points 1 - 3

    CMP     R9, R10                 ; Check side #1
    JNE     CHECK_TRIANGLE.DONE_FALSE

    CMP     R10, R11                ; Check side #2
    JNE     CHECK_TRIANGLE.DONE_FALSE

    CMP     R9, R10                 ; Check side #3
    JNE     CHECK_TRIANGLE.DONE_FALSE

    JMP     CHECK_TRIANGLE.DONE_TRUE

    CHECK_TRIANGLE.DONE_FALSE:
    MOV     RAX, 0x0
    JMP     CLEANUP

    CHECK_TRIANGLE.DONE_TRUE:
    MOV     RAX, 0x1


    CLEANUP:
    POP     R11
    POP     R10
    POP     R9
    POP     R8 
    RET 

