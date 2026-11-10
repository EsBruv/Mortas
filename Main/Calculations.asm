; ================================================================
;   Calculations.asm (Gameplay Loop)
;   Handles Gameplay logic
;
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

; --------------------------------= Constants =--------------------------------

    ; RESET                 = $00 (Global.asm)
    ; OFFSET                = $02 (Global.asm)

    ; BKG_SWAP_LATCH        = $20 (Global.asm)
    ; BKG_SHIFT_LATCH       = $80 (Global.asm)
    ; ENTITY_AMOUNT          = $08 (Global.asm)

    ; SPRITE_ZERO_OFFSET    = $10 (Render.asm)


; --------------------------------= Calculation =--------------------------------
    
    Main: ;_____________________________________+
        lda Counter                             ; Frame Latch
        and #NMI_FLAG                           ; Mask NMI Flag ;
        ;                                       ;
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
            lda Counter                         ;
            ora #NMI_FLAG                       ; Set NMI Flag
            sta Counter                         ; Store Frame Latch
            ;                                   ;
        Main_End: ;_____________________________+
            jmp Main                            ;
;

; --------------------------------= Methods =--------------------------------
    
    Fixed_Calculation: ;________________________+
        ldy #RESET                              ;
        jsr Render_Hidden                       ; Clear Sprite 0
        ;                                       ;
        lda #RESET                              ;
        sta CCharacter                          ; Reset Current Character
        ;                                       ;
        Fixed_Calculation_Loop: ;_______________+
            ldx CCharacter                      ;
            ;                                   ;
            lda CharacterHealth, X              ;
            beq Fixed_Calculation_Render        ; Branch If Current Character Health == 0
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
                jsr Dynamic_Collision           ; Dynamic Collision Check
                jsr Movement                    ;
                ;                               ;
            Fixed_Calculation_Render: ;_________+
                jsr Render_Entity               ;
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

    Offset_Calculation: ;_______________________________+
        ldy #RESET                                      ;
        jsr Render_Hidden                               ; Clear Sprite 0
        ;                                               ;
        lda #ENTITY_AMOUNT - 1                          ; Set Character Index to Last
        sta CCharacter                                  ;
        ;                                               ;
        Offset_Calculation_Loop: ;______________________+
            ldx CCharacter                              ;
            ;                                           ;
            lda CharacterHealth, X                      ;
            beq Offset_Calculation_Render               ; Branch If Current Character Health == 0
            ;                                           ;
            cpx #$00                                    ; NPC Check
            bne Offset_Calculation_NPC                  ;
            ;                                           ;
            Offset_Calculation_Player: ;________________+
                jsr Button_Function                     ;
                jmp Offset_Calculation_All              ;
                ;                                       ;
            Offset_Calculation_NPC: ;___________________+
                ; jsr AI_Movement                         ;
                jmp Offset_Calculation_All              ;
                ;                                       ;
            Offset_Calculation_All: ;___________________+
                jsr Dynamic_Collision                   ; Dynamic Collision Check
                jsr Movement                            ;
                ;                                       ;
            Offset_Calculation_Render: ;________________+
                lda CCharacter                          ; Current Character
                bne Offset_Calculation_Render_Reverse   ; Branch if Current Character = 0
                jsr Render_Entity                       ;
                ;                                       ;
                jmp Offset_Calculation_Loop_End         ;
                ;                                       ;
                Offset_Calculation_Render_Reverse: ;____+
                    jsr Render_Entity_Reverse           ;
                    ;                                   ;
            Offset_Calculation_Loop_End: ;______________+
                lda CCharacter                          ; Current Character
                beq Offset_Calculation_End              ; Branch if Current Character = 0
                ;                                       ;
                dec CCharacter                          ; Decrement to Reverse Loop
                jmp Offset_Calculation_Loop             ; Branch if Current Character = Max Character
                ;                                       ;
        Offset_Calculation_End: ;_______________________+
            rts                                         ;
    ;