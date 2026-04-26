; ================================================================
;   Palette.asm
;   Outlines Palette Swapping
;
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

; --------------------------------= Method =--------------------------------
    Load_Palette: ;_________________+
        lda PPUSTATUS               ;
        ;                           ;
        lda #PALETTE_HIGH           ;
        sta PPUADDR                 ;
        txa                         ;
        asl                         ;
        asl                         ;
        sta PPUADDR                 ;
        ;                           ;
        lda Palette_Table + 0, Y    ;
        sta PPUDATA                 ;
        lda Palette_Table + 1, Y    ;
        sta PPUDATA                 ;
        lda Palette_Table + 2, Y    ;
        sta PPUDATA                 ;
        lda Palette_Table + 3, Y    ;
        sta PPUDATA                 ;
        ;                           ;
        rts                         ;
    ;