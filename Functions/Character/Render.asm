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

    Render_OAM: ;_______+
        lda #RESET      ;
        sta OAMADDR     ;
        lda #>DMA       ;
        sta OAMDMA      ;
        ;               ;
        rts             ;
    ;

    Render_Character: ;_____________+
        lda YPosition, X            ;
        clc                         ;
        adc #SPRITE_BASE            ;
        sec                         ;
        sbc #SPRITE_YPOSITION_FIX   ;
        sta DMA, Y                  ;
        iny                         ;
        ;                           ;
        jsr Character_Selection     ;
        sta DMA, Y                  ;
        iny                         ;
        ;                           ;
        lda #ATTRIBUTE_BASE         ;
        sta DMA, Y                  ;
        iny                         ;
        ;                           ;
        lda XPosition, X            ;
        clc                         ;
        adc #SPRITE_BASE            ;
        sta DMA, Y                  ;
        iny                         ;
        ;                           ;
        lda YPosition, X            ;
        clc                         ;
        adc #SPRITE_OFFSET          ;
        sec                         ;
        sbc #SPRITE_YPOSITION_FIX   ;
        sta DMA, Y                  ;
        iny                         ;
        ;                           ;
        jsr Character_Selection     ;
        sta DMA, Y                  ;
        iny                         ;
        ;                           ;
        lda #ATTRIBUTE_BASE         ;
        sta DMA, Y                  ;
        iny                         ;
        ;                           ;
        lda XPosition, X            ;
        clc                         ;
        adc #SPRITE_BASE            ;
        sta DMA, Y                  ;
        iny                         ;
        ;                           ;
        lda YPosition, X            ;
        clc                         ;
        adc #SPRITE_BASE            ;
        sec                         ;
        sbc #SPRITE_YPOSITION_FIX   ;
        sta DMA, Y                  ;
        iny                         ;
        ;                           ;
        jsr Character_Selection     ;
        sta DMA, Y                  ;
        iny                         ;
        ;                           ;
        lda #ATTRIBUTE_H_FLIP       ;
        sta DMA, Y                  ;
        iny                         ;
        ;                           ;
        lda XPosition, X            ;
        clc                         ;
        adc #SPRITE_OFFSET          ;
        sta DMA, Y                  ;
        iny                         ;
        ;                           ;
        lda YPosition, X            ;
        clc                         ;
        adc #SPRITE_OFFSET          ;
        sec                         ;
        sbc #SPRITE_YPOSITION_FIX   ;
        sta DMA, Y                  ;
        iny                         ;
        ;                           ;
        jsr Character_Selection     ;
        sta DMA, Y                  ;
        iny                         ;
        ;                           ;
        lda #ATTRIBUTE_H_FLIP       ;
        sta DMA, Y                  ;
        iny                         ;
        ;                           ;
        lda XPosition, X            ;
        clc                         ;
        adc #SPRITE_OFFSET          ;
        sta DMA, Y                  ;
        iny                         ;
        ;                           ;
        rts                         ;
    ;

    Render_Empty: ;_____+
        lda #MAX        ;
        sta DMA, Y      ;
        iny             ;
        ;               ;
        lda #RESET      ;
        sta DMA, Y      ;
        iny             ;
        ;               ;
        lda #RESET      ;
        sta DMA, Y      ;
        iny             ;
        ;               ;
        lda #MAX        ;
        sta DMA, Y      ;
        iny             ;
        ;               ;
        lda #MAX        ;
        sta DMA, Y      ;
        iny             ;
        ;               ;
        lda #RESET      ;
        sta DMA, Y      ;
        iny             ;
        ;               ;
        lda #RESET      ;
        sta DMA, Y      ;
        iny             ;
        ;               ;
        lda #MAX        ;
        sta DMA, Y      ;
        iny             ;
        ;               ;
        lda #MAX        ;
        sta DMA, Y      ;
        iny             ;
        ;               ;
        lda #RESET      ;
        sta DMA, Y      ;
        iny             ;
        ;               ;
        lda #RESET      ;
        sta DMA, Y      ;
        iny             ;
        ;               ;
        lda #MAX        ;
        sta DMA, Y      ;
        iny             ;
        ;               ;
        lda #MAX        ;
        sta DMA, Y      ;
        iny             ;
        ;               ;
        lda #RESET      ;
        sta DMA, Y      ;
        iny             ;
        ;               ;
        lda #RESET      ;
        sta DMA, Y      ;
        iny             ;
        ;               ;
        lda #MAX        ;
        sta DMA, Y      ;
        iny             ;
        ;               ;
        rts             ;
    ;