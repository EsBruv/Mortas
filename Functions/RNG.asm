; ================================================================
;   RNG.asm
;   Handles RNG
; 
;   Revision History:
;       Essam Erbab, June 2026: Created
;       Essam Erbab, November 2026: Updated
; ================================================================

; --------------------------------= Constants =--------------------------------

    RNG_LOOP_AMOUNT     = $08
    RNG_EXOR_VALUE      = $39

    RNG_SEED_1          = $C0
    RNG_SEED_2          = $DE

; --------------------------------= RNG =--------------------------------

    Initialize_RNG: ;_______+
        lda #RNG_SEED_1     ;
        sta RNGReserve      ;
        lda #RNG_SEED_2     ;
        sta RNGReserve + 1  ;
        ;                   ;
        rts                 ;
        ;

    RNG: ;______________________+
        ldx #RNG_LOOP_AMOUNT    ; Loop Amount
        lda RNGReserve          ;
        ;                       ;
        RNG_Loop: ;_____________+
            asl                 ;
            rol RNGReserve + 1  ;
            bcc RNG_Xor_Skip    ; Branch if !Carry
            eor #RNG_EXOR_VALUE ;
            ;                   ;
        RNG_Xor_Skip: ;_________+
            dex                 ; Decrement Loop Amount
            bne RNG_Loop        ; Branch if Loop Amount > 0
            ;                   ;
        RNG_Loop_End: ;_________+
            sta RNGReserve      ;
            cmp #RESET          ;
            rts                 ;
    ;