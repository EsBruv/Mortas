; ================================================================
;   Shift.asm
;   Handles Screen Shift Logic
; 
;   Revision History:
;       Essam Erbab, May 2026: Created
;       Essam Erbab, November 2026: Updated
; ================================================================

; --------------------------------= Constants =--------------------------------

    ; RESET                 = $00 (Global.asm)
    
    ; BKG_SHIFT_DIRECTION   = $40 (Global.asm)

    ; PPU_X                 = $01 (Global.asm)
    ; PPU_Y                 = $02 (Global.asm)
    ; PPU_SCROLL_CLEAR      = $FC (Global.asm)

    ; CURRENT_SCREEN        = $0C (Swap.asm)
    ; SCREEN_1              = $00 (Swap.asm)
    ; SCREEN_2              = $04 (Swap.asm)
    ; SCREEN_3              = $08 (Swap.asm)

    ; SCREEN_SIZE           = $20 (Selection.asm)

    INCREMENT_AMOUNT        = $02
    DECREMENT_AMOUNT        = $02

    SCREEN_X_INCREMENT      = $01
    SCREEN_Y_INCREMENT      = $10

    SCREEN_LEFT             = $10
    SCREEN_RIGHT            = $E0
    SCREEN_UP               = $10
    SCREEN_DOWN             = $D0

    SHIFT_EDGE_LEFT         = $02
    SHIFT_EDGE_RIGHT        = $FE
    SHIFT_EDGE_UP           = $02
    SHIFT_EDGE_DOWN         = $EE

    SHIFT_REPOSITION_RIGHT  = $30
    SHIFT_REPOSITION_LEFT   = $D2
    SHIFT_REPOSITION_UP     = $C2
    SHIFT_REPOSITION_DOWN   = $30

    SHIFT_Y_OFFSET          = $12

; --------------------------------= Shift =--------------------------------
    
    Shift: ;____________________________+
        lda BKG_Control                 ; Current Screen Check
        and #CURRENT_SCREEN             ;
        ;                               ;
        cmp #SCREEN_2                   ;
        beq Shift_Screen_2              ; Branch If Current Screen = 2
        cmp #SCREEN_3                   ;
        beq Shift_Screen_3              ; Branch If Current Screen = 3
        ;                               ;
        rts                             ;
        ;                               ;
        Shift_Screen_2: ;_______________;
            lda BKG_Control             ;
            and #BKG_SHIFT_DIRECTION    ;
            beq Shift_Left_Jump         ;
                jmp Shift_Right         ;
                ;                       ;
            Shift_Left_Jump:            ;
                jmp Shift_Left          ;
                ;                       ;
        Shift_Screen_3: ;_______________+
            lda BKG_Control             ;
            and #BKG_SHIFT_DIRECTION    ;
            beq Shift_Up_Jump           ;
                jmp Shift_Down          ;
                ;                       ;
            Shift_Up_Jump:              ;
                jmp Shift_Up            ;
    ;

; --------------------------------= Direction =--------------------------------
    
    Shift_Up: ;_________________________+
        lda CPPUCTRL                    ;
        and #PPU_SCROLL_CLEAR           ;
        ora #PPU_Y                      ;
        sta PPUCTRL                     ;
        sta CPPUCTRL                    ;
        ;                               ;
        lda CamYPosition                ;
        sec                             ;
        sbc #DECREMENT_AMOUNT           ;
        sta CamYPosition                ;
        ;                               ;
        lda CamYPosition                ;
        cmp #SHIFT_REPOSITION_UP        ;
        bcs Shift_Up_Clear              ;
        ;                               ;
        lda YPosition                   ;
        clc                             ;
        adc #INCREMENT_AMOUNT           ;
        sta YPosition                   ;
        ;                               ;
        Shift_Up_Clear: ;_______________+
            lda CamYPosition            ;
            cmp #SHIFT_EDGE_UP          ;
            bne Shift_Up_End            ;
                lda CamYPosition        ;
                sec                     ;
                sbc #DECREMENT_AMOUNT   ;
                sta CamYPosition        ;
                ;                       ;
                lda YPosition           ;
                clc                     ;
                adc #INCREMENT_AMOUNT   ;
                sta YPosition           ;
                ;                       ;
            jmp Shift_Clear             ;
            ;                           ;
        Shift_Up_End: ;_________________+
            jmp Shift_End
    ;

    Shift_Down: ;_______________________+
        ;                               ;
        lda CamYPosition                ;
        clc                             ;
        adc #INCREMENT_AMOUNT           ;
        sta CamYPosition                ;
        ;                               ;
        lda CamYPosition                ;
        cmp #SHIFT_REPOSITION_DOWN      ;
        bcc Shift_Down_Clear            ;
        ;                               ;
        lda YPosition                   ;
        sec                             ;
        sbc #DECREMENT_AMOUNT           ;
        sta YPosition                   ;
        ;                               ;
        Shift_Down_Clear: ;_____________+
            lda CamYPosition            ;
            cmp #SHIFT_EDGE_DOWN        ;
            bne Shift_Down_End          ;
                lda CamYPosition        ;
                clc                     ;
                adc #SHIFT_Y_OFFSET     ;
                sta CamYPosition        ;
                ;                       ;
                lda YPosition           ;
                sec                     ;
                sbc #DECREMENT_AMOUNT   ;
                sta YPosition           ;
                ;                       ;
            jmp Shift_Clear             ;
            ;                           ;
        Shift_Down_End: ;_______________+
            jmp Shift_End
    ;

    Shift_Left: ;_______________________+
        lda CPPUCTRL                    ;
        and #PPU_SCROLL_CLEAR           ;
        ora #PPU_X                      ;
        sta PPUCTRL                     ;
        sta CPPUCTRL                    ;
        ;                               ;
        lda CamXPosition                ;
        sec                             ;
        sbc #DECREMENT_AMOUNT           ;
        sta CamXPosition                ;
        ;                               ;
        lda CamXPosition                ;
        cmp #SHIFT_REPOSITION_LEFT      ;
        bcs Shift_Left_Clear            ;
        ;                               ;
        lda XPosition                   ;
        clc                             ;
        adc #INCREMENT_AMOUNT           ;
        sta XPosition                   ;
        ;                               ;
        Shift_Left_Clear: ;_____________+
            lda CamXPosition            ;
            cmp #SHIFT_EDGE_LEFT        ;
            bne Shift_Left_End          ;
                lda CamXPosition        ;
                sec                     ;
                sbc #DECREMENT_AMOUNT   ;
                sta CamXPosition        ;
                ;                       ;
                lda XPosition           ;
                clc                     ;
                adc #INCREMENT_AMOUNT   ;
                sta XPosition           ;
                ;                       ;
            jmp Shift_Clear             ;
            ;                           ;
        Shift_Left_End: ;_______________+
            jmp Shift_End
    ;

    Shift_Right: ;______________________+
        lda CamXPosition                ;
        clc                             ;
        adc #INCREMENT_AMOUNT           ;
        sta CamXPosition                ;
        ;                               ;
        lda CamXPosition                ;
        cmp #SHIFT_REPOSITION_RIGHT     ;
        bcc Shift_Right_Clear           ;
        ;                               ;
        lda XPosition                   ;
        sec                             ;
        sbc #DECREMENT_AMOUNT           ;
        sta XPosition                   ;
        ;                               ;
        Shift_Right_Clear: ;____________+
            lda CamXPosition            ;
            cmp #SHIFT_EDGE_RIGHT       ;
            bne Shift_Right_End         ;
                lda CamXPosition        ;
                clc                     ;
                adc #INCREMENT_AMOUNT   ;
                sta CamXPosition        ;
                ;                       ;
                lda XPosition           ;
                sec                     ;
                sbc #DECREMENT_AMOUNT   ;
                sta XPosition           ;
                ;                       ;
            jmp Shift_Clear             ;
            ;                           ;
        Shift_Right_End: ;______________+
            jmp Shift_End
    ;

    Shift_Screen_Store: ;_______________________+
        lda BKG_Control                         ;
        and #CURRENT_SCREEN                     ;
        cmp #SCREEN_3                           ;
        beq Shift_Screen_Y_Store                ;
        ;                                       ;
        Shift_Screen_X_Store: ;_________________+
            ldx #RESET                          ;
            ;                                   ;
            Shift_Screen_X_Store_Loop: ;________+
                lda Screen_X, x                 ;
                sta Screen_Main, x              ;
                inx                             ;
                cpx #SCREEN_SIZE                ;
                bne Shift_Screen_X_Store_Loop   ;
            rts                                 ;
            ;                                   ;
        Shift_Screen_Y_Store: ;_________________+
            ldx #RESET                          ;
            Shift_Screen_Y_Store_Loop: ;________+
                lda Screen_Y, x                 ;
                sta Screen_Main, x              ;
                inx                             ;
                cpx #SCREEN_SIZE                ;
                bne Shift_Screen_Y_Store_Loop   ;
            rts                                 ;

    Shift_Clear: ;__________________+
        jsr Shift_Screen_Store      ;
        ;                           ;
        lda BKG_Control             ;
        and #BKG_UNDERGROUND        ;
        ora #BKG_SWAP_LATCH         ;
        ora #SCREEN_1               ;
        sta BKG_Control             ;
        ;                           ;
        lda CPPUCTRL                ;
        and #PPU_SCROLL_CLEAR       ;
        sta CPPUCTRL                ;
        sta PPUCTRL                 ;
        ;                           ;
        lda #RESET                  ;
        sta CamXPosition            ;
        sta CamYPosition            ;
        sta PPUSCROLL               ;
        sta PPUSCROLL               ;
        ;                           ;
    Shift_End: ;____________________+
        lda #RESET                  ;
        tax                         ;
        tay                         ;
        rts                         ; 
    ;