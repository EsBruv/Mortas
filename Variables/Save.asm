; ================================================================
;   Save.asm
;   Outlines Save Registers
;
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

.segment "SAVERAM"

Validation: .res 6          ;

Screen_Main: .res 64       ;
Screen_X: .res 64          ;
Screen_Y: .res 64          ;
Screen_UI: .res 64         ;