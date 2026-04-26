; ================================================================
;   Bank.asm
;   Handles Bank Switching
; 
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

    ; X = Bank to Replace
    ; Y = Bank to Replace With

    Load_Bank: ;________________+
        txa                     ;
        sta MMC3_BANK_SELECT    ;
        tya                     ;
        sta MMC3_BANK_DATA      ;
        rts                     ;
    ;