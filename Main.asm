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

    .include "Data/Banks/Program/PRGBank00.asm"
    .include "Data/Banks/Program/PRGBank01.asm"
    .include "Data/Banks/Program/PRGBank02.asm"
    .include "Data/Banks/Program/PRGBank03.asm"
    .include "Data/Banks/Program/PRGBank04.asm"
    .include "Data/Banks/Program/PRGBank05.asm"
    .include "Data/Banks/Program/PRGBank06.asm"
    .include "Data/Banks/Program/PRGBank07.asm"
    .include "Data/Banks/Program/PRGBank08.asm"
    .include "Data/Banks/Program/PRGBank09.asm"
    .include "Data/Banks/Program/PRGBank0A.asm"
    .include "Data/Banks/Program/PRGBank0B.asm"
    .include "Data/Banks/Program/PRGBank0C.asm"
    .include "Data/Banks/Program/PRGBank0D.asm"

    ; Sprite Banks

    .include "Data/Banks/Sprite/SPRBank00.inc"
    .include "Data/Banks/Sprite/SPRBank01.inc"
    .include "Data/Banks/Sprite/SPRBank02.inc"
    .include "Data/Banks/Sprite/SPRBank03.inc"
    .include "Data/Banks/Sprite/SPRBank04.inc"
    .include "Data/Banks/Sprite/SPRBank05.inc"
    .include "Data/Banks/Sprite/SPRBank06.inc"
    .include "Data/Banks/Sprite/SPRBank07.inc"

    ; Background Banks

    .include "Data/Banks/Background/BKGBank00.inc"
    .include "Data/Banks/Background/BKGBank01.inc"
    .include "Data/Banks/Background/BKGBank02.inc"
    .include "Data/Banks/Background/BKGBank03.inc"
    .include "Data/Banks/Background/BKGBank04.inc"
    .include "Data/Banks/Background/BKGBank05.inc"
    .include "Data/Banks/Background/BKGBank06.inc"
    .include "Data/Banks/Background/BKGBank07.inc"