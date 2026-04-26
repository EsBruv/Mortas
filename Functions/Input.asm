; ================================================================
;   Input.asm
;   Handles Controller Inputs
;
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

; --------------------------------= Input =--------------------------------

    Read_Buttons: ;_________________+
        lda #RESET                  ; Clear Joypad
        sta Joypad                  ;
        ;                           ;
        lda #PRESSED                ; Joypad Read High
        sta JOY1                    ;
        lda #RESET                  ; Joypad Read Low
        sta JOY1                    ;
        ;                           ;
        ldx #$08                    ; Loop Amount
        Read_Buttons_Loop: ;________+
            clc                     ; Clear Carry
            lda JOY1                ; Joy1 && 01
            and #PRESSED            ;
            lsr                     ; bit 0 -> C
            ror Joypad              ; C - bit 7
            ;                       ;
            dex                     ; Decrement X
            bne Read_Buttons_Loop   ; Branch if X != 0
            ;                       ;
            lda Joypad              ; Reject $FF Pulse
            cmp #MAX                ;
            bne Read_Buttons_End    ; Branch If Joypad != FF
            ;                       ;
            lda #RESET              ; 0 -> Joypad
            sta Joypad              ;
            ;                       ;
        Read_Buttons_End: ;_________+
            rts                     ; Loop Exit
    ;