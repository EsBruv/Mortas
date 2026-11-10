; ================================================================
;   Initialize.asm
;   Handles Initialization Logic
;
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

; --------------------------------= Constants =--------------------------------

    ; RESET             = $00 (Global.asm)
    ; MAX               = $FF (Global.asm)

    ; PPU_BKG_TABLE     = $10 (Global.asm)
    ; PPU_NMI           = $80 (Global.asm)
    ; PPU_BKG           = $08 (Global.asm)
    ; PPU_SPR           = $10 (Global.asm)

    ; M                 = $4D (Global.asm)
    ; O                 = $4F (Global.asm)
    ; R                 = $52 (Global.asm)
    ; T                 = $54 (Global.asm)
    ; _A                = $41 (Global.asm)
    ; S                 = $53 (Global.asm)

    APU_CLEAR           = $40

; --------------------------------= Memory =--------------------------------
    
    vBlankWait: ;___________+
        bit PPUSTATUS       ;
        bpl vBlankWait      ; Branch on +
        ;                   ;
        rts                 ;
    ;

    Initialize: ;_______________________+
        reset:                          ;
            sei                         ;
            cld                         ;
            ldx #APU_CLEAR              ;
            stx JOY2                    ;
            ldx #MAX                    ;
            txs                         ;
            ;                           ;
            ldx #RESET                  ;
            stx PPUCTRL                 ; NMI Off
            stx PPUMASK                 ; Render Off
            stx DMCFREQ                 ; DMC IRQ Off
            stx APUSTATUS               ; APU Off
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
        Clear_OAM: ;____________________+
            lda #MAX                    ;
            ;                           ;
            Clear_OAM_Loop:             ;
                sta DMA, X              ;
                inx                     ;
                bne Clear_OAM_Loop      ;
                ;                       ;
        jsr vBlankWait                  ;
        ;                               ;
        jsr Initialize_Bank             ;
        jsr Initialize_RNG              ;
        jsr Initialize_Palette          ;
        jsr Initialize_Background       ;
        ;                               ;
    Initialize_Player: ;________________+
        lda #$20                        ;
        sta XPosition                   ;
        lda #$80                        ;
        sta YPosition                   ;
        sta CharacterHealth             ;
        ;                               ;
        lda #%00000100                  ;
        sta CharacterType               ;
        ;                               ;

        lda #$40                        ;
        sta XPosition + 1               ;
        lda #$80                        ;
        sta YPosition + 1               ;
        sta CharacterHealth + 1         ;
        ;                               ;
        lda #%00000100                  ;
        sta CharacterType + 1           ;



        lda #$60                        ;
        sta XPosition + 2               ;
        lda #$80                        ;
        sta YPosition + 2               ;
        sta CharacterHealth + 2         ;
        ;                               ;
        lda #%00000100                  ;
        sta CharacterType + 2           ;
        ;                               ;



        lda #$80                        ;
        sta XPosition + 3               ;
        lda #$80                        ;
        sta YPosition + 3               ;
        sta CharacterHealth + 3         ;
        ;                               ;
        lda #%00000100                  ;
        sta CharacterType + 3           ;
        ;                               ;



        lda #$A0                        ;
        sta XPosition + 4               ;
        lda #$80                        ;
        sta YPosition + 4               ;
        sta CharacterHealth + 4         ;
        ;                               ;
        lda #%00000100                  ;
        sta CharacterType + 4           ;
        ;                               ;
    Finalize: ;_________________________+
        lda #M                          ;
        sta Validation + 0              ;
        lda #O                          ;
        sta Validation + 1              ;
        lda #R                          ;
        sta Validation + 2              ;
        lda #T                          ;
        sta Validation + 3              ;
        lda #_A                         ;
        sta Validation + 4              ;
        lda #S                          ;
        sta Validation + 5              ;
        ;                               ;
        lda CPPUCTRL                    ;
        ora #PPU_BKG_TABLE              ;
        ora #PPU_NMI                    ;
        sta PPUCTRL                     ;
        sta CPPUCTRL                    ;
        ;                               ;
        lda CPPUMASK                    ;
        ora #PPU_BKG                    ;
        ora #PPU_SPR                    ;
        sta PPUMASK                     ;
        ;                               ;
        lda CamXPosition                ;
        sta PPUSCROLL                   ;
        lda CamYPosition                ;
        sta PPUSCROLL                   ;
        ;                               ;
        jmp Main                        ;
    ;

;