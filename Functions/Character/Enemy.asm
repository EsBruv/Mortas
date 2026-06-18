; ================================================================
;   Enemy.asm
;   Handles Enemy Logic
;
;   Revision History:
;       Essam Erbab, June 2026: Created
; ================================================================

; --------------------------------= Movement =--------------------------------
    AI_Movement: ;______________+
        jsr RNG                 ; Generate RNG Value
        ldx CCharacter          ;
        ;                       ;
        lda RNGReserve          ;
        and #$F0                ;
        sta MovementDir, X      ;
        ;                       ;
        rts                     ;
    ;