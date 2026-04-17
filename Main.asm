; ================================================================
;   Main.asm
;   Handle Main Connections
;
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

.include "Main/Header.asm"

.segment "VECTORS"
    .addr Render
    .addr Initialize
    .addr 0

; --------------------------------= Variables =--------------------------------

    .include "Variables/Nes.asm"
    .include "Variables/Save.asm"
    .include "Variables/Zeropage.asm"
    .include "Variables/Constants.asm"
    
; --------------------------------= Code =--------------------------------

.segment "CODE"
    .include "Main/Initialize.asm"
 
    .include "Main/Calculations.asm"
    .include "Main/Render.asm"

; --------------------------------= Connections =--------------------------------
    .include "Functions/Functions.asm"
