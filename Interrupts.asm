;====================================================================
; Main.asm file generated by New Project wizard
;
; Created:   Wed Aug 4 2021
; Processor: 80C31
; Compiler:  ASEM-51 (Proteus)
;====================================================================

$NOMOD51
$INCLUDE (8051.MCU)

;====================================================================
; DEFINITIONS
;====================================================================

;====================================================================
; VARIABLES
;====================================================================
LED1		BIT		P2.0
LED2		BIT		P2.1
LED3		BIT		P2.2

;====================================================================
; RESET and INTERRUPT VECTORS
;====================================================================

      ; Reset Vector
      org   0000h
      jmp   Start

;====================================================================
; CODE SEGMENT
;====================================================================

      org   0100h



      

  
  ORG 13H
  JMP BLINKING ;JUMP TO BLINKING IF THE EXTERNAL INTERRUPT OCCURS
  RETI
   
   Start:
     SETB LED1 ;SWITCHOFF LED1
     SETB LED2 ;SWITCHOFF LED2
     SETB LED3 ;SWITCHOFF LED3
     SETB EX1 ; ENABLE EXTERNAL INTERRUPT 1
     SETB EA ;ENABLE ALL INTERRUPTS
     jmp Start ; 
  
  
  BLINKING:
    
    MOV R1, #50D ;STORE 50 VALUE IN R1
    MOV R2, #100D ;STORE 100 VALUE IN R2
    MOV R3, #130D ;STORE 130 VALUE IN R2
RPT:    ACALL DELAY ;CALL THE DELAY FUNCTION

SWITCH1:
        DJNZ R1, SWITCH2 ;DECREASE R1 BY 1, IF NOT ZERO JUMP TO SWITCH2 
        CPL LED1 ; TOGGLE LED1. REACHED WHEN R1 HAS GONE TO ZERO; TOTAL DELAY TAKEN IS 50*10ms = 500ms
        MOV R1, #50D ;RETURN R1 TO 50
SWITCH2:
        DJNZ R2, SWITCH3 ;DECREASE R2 BY 1, IF NOT ZERO JUMP TO SWITCH3
        CPL LED2 ; TOGGLE LED2. REACHED WHEN R2 HAS GONE TO ZERO; TOTAL DELAY TAKEN IS 100*10ms = 1000ms
        MOV R2, #100D ;RETURN R2 TO 100
SWITCH3:
        DJNZ R3, RPT ;DECREASE R2 BY 1, IF NOT ZERO JUMP TO SWITCH3
        CPL LED3 ; TOGGLE LED3. REACHED WHEN R2 HAS GONE TO ZERO; TOTAL DELAY TAKEN IS 100*10ms = 1300ms
        MOV R3, #130D ;RETURN R2 TO 130

      SJMP RPT ;RETURN TO RPT

    
DELAY:	
      MOV TMOD, #01H ; Initialize timer 0 in mode 0
      MOV TH0, #0DBH ; Higher counter bit
      MOV TL0, #0FFH ; Lower counter bit
      SETB TCON.4 ; Start timer
    L1: JNB TCON.5, L1 ; Check timer flag bit in loop
       CLR TCON.4 ; Stop the timer
       CLR TCON.5 ; Clear the timer flag
       RET
        
;====================================================================
      END