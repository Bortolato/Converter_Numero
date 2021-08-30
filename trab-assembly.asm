;.data 2000h
;    DB 49h, 0Fh, DAh            ;  49h, 0Fh, DAh | 0Ah, 3Dh, 70h | 06h, FFh, FFh | 70h, 00h, 00h
                                ;   ~3,14           ~0,135          ~135            135
;   DB 49h, 0Fh, DAh
;   *MSB - MANTISSA - LSB*
;   DB 10000000b, 10000000b      ; 10000000b     | 01111100b      |  10000110b    |  10000110b
;       *expo1, expo2*
;   DB 00h, 00h
;    *signal1, signal2*

.org 1000h

LXI H, 9000H
loop:
    CPI 0DH
    JNZ loop
    CALL function_signal
    CALL function_exponent
    CALL function_mantissa
    CALL multiply
    CALL print
HLT
print:
        LXI H, 6007H
        MOV A, M
        LXI H, E000H
        ADI 30H
        MOV M, A       ;print signal
        INX H
        MVI A, 20H
        MOV M, A  
        LXI H, 6006H
        MOV A, M
        MOV B, A
    CALL ms
        LXI H, E002H
        MOV M, A
    CALL ls
        INX H
        MOV M, A
        INX H
        MVI A, 20H
        MOV M, A
        LXI H, 6005H
        MOV A, M
        MOV B, A
    CALL ms
        LXI H, E005H
        MOV M, A
    CALL ls
        INX H
        MOV M, A
        LXI H, 6004H
        MOV A, M
        MOV B, A
    CALL ms
        LXI H, E007H
        MOV M, A
    CALL ls
        INX H
        MOV M, A
        LXI H, 6003H
        MOV A, M
        MOV B, A
    CALL ms
        LXI H, E009H
        MOV M, A
    CALL ls
        INX H
        MOV M, A

ms:
    MVI D, F0H
    ;CALL INCR
    MOV M, A
    ANA D
    RAR
    RAR
    RAR
    RAR
    CALL check_2
    ADI 30H
    RET

ls: 
    MOV A, B
    MVI D, 0FH
    ANA D
    CALL check_2
    ADI 30H
    RET

check_2:
    CPI 0Ah
    CNC adicional
    RET

adicional:
    ADI 07H
    RET


function_signal:
    LXI H, 9000H
    MOV A, M
    SUI 30H
    LXI H, 2008H    ;9300 tem o sinal   01h ou 00h
    MOV M, A
    LXI H, 900CH
    MOV A, M
    SUI 30H
    LXI H, 2009H    ;9300 tem o sinal   01h ou 00h
    MOV M, A
    RET

    
function_exponent:
        LXI H, 9002H    ;posição 9001 tem " "
        MOV A, M
        CALL check
        SUI 30H
        MVI D, 0FH      ;0000 1111B
        MOV B, A
    exponent_1:
        ADD B
        DCR D
        JNZ exponent_1
        MOV B, A
        LXI H, 9003H
        MOV A, M
        CALL check
        SUI 30H
        ADD B
        LXI H, 2006H
        MOV M, A

        LXI H, 900EH    ;posição 900D tem " "
        MOV A, M
        CALL check
        SUI 30H
        MVI D, 0FH      ;0000 1111B
        MOV B, A
    exponent_2:
        ADD B
        DCR D
        JNZ exponent_2
        MOV B, A
        LXI H, 900FH
        MOV A, M
        CALL check
        SUI 30H
        ADD B
        LXI H, 2007H
        MOV M, A
    RET

function_mantissa:
        LXI H, 9005H
        MOV A, M
        CALL check
        SUI 30H
        MVI D, 0FH
        MOV B, A
    mantissa:
        ADD B 
        DCR D
        JNZ mantissa
        MOV B, A
        LXI H, 9006H
        MOV A, M
        CALL check
        SUI 30H
        ADD B
        LXI H, 2000H
        MOV M, A

        LXI H, 9007H
        MOV A, M
        CALL check
        SUI 30H
        MVI D, 0FH
        MOV B, A
    mantissa_2:
        ADD B 
        DCR D
        JNZ mantissa_2
        MOV B, A
        LXI H, 9008H
        MOV A, M
        CALL check
        SUI 30H
        ADD B
        LXI H, 2001H
        MOV M, A

        LXI H, 9009H
        MOV A, M
        CALL check
        SUI 30H
        MVI D, 0FH
        MOV B, A
    mantissa_3:
        ADD B 
        DCR D
        JNZ mantissa_3
        MOV B, A
        LXI H, 900AH
        MOV A, M
        CALL check
        SUI 30H
        ADD B
        LXI H, 2002H
        MOV M, A

        LXI H, 9011H
        MOV A, M
        CALL check
        SUI 30H
        MVI D, 0FH
        MOV B, A
    mantissa_4:
        ADD B 
        DCR D
        JNZ mantissa_4
        MOV B, A
        LXI H, 9012H
        MOV A, M
        CALL check
        SUI 30H
        ADD B
        LXI H, 2003H
        MOV M, A

        LXI H, 9013H
        MOV A, M
        CALL check
        SUI 30H
        MVI D, 0FH
        MOV B, A
    mantissa_5:
        ADD B 
        DCR D
        JNZ mantissa_5
        MOV B, A
        LXI H, 9014H
        MOV A, M
        CALL check
        SUI 30H
        ADD B
        LXI H, 2004H
        MOV M, A

        LXI H, 9015H
        MOV A, M
        CALL check
        SUI 30H
        MVI D, 0FH
        MOV B, A
    mantissa_6:
        ADD B 
        DCR D
        JNZ mantissa_6
        MOV B, A
        LXI H, 9016H
        MOV A, M
        CALL check
        SUI 30H
        ADD B
        LXI H, 2005H
        MOV M, A

check:
    CPI 40H
    CNC remove 
    RET

remove:
    SUI 07H
    RET

multiply:


            MVI D, 03h
            MVI E, 03h
            CALL SETOP
            CALL CONVMANT
            LXI H, 4000h
            CALL SETRES
LOOPMULT:   CALL GET1
            MOV B, M
            CALL GET2
            MVI A, 00h
            MOV C, A
LOOP:       ADD M
            JNC NC
            INR C
NC:         DCR B
            JNZ LOOP
            CALL SUB1
            CALL GETRES
            ADD M           ; soma 8 bits mais significativos anteriores com
                            ; 8 bits menos significativos atuais
            CC INRC         ; verifica o carry
            MOV M, A        ; salva os 8 bits menos significativos na memoria
            INX H 
            MOV M, C        ; salva os 8 bits mais significativos na memoria
            CALL SETRES
            DCR D
            JNZ LOOPMULT
            CALL RESET1
            CALL SUB2
            MVI D, 03h
            DCR E
            CALL ADDRES
            JNZ LOOPMULT
            CALL SUM
            CALL EXPO
            CALL SIGNAL
            ;CALL CONVRES
            RET
SETOP:      LXI H, 2002h
            CALL SET1
            LXI H, 2005h
            CALL SET2
            RET
SET1:       SHLD 3000h
            RET
GET1:       LHLD 3000h
            RET
RESET1:     LXI H, 2002h
            CALL SET1
		    RET
SUB1:       CALL GET1
            DCX H
            CALL SET1
		    RET
SET2:       SHLD 3002h
            RET
GET2:       LHLD 3002h
            RET
SUB2:		CALL GET2
		    DCX H
		    CALL SET2
		    RET
SETRES:     SHLD 3004h
            RET
GETRES:     LHLD 3004h
            RET
ADDRES:     CALL GETRES
            INX H
            INX H
            CALL SETRES
            RET
SUBRES:     CALL GETRES
            DCX H
            CALL SETRES
INRC:       INR C
            RET
SUM:        LXI H, 5000h
            CALL SETRES
            CALL RESETOPSUM
            MVI E, 02h
            CALL SETOPSUM
            MVI D, 05h
LOOPSUM:	CALL GETDATA
            CALL ADDB
            CALL SAVEDATA
            CALL ADD1
            CALL ADD2
            DCR D
            JNZ LOOPSUM
            CALL SETOP2SUM
            MVI D, 05h
            DCR E            
            JNZ LOOPSUM
            RET
SETOPSUM:   CALL GET2
            CALL SET1
            LXI B, 0004h
            DAD B
            CALL SET2
            RET
RESETOPSUM: LXI H, 4000h
            CALL SET2
            RET
ADD1:       CALL GET1
            INX H
            CALL SET1
            RET
ADD2:       CALL GET2
            INX H
            CALL SET2
            RET
RESETRES:   LXI H, 5000h
            CALL SETRES
            RET
GETDATA:    CALL GET2
            MOV B, M
            MVI C, 00h
            CALL GET1
            MOV A, M
            CALL GETRES
            ADD M           ; soma 8 bits mais significativos anteriores com
                            ; 8 bits menos significativos atuais
            CC INRC         ; verifica o carry
            RET
SAVEDATA:   MOV M, A        ; salva os 8 bits menos significativos na memoria
            INX H 
            MOV M, C        ; salva os 8 bits mais significativos na memoria
            CALL SETRES
            RET
SETOP2SUM:  CALL RESETOPSUM
            LXI B, 0009h
            DAD B
            CALL SET2
            LXI H, 5000h
            MOV A, M
            INX H
            CALL SET1
            LXI H, 6000h
            MOV M, A
            INX H
            CALL SETRES
            RET
ADDB:       ADD B
            CC INRC         ; verifica o carry
            RET
EXPO:       MVI A, 00h
            LXI H, 2006h
            MOV A, M
            SUI 7Fh
            INX H
            MOV B, M
            ADD B
            LXI H, 6006h
            MOV M, A
            LXI H, 6005h
            MOV A, M
            ANI 80h
            CPI 80h
            CZ INCEXPO
            CALL REMOVE1BIT
            RET
INCEXPO:    LXI H, 6006h
            MOV C, M
            INR C
            MOV M, C
            RET
REMOVE1BIT: LXI D, 7000h
            LXI H, 6000h
            CALL COPYRES
            MVI C, 00h
            LXI H, 7005h
RETR1BIT:   MOV A, M
            ANI 80h
            CPI 80h
            JC MOVELEFT
SETR1BIT:   CNC SETTO0
            ;MOV A, C
            ;CPI 00h
            ;CNZ MOVERIGHT
            LXI D, 6000h
            LXI H, 7000h
            CALL COPYRES
            RET
SETTO0:     LXI H, 7005h
            MOV A, M
            ANI 7Fh
            MOV M, A
            RET
MOVELEFT:   LXI D, 7000h
            MOV B, 06h
            MOV A, C
            CPI 18h
            CZ SETR1BIT
LOOPMLEFT:  XCHG
            MOV A, M
            RAL
            MOV M, A
            INX H
            XCHG
            DCR B
            JNZ LOOPMLEFT
            INR C
            JMP RETR1BIT
MOVERIGHT:  LXI D, 7005h
REPEATR:    MVI B, 06h
LOOPMRIGHT: XCHG
            MOV A, M
            RAR
            MOV M, A
            DCX H
            XCHG
            DCR B
            JNZ LOOPMRIGHT       
            DCR C
            JNZ REPEATR
            RET
SIGNAL:     LXI H, 2008h
            MOV A, M
            INX H
            XRA M
            LXI H, 6007h
            MOV M, A
            RET
CONVMANT:   LXI H, 2000h
            MOV A, M
            ADI 80h
            MOV M, A
            LXI H, 2003h
            MOV A, M
            ADI 80h
            MOV M, A
            RET
COPYRES:    MVI C, 06h
LOOPCOPY:   MOV A, M
            XCHG
            MOV M, A
            INX H
            XCHG
            INX H
            DCR C
            JNZ LOOPCOPY
            RET


.org 0024h

    IN 00H
    MOV M, A
    INX H
    JMP loop