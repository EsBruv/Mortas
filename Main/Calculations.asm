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
            sta CCharacter                      ;
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
                jmp Calculate_Offset            ; Jump to End
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
        ;                                       ;
        Fixed_Calculation_Loop: ;_______________+
            ldx CCharacter                      ;
            ;                                   ;
            lda CharacterHealth, X              ;
            beq Fixed_Calculation_Loop_End      ;
            ;                                   ;
            cpx #$00                            ; NPC Check
            bne Fixed_Calculation_NPC           ;
            ;                                   ;
            Fixed_Calculation_Player: ;_________+
                jsr Button_Function             ;
                jmp Fixed_Calculation_All       ;
                ;                               ;
            Fixed_Calculation_NPC: ;____________+
                ; jsr AI_Movement                 ;
                jmp Fixed_Calculation_All       ;
                ;                               ;
            Fixed_Calculation_All: ;____________;
                jsr Dynamic_Collision           ;
                jsr Movement                    ;
                ;                               ;
            Fixed_Calculation_Loop_End: ;_______+
                inc CCharacter                  ; Next Character
                ;                               ;
                lda CCharacter                  ; Character Max Check
                cmp #ENTITY_AMOUNT              ;
                bne Fixed_Calculation_Loop      ; Branch if Current Character = Max Character
                ;                               ;
        Fixed_Calculation_End: ;________________+
            rts                                 ;
        ;

    Offset_Calculation: ;___________________________+
        jsr Render_Empty                            ; Clear Sprite 0
        ldy #RESET + 16                             ; Reset + Clear Sprite 0 Offset
        ;                                           ;
        Offset_Calculation_Loop: ;__________________+
            ldx CCharacter                          ; Load Current Character Index
            ;                                       ;
            lda CharacterHealth, X                  ; Current Character Health Check
            beq Offset_Calculation_Empty            ; Branch If Current Character Health == 0
            ;                                       ;
            Offset_Calculation_Character: ;_________+
                jsr Render_Character                ; Render Character into OAMDMA
                jmp Offset_Calculation_Loop_End     ; Jump to Loop End
                ;                                   ;
            Offset_Calculation_Empty: ;_____________+
                jsr Render_Empty                    ; Render Empty into OAMDMA
                jmp Offset_Calculation_Loop_End     ; Jump to Loop End
                ;                                   ;
            Offset_Calculation_Loop_End: ;__________+
                inc CCharacter                      ; Next Character
                ;                                   ;
                lda CCharacter                      ; Character Max Check
                cmp #ENTITY_AMOUNT                  ;
                bne Offset_Calculation_Loop         ; Branch if Current Character = Max Character
                ;                                   ;
        Offset_Calculation_End: ;___________________+
            rts                                     ;
    ;