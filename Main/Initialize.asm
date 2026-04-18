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