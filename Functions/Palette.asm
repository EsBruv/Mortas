; ================================================================
;   Palette.asm
;   Handles Palettes
;
;   Revision History:
;       Essam Erbab, April 2026: Created
;       Essam Erbab, November 2026: Updated
; ================================================================

; --------------------------------= Constants =--------------------------------

    PALETTE_HIGH    = $3F

    PALETTE_BKG_1   = $00
    PALETTE_BKG_2   = $01
    PALETTE_BKG_3   = $02
    PALETTE_BKG_4   = $03
    PALETTE_SPR_1   = $04
    PALETTE_SPR_2   = $05
    PALETTE_SPR_3   = $06
    PALETTE_SPR_4   = $07

    BLACK           = $00
    GREY            = $04
    BLUE            = $08
    PURPLE          = $0C
    MEGENTA         = $10
    PINK            = $14
    RED             = $18
    ORANGE          = $1C
    GOLD            = $20
    PUKE            = $24
    GREEN           = $28
    EMERALD         = $2C
    TEAL            = $30
    CYAN            = $34

; --------------------------------= Table =--------------------------------
    
    Palette_Table: 
        .byte $1D, $1D, $1D, $1D    ;BLACK
        .byte $1D, $20, $10, $00    ;GREY
        .byte $1D, $21, $11, $01    ;BLUE
        .byte $1D, $22, $12, $02    ;PURPLE
        .byte $1D, $23, $13, $03    ;MEGENTA
        .byte $1D, $24, $14, $04    ;PINK
        .byte $1D, $25, $15, $05    ;RED
        .byte $1D, $26, $16, $06    ;ORANGE
        .byte $1D, $27, $17, $07    ;GOLD
        .byte $1D, $28, $18, $08    ;PUKE
        .byte $1D, $29, $19, $09    ;GREEN
        .byte $1D, $2A, $1A, $0A    ;EMERALD
        .byte $1D, $2B, $1B, $0B    ;TEAL
        .byte $1D, $2C, $1C, $0C    ;CYAN

; --------------------------------= Palette =--------------------------------

    Initialize_Palette: ;___+
        ldx #PALETTE_BKG_1  ;
        ldy #BLUE           ;
        jsr Load_Palette    ;
        ;                   ;
        ldx #PALETTE_BKG_2  ;
        ldy #PURPLE         ;
        jsr Load_Palette    ;
        ;                   ;
        ldx #PALETTE_BKG_3  ;
        ldy #MEGENTA        ;
        jsr Load_Palette    ;
        ;                   ;
        ldx #PALETTE_BKG_4  ;
        ldy #PINK           ;
        jsr Load_Palette    ;
        ;                   ;
        ldx #PALETTE_SPR_1  ;
        ldy #ORANGE         ;
        jsr Load_Palette    ;
        ;                   ;
        ldx #PALETTE_SPR_2  ;
        ldy #GOLD           ;
        jsr Load_Palette    ;
        ;                   ;
        ldx #PALETTE_SPR_3  ;
        ldy #GREEN          ;
        jsr Load_Palette    ;
        ;                   ;
        ldx #PALETTE_SPR_4  ;
        ldy #EMERALD        ;
        jsr Load_Palette    ;
        ;                   ;
        rts                 ;
        ;

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