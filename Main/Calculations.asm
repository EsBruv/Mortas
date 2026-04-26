; ================================================================
;   Calculations.asm (Gameplay Loop)
;   Handles Gameplay logic
;
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

; --------------------------------= Calculation =--------------------------------
    Main: ;_____________________________+
        lda Counter                     ; Frame Latch
        and #$01                        ;
        beq Main_Start                  ; Branch if Frame Latch = 0
        ;                               ;
        jmp Main                        ; Restart
        ;                               ;
        Main_Start: ;___________________+
            lda #RESET                  ; Clears Variables
            tax                         ; A -> X
            tay                         ; A -> Y
            ;                           ;
            jsr Read_Buttons            ;
            ;                           ;
        Frame_Calculation: ;____________+
            lda Counter                 ; Offset Frame Check
            and #OFFSET                 ;
            bne Calculate_Offset        ; Branch if Offset Frame
            ;                           ;
            Calculate_Fixed: ;__________+
                jsr Fixed_Calculation   ; Fixed Frame
                jmp Main_Clear          ;
                ;                       ;
            Calculate_Offset: ;_________+
                jsr Offset_Calculation  ; Offset Frame
                jmp Main_Clear          ;
                ;                       ;
        Main_Clear: ;___________________+
            jsr Clock                   ; Increments Clock
            ;                           ;
        Main_End: ;_____________________+
            jmp Main                    ;
;

; --------------------------------= Methods =--------------------------------
    Fixed_Calculation: ;________________________+
        ;                                       ;
        Fixed_Calculation_Loop: ;_______________+
            ;                                   ;
        Fixed_Calculation_End: ;________________+
            rts                                 ;
        ;

    Offset_Calculation: ;_______________________+
        ;                                       ;
        Offset_Calculation_Loop: ;______________+
            ;                                   ;
        Offset_Calculation_End: ;_______________+
            rts                                 ;
    ;