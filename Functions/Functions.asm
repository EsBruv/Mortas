; ================================================================
;   Functions.asm
;   Handles Function Connections
; 
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

    vBlankWait: ;___________+
        bit PPUSTATUS       ;
        bpl vBlankWait      ; Branch on +
        ;                   ;
        vBlankWait_End: ;___+ End vBlank
            rts             ;
    ;

; --------------------------------= Connections =--------------------------------

    .include "Bank.asm"
    .include "Clock.asm"
    .include "Palette.asm"

    .include "Input.asm"
    .include "Buttons.asm"