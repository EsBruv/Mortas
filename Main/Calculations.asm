; ================================================================
;   Calculations.asm (Gameplay Loop)
;   Handles Gameplay logic
;
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

; --------------------------------= Calculation =--------------------------------
    Main: ;_____________________________________+
        lda Counter                             ; Frame Latch
        and #$01                                ;
        beq Main_Start                          ; Branch if Frame Latch = 0
        ;                                       ;
        jmp Main                                ; Restart
        ;                                       ;
        Main_Start: ;___________________________+
            lda #RESET                          ; Clears Variables
            tax                                 ; A -> X
            tay                                 ; A -> Y
            ;                                   ;
            jsr Read_Buttons                    ;
            ;                                   ;
        Background_Swap_Calculation: ;__________+
            lda BKG_Control                     ; Background Swap Latch
            and #BKG_SWAP_LATCH                 ;
            beq Background_Shift_Calculation    ; Branch If Background Swap Latch = 0
                jmp Main_Clear                  ; Jump to End
                ;                               ;
        Background_Shift_Calculation: ;_________+
            lda BKG_Control                     ; Background Swap Latch
            and #BKG_SHIFT_LATCH                ;
            beq Frame_Calculation               ; Branch If Background Swap Latch = 0
                jsr Shift                       ;
                jmp Main_Clear                  ; Jump to End
                ;                               ;
        Frame_Calculation: ;____________________+
            lda Counter                         ; Offset Frame Check
            and #OFFSET                         ;
            bne Calculate_Offset                ; Branch if Offset Frame
            ;                                   ;
            Calculate_Fixed: ;__________________+
                jsr Fixed_Calculation           ; Fixed Frame
                jmp Main_Clear                  ;
                ;                               ;
            Calculate_Offset: ;_________________+
                jsr Offset_Calculation          ; Offset Frame
                jmp Main_Clear                  ;
                ;                               ;
        Main_Clear: ;___________________________+
            jsr Clock                           ; Increments Clock
            ;                                   ;
        Main_End: ;_____________________________+
            jmp Main                            ;
;

; --------------------------------= Methods =--------------------------------
    Fixed_Calculation: ;________________________+
        Fixed_Calculation_Loop: ;_______________+
            ;                                   ;
            Fixed_Calculation_Player: ;_________+
                jsr Button_Function             ;
                jsr Movement                    ;
                ;                               ;
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