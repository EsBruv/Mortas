; ================================================================
;   Initialize.asm
;   Handles Initialization Logic
;
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

; --------------------------------= Memory =--------------------------------
    Initialize: ;_______________________+
        reset:                          ;
            sei                         ;
            cld                         ;
            ldx #$40                    ;
            stx JOY2                    ;
            ldx #MAX                    ;
            txs                         ;
            ;                           ;
            ldx #RESET                  ;
            stx PPUCTRL                 ;
            stx PPUMASK                 ;
            stx DMCFREQ                 ;
            ;                           ;
        jsr vBlankWait                  ;
        ;                               ;
        clear_memory: ;_________________+
            lda #RESET                  ;
            sta $0000, x                ;
            sta $0100, x                ;
            sta $0200, x                ;
            sta $0300, x                ;
            sta $0400, x                ;
            sta $0500, x                ;
            sta $0600, x                ;
            sta $0700, x                ;
            inx                         ;
            bne clear_memory            ;
            ;                           ;
        jsr vBlankWait                  ;
    ;

; --------------------------------= Initialization =--------------------------------

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
    Finalize: ;_____________+
        lda CPPUCRTL        ;
        ora #PPU_BKG_TABLE  ;
        ora #PPU_NMI        ;
        sta PPUCTRL         ;
        sta CPPUCRTL        ;
        ;                   ;
        lda CPPUMASK        ;
        ora #PPU_BKG        ;
        ora #PPU_SPR        ;
        sta PPUMASK         ;
        ;                   ;
        lda CamXPosition    ;
        sta PPUSCROLL       ;
        lda CamYPosition    ;
        sta PPUSCROLL       ;
    ;

;