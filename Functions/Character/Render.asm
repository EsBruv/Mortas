; ================================================================
;   Render.asm
;   Handles Character Rendering
; 
;   Revision History:
;       Essam Erbab, May 2026: Created
; ================================================================

    Sprite_Y_Offset:
        .byte SPRITE_BASE
        .byte SPRITE_OFFSET
        .byte SPRITE_BASE
        .byte SPRITE_OFFSET

    Sprite_X_Offset:
        .byte SPRITE_BASE
        .byte SPRITE_BASE
        .byte SPRITE_OFFSET
        .byte SPRITE_OFFSET

    Sprite_Attribute:
        .byte ATTRIBUTE_BASE
        .byte ATTRIBUTE_BASE
        .byte ATTRIBUTE_H_FLIP
        .byte ATTRIBUTE_H_FLIP

    Render_Character: ;_________________+
        lda YPosition                   ;
        sta Temp                        ;
        lda XPosition                   ;
        sta Temp + 1                    ;
        ;                               ;
        ldx #RESET                      ;
        ;                               ;
        Render_Character_Loop: ;________+
            lda Temp                    ;
            clc                         ;
            adc Sprite_Y_Offset, X      ;
            sec                         ;
            sbc #SPRITE_YPOSITION_FIX   ;
            sta OAMDATA                 ;
            ;                           ;
            lda #$01                    ;
            sta OAMDATA                 ;
            ;                           ;
            lda Sprite_Attribute, X     ;
            sta OAMDATA                 ;
            ;                           ;
            lda Temp + 1                ;
            clc                         ;
            adc Sprite_X_Offset, X      ;
            sta OAMDATA                 ;
            ;                           ;
            inx                         ;
            cpx #SPRITE_AMOUNT          ;
            bne Render_Character_Loop   ;
        ;                               ;
        lda #RESET                      ;
        sta Temp                        ;
        sta Temp + 1                    ;
        rts                             ;
    ;

    Render_Blank: ;_____________________+
        lda #$00                        ;
        asl                             ;
        asl                             ;
        tax                             ;
        inx                             ;
        lda OAMDATA, X                  ;
        beq Render_Blank_End            ;
        ;                               ;
        lda #RESET                      ;
        sta Temp                        ;
        sta Temp + 1                    ;
        sta Temp + 2                    ;
        ldx #RESET                      ;
        ;                               ;
        Render_Blank_Loop: ;____________+
            lda #RESET                  ;
            sta OAMDATA                 ;
            ;                           ;
            lda #RESET                  ;
            sta OAMDATA                 ;
            ;                           ;
            lda #RESET                  ;
            sta OAMDATA                 ;
            ;                           ;
            lda #RESET                  ;
            sta OAMDATA                 ;
            ;                           ;
            inx                         ;
            cpx #SPRITE_AMOUNT          ;
            bne Render_Blank_Loop       ;
        ;                               ;
        Render_Blank_End: ;_____________+
            lda #RESET                  ;
            sta Temp                    ;
            sta Temp + 1                ;
            rts                         ;
    ;