; ================================================================
;   PRGBank00.asm
;   Handles Program Bank 00
; 
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

.segment "BANK_00"
    .include "../../Palette.inc"
    .include "../../Tiles/Meta.inc"
    .include "../../Tiles/Attributes.inc"
    .include "../../Tiles/Collision.inc"
    .include "../../Tiles/Tiles.inc"
    
    .include "../../Maps/Background/Map00.inc"
    .include "../../Maps/Background/Map01.inc"
    .include "../../Maps/Background/Map10.inc"
    .include "../../Maps/Background/Map11.inc"