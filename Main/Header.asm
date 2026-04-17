; ================================================================
;   Header.asm
;   Handles Header Bytes
;
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

    .segment "HEADER"
        .byte $4E, $45, $53                                 ; NES Verification
        .byte $1A                                           ;
        .byte $08                                           ; (16KB * 8 ($08) = 128KB)
        .byte $10                                           ; (8KB * 16 ($10) = 128KB)
        .byte $4A                                           ; 
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00   ;