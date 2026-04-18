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

; --------------------------------= Table =--------------------------------
    Palette_Table: 
        .byte $1D, $1D, $1D, $1D
        .byte $1D, $20, $10, $00
        .byte $1D, $21, $11, $01
        .byte $1D, $22, $12, $02
        .byte $1D, $23, $13, $03
        .byte $1D, $24, $14, $04
        .byte $1D, $25, $15, $05
        .byte $1D, $26, $16, $06
        .byte $1D, $27, $17, $07
        .byte $1D, $28, $18, $08
        .byte $1D, $29, $19, $09
        .byte $1D, $2A, $1A, $0A
        .byte $1D, $2B, $1B, $0B
        .byte $1D, $2C, $1C, $0C