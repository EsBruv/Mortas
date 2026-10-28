; ================================================================
;   Menu.asm
;   Handles Menu Rendering
; 
;   Revision History:
;       Essam Erbab, July 2026: Created
; ================================================================

    X_START         = $00
    Y_START         = $01

    X_END           = $02
    Y_END           = $03

    TEMP_WIDTH      = $04
    TEMP_HEIGHT     = $05

    TEMP_ROW_COUNT  = $06

    TEXT_X          = $07
    TEXT_Y          = $08
    TEXT_INDEX      = $09

    Dialogue_Box_Tiles: ;___+
    .byte $2D               ; Corner
    .byte $2E               ; Left / Right Edges
    .byte $2F               ; Top / Bottom Edges
    .byte $2C               ; Fill tile

    ; WORK ON MULI-OPTION
    ; WORK ON MAIN MENU DIALOGUE

; --------------------------------= Menu =--------------------------------
    Menu: ;_________________________________________    +
        lda PPUSTATUS                                   ; Reset PPU Status
        sei                                             ;
        ;                                               ;
        lda #RESET                                      ; Reset Variables
        sta CPPUCTRL                                    ;
        sta CPPUMASK                                    ;
        sta PPUCTRL                                     ;
        sta PPUMASK                                     ;
        ;                                               ;
        jsr Menu_Set_Variables                          ; Set Variables
        jsr Menu_Set_Address                            ; Set Nametable Address
        ;                                               ;
        lda Dialogue_Box_Tiles + MENU_CORNER            ; Render Corner
        sta PPUDATA                                     ;
        ;                                               ;
        ldx TEMP_WIDTH                                  ; Set Loop 
        lda Dialogue_Box_Tiles + MENU_X_TILE            ;
        ;                                               ;
        Menu_Top_Loop: ;________________________        +
            sta PPUDATA                                 ;
            dex                                         ;
            bpl Menu_Top_Loop                           ;
            ;                                           ;
            lda Dialogue_Box_Tiles + MENU_CORNER        ; Render Corner
            sta PPUDATA                                 ;
            ;                                           ;
            lda TEMP_HEIGHT                             ;
            bmi Menu_Center_End                         ;
            sta TEMP_ROW_COUNT                          ;
            ;                                           ;
        Menu_Center_Loop: ;_____________________        +
            inc Y_START                                 ;
            ;                                           ;
            jsr Menu_Set_Address                        ;
            ;                                           ;
            lda Dialogue_Box_Tiles + MENU_Y_TILE        ; Render
            sta PPUDATA                                 ;
            ;                                           ;
            ldx TEMP_WIDTH                              ;
            ldy TEXT_INDEX                              ;
            ;                                           ;
            lda Dialogue_Box_Tiles + MENU_FILL          ;
            sta PPUDATA                                 ;
            ;                                           ;
            dex                                         ;
            ;                                           ;
        Menu_Text_Loop: ;_______________________        +
            cpx #$01                                    ;
            bcc Menu_Text_Loop_End                      ;
            ;                                           ;
            lda (DialogueTextPointer), Y                ;
            beq Menu_Text_Loop_End                      ;
            ;                                           ;
            sec                                         ;
            sbc #ALPHABET_OFFSET                        ;
            ;                                           ;
            sta PPUDATA                                 ;
            ;                                           ;
            dex                                         ;
            iny                                         ;
            jmp Menu_Text_Loop                          ;
            ;                                           ;
            Menu_Text_Loop_End: ;_______________        +
                lda Dialogue_Box_Tiles + MENU_FILL      ;
                sta PPUDATA                             ;
                ;                                       ;
                dex                                     ;
                bpl Menu_Text_Loop                      ;
                ;                                       ;
                sty TEXT_INDEX                          ;
                ;                                       ;
                lda Dialogue_Box_Tiles + MENU_Y_TILE    ;
                sta PPUDATA                             ;
                ;                                       ;
                dec TEMP_ROW_COUNT                      ;
                bpl Menu_Center_Loop                    ;
            ;                                           ;
        Menu_Center_End: ;______________________        +
            inc Y_START                                 ;
            ;                                           ;
            jsr Menu_Set_Address                        ;
            ;                                           ;
            lda Dialogue_Box_Tiles + MENU_CORNER        ; Render Corner
            sta PPUDATA                                 ;
            ;                                           ;
            ldx TEMP_WIDTH                              ;
            lda Dialogue_Box_Tiles + MENU_X_TILE        ;
            ;                                           ;
        Menu_Bottom_Loop: ;_____________________        +
            sta PPUDATA                                 ;
            dex                                         ;
            bpl Menu_Bottom_Loop                        ;
            ;                                           ;
            lda Dialogue_Box_Tiles + MENU_CORNER        ; Render Corner
            sta PPUDATA                                 ;
            ;                                           ;
        Menu_End: ;_____________________________        +
            lda CPPUCTRL                                ;
            ora #PPU_BKG_TABLE                          ;
            ora #PPU_NMI                                ;
            sta CPPUCTRL                                ;
            ;                                           ;
            lda CPPUMASK                                ;
            ora #PPU_BKG                                ;
            ora #PPU_SPR                                ;
            sta CPPUMASK                                ;
            ;                                           ;
            lda Menu_Control                            ;
            ora #MENU_OPEN                              ;
            ora #MENU_NEXT                              ;
            eor #MENU_NEXT                              ;
            sta Menu_Control                            ;
            ;                                           ;
            rts                                         ;
    ;

; --------------------------------= Address =--------------------------------
    Menu_Set_Address: ;_____________________+
        lda Y_START                         ;
        lsr                                 ;
        lsr                                 ;
        lsr                                 ;
        clc                                 ;
        adc #$20                            ;
        sta CPPUADDR                        ;
        sta PPUADDR                         ;
        ;                                   ;
        lda Y_START                         ;
        asl                                 ;
        asl                                 ;
        asl                                 ;
        asl                                 ;
        asl                                 ;
        clc                                 ;
        adc X_START                         ;
        sta CPPUADDR                        ;
        sta PPUADDR                         ;
        ;                                   ;
        rts                                 ;
    ;

    Menu_Set_Variables: ;___________________+
        ldy #RESET                          ;
        ;                                   ;
        lda (DialoguePointer), Y            ; Set X Start
        sta X_START                         ;
        iny                                 ;
        ;                                   ;
        lda (DialoguePointer), Y            ; Set Y Start
        sta Y_START                         ;
        iny                                 ;
        ;                                   ;
        lda (DialoguePointer), Y            ; Set X End
        sta X_END                           ;
        iny                                 ;
        ;                                   ;
        lda (DialoguePointer), Y            ; Set Y End
        sta Y_END                           ;
        iny                                 ;
        ;                                   ;
        lda X_END                           ;
        sec                                 ;
        sbc X_START                         ;
        sec                                 ;
        sbc $01                             ;
        sta TEMP_WIDTH                      ;
        ;                                   ;
        lda Y_END                           ;
        sec                                 ;
        sbc Y_START                         ;
        sec                                 ;
        sbc $01                             ;
        sta TEMP_HEIGHT                     ;
        ;                                   ;
        lda X_START                         ;
        clc                                 ;
        adc #$02                            ;
        sta TEXT_X                          ;
        ;                                   ;
        lda Y_START                         ;
        clc                                 ;
        adc #$02                            ;
        sta TEXT_Y                          ;
        ;                                   ;
        ldy #7                              ;
        lda (DialoguePointer), Y            ; Set Text Pointer
        sta DialogueTextPointer             ;
        iny                                 ;
        lda (DialoguePointer), Y            ; Set Text Pointer
        sta DialogueTextPointer + 1         ;
        ;                                   ;
        lda #RESET                          ;
        sta TEXT_INDEX                      ;
        ;                                   ;
        rts                                 ;
    ;

; --------------------------------= Address =--------------------------------
    Menu_A_Button: ;________________________+
        lda #MENU_TIMER                     ;
        sta Button_Held_Timer, X            ;
        ;                                   ;
        lda Menu_Control                    ;
        ora #MENU_NEXT                      ;
        sta Menu_Control                    ;
        ;                                   ;
        lda Menu_Control                    ;
        and #MENU_OPEN                      ;
        beq Menu_A_Button_End               ;
            lda Menu_Control                ; Menu Pointer Check
            and #MENU_POINTER               ;
            ;                               ;
            asl                             ; Formula:
            clc                             ; (Option * 2) + 4
            adc #MENU_VALUE_SKIP            ;
            tay                             ;
            ;                               ;
            lda (DialoguePointer), Y        ; Load Next Dialogue Low
            tax                             ;
            iny                             ;
            lda (DialoguePointer), Y        ; Load Next Dialogue High
            ;                               ;
            beq Menu_A_Button_End           ; Branch if Next Dialogue High == 0
                stx DialoguePointer         ;
                sta DialoguePointer + 1     ;
                ;                           ;
        Menu_A_Button_End: ;________________+
            rts                             ;
    ;

    Menu_B_Button: ;________________+
        lda #MENU_TIMER             ;
        sta Button_Held_Timer, X    ;
        ;                           ;
        lda #RESET                  ;
        sta Menu_Control            ;
        ;                           ;
        lda BKG_Control             ;
        ora #BKG_SWAP_LATCH         ;
        sta BKG_Control             ;
        ;                           ;
        Menu_B_Button_End: ;________+
            rts                     ;
    ;

    Menu_Up_Button: ;___________________+
        lda #MENU_TIMER                 ;
        sta Button_Held_Timer, X        ;
        ;                               ;
        lda Menu_Control                ;
        and #MENU_OPTION_MAX            ;
        beq Menu_Up_Button_Wrap         ;
            dec Menu_Control            ;
            jmp Menu_Up_Button_End      ;
            ;                           ;
        Menu_Up_Button_Wrap: ;__________+
            lda Menu_Control            ;
            clc                         ;
            adc #MENU_OPTION_MAX        ;
            sta Menu_Control            ;
            ;                           ;
        Menu_Up_Button_End: ;___________+
            rts                         ;
            ;                           ;
    Menu_Down_Button: ;_________________+
        lda #MENU_TIMER                 ;
        sta Button_Held_Timer, X        ;
        ;                               ;
        lda Menu_Control                ;
        and #MENU_OPTION_MAX            ;
        cmp #MENU_OPTION_MAX            ;
        beq Menu_Down_Button_Wrap       ;
            inc Menu_Control            ;
            jmp Menu_Down_Button_End    ;
            ;                           ;
        Menu_Down_Button_Wrap: ;________+
            lda Menu_Control            ;
            sec                         ;
            sbc #MENU_OPTION_MAX        ;
            sta Menu_Control            ;
            ;                           ;
        Menu_Down_Button_End: ;_________+
            rts                         ;
    ;   