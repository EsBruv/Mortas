; ================================================================
;   Header.asm
;   Handles Header Bytes
;
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

    .segment "HEADER"
        .byte $4E, $45, $53, $1A                            ; NES Verification
        .byte $08                                           ; (16KB * 8 = 128KB)
        .byte $10                                           ; (8KB * 16 = 128KB)
        .byte %01001010                                     ; MMC3 (Mapper 4) + 4-Screen VRAM + Battery
        .byte $08                                           ; NES 2.0
        .byte $00, $00                                      ; Unused
        .byte $70                                           ; 8 KB PRG-NVRAM
        .byte $00, $00, $00, $00, $00                       ; Unused