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
    .include "RNG.asm"

    .include "Controls/Input.asm"
    .include "Controls/Buttons.asm"

    .include "Background/Swap.asm"
    .include "Background/Collision.asm"
    .include "Background/Shift.asm"
    .include "Background/Selection.asm"

    .include "Character/Collision.asm"
    .include "Character/Enemy.asm"
    .include "Character/Health.asm"
    .include "Character/Movement.asm"
    .include "Character/Projectile.asm"
    .include "Character/Render.asm"
    .include "Character/Selection.asm"