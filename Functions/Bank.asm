; ================================================================
;   Bank.asm
;   Handles Bank Switching
; 
;   Revision History:
;       Essam Erbab, April 2026: Created
;       Essam Erbab, November 2026: Updated
; ================================================================

; --------------------------------= Constants =--------------------------------
    
    SPRBANK0        = $00
    SPRBANK1        = $01

    BKGBANK0        = $02
    BKGBANK1        = $03
    BKGBANK2        = $04
    BKGBANK3        = $05

    PRGBANK0        = $06
    PRGBANK1        = $07

    CHR_SECTION_1   = $00
    CHR_SECTION_2   = $01
    CHR_SECTION_3   = $02
    CHR_SECTION_4   = $03

    ; <<<=-= PRG Banks =-=>>>
        PRG00   = $00
        PRG01   = $01
        PRG02   = $02
        PRG03   = $03
        PRG04   = $04
        PRG05   = $05
        PRG06   = $06
        PRG07   = $07
        PRG08   = $08
        PRG09   = $09
        PRG0A   = $0A
        PRG0B   = $0B
        PRG0C   = $0C
        PRG0D   = $0D

    ; <<<=-= Sprite =-=>>>

        SPR00   = $00
        SPR01   = $08
        SPR02   = $10
        SPR03   = $18
        SPR04   = $20
        SPR05   = $28
        SPR06   = $30
        SPR07   = $38

    ; <<<=-= Background =-=>>>

        BKG00   = $04
        BKG01   = $0C
        BKG02   = $14
        BKG03   = $1C
        BKG04   = $24
        BKG05   = $2C
        BKG06   = $34
        BKG07   = $3C

    MMC3_DEFAULT_BANK   = $00
    MMC3_RAM_ENABLE     = $80
    MMC3_RAM_PROTECT    = $C0

    BANK_VALIDATION     = $07

; --------------------------------= Table =--------------------------------

    Initial_Banks:
        .byte SPR00 + 0
        .byte SPR00 + 2
        .byte BKG00 + 0
        .byte BKG00 + 1
        .byte BKG00 + 2
        .byte BKG00 + 3
        .byte PRG00
        .byte PRG01

; --------------------------------= Bank =--------------------------------

    Initialize_Bank: ;__________________+
        sta MMC3_IRQ_DISABLE            ; Disable IRQs
        ;                               ;
        lda #MMC3_RAM_ENABLE            ; Enable RAM
        sta MMC3_RAM                    ;
        ;                               ;
        ldx #RESET                      ;
        Initialize_Bank_Loop: ;_________+
            txa                         ;
            sta MMC3_BANK_SELECT        ;
            lda Initial_Banks, x        ;
            sta MMC3_BANK_DATA          ;
            inx                         ;
            ;                           ;
            cpx #$08                    ;
            bne Initialize_Bank_Loop    ;
        rts                             ;
    ;

    Load_Bank: ;________________+
        txa                     ; X = Bank to Replace
        and #BANK_VALIDATION    ; Validate Bank
        sta MMC3_BANK_SELECT    ;
        tya                     ; Y = Bank to Replace With
        sta MMC3_BANK_DATA      ;
        rts                     ;
    ;