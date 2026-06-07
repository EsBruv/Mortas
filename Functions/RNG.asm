; ================================================================
;   RNG.asm
;   Handles RNG
; 
;   Revision History:
;       Essam Erbab, June 2026: Created
; ================================================================

;--------= RNG =--------------------------------------------------------
    RNG: ;______________________+
        ldx #$08                ; Loop Amount
        lda RNGReserve          ;
        ;                       ;
        RNG_Loop: ;_____________+
            asl                 ;
            rol RNGReserve + 1  ;
            bcc RNG_Xor_Skip    ; Branch if !Carry
            eor #$39            ;
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