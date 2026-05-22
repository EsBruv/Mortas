; ================================================================
;   Shift.asm
;   Handles Screen Shift Logic
; 
;   Revision History:
;       Essam Erbab, May 2026: Created
; ================================================================

; --------------------------------= Main =--------------------------------
    Shift: ;____________________________+
        lda BKG_Control                 ; Current Screen Check
        and #CURRENT_SCREEN             ;
        ;                               ;
        cmp #SCREEN_2                   ;
        beq Shift_Screen2               ; Branch If Current Screen = 2
        cmp #SCREEN_3                   ;
        beq Shift_Screen3               ; Branch If Current Screen = 3
        ;                               ;
        rts                             ;
        ;                               ;
        Shift_Screen2: ;________________;
            lda BKG_Control             ;
            and #SHIFT_OFFSET           ;
            beq Shift_Left_Jump         ;
                jmp Shift_Right         ;
                ;                       ;
            Shift_Left_Jump:            ;
                jmp Shift_Left          ;
                ;                       ;
        Shift_Screen3:                  ;
            lda BKG_Control             ;
            and #SHIFT_OFFSET           ;
            beq Shift_Up_Jump           ;
                jmp Shift_Down          ;
                ;                       ;
            Shift_Up_Jump:              ;
                jmp Shift_Up            ;
    ;

; --------------------------------= Direction =--------------------------------
    
    Shift_Up: ;_________________________+
        lda CPPUCTRL                    ;
        ora #SCREEN_3                   ;
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
                adc #SHIFT_DOWN_OFFSET  ;
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
        ora #SCREEN_2                   ;
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

    Shift_Clear: ;__________________+
        lda BKG_Control             ;
        and #SHIFT_CLEAR            ;
        sta BKG_Control             ;
        ;                           ;
        lda CPPUCTRL                ;
        and #$FC                    ;
        sta CPPUCTRL                ;
        ;                           ;
    Shift_End: ;____________________+
        lda #RESET                  ;
        ora #PPU_BKG_TABLE          ;
        ora #PPU_NMI                ;
        sta PPUCTRL                 ;
        sta CPPUCTRL                ;
        ;                           ;
        lda #RESET                  ;
        ora #PPU_BKG                ;
        ora #PPU_SPR                ;
        sta PPUMASK                 ;
        ;                           ;
        lda CamXPosition            ;
        sta PPUSCROLL               ;
        lda CamYPosition            ;
        sta PPUSCROLL               ;
        ;                           ;
        lda #RESET                  ;
        tax                         ;
        tay                         ;
        rts                         ; 
    ;