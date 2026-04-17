; ================================================================
;   Clock.asm
;   Handles Clock Timing
; 
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

    Clock: ;________________________________________+
        inc Counter                                 ; Increments FPS Counter
        ;                                           ;
        lda Counter                                 ; Checks if FPS Counter >= 120 (60fps * 2)
        cmp #FPS                                    ;
        bne Clock_End                               ; Ends if FPS Counter < 120
        ;                                           ;
        lda #RESET                                  ; Resets FPS Counter
        sta Counter                                 ;
        ;                                           ;
        Second_Increment: ;_________________________+
            inc SecondCounter                       ; Increments Second Counter
            ;                                       ;
            lda SecondCounter                       ; Second Digit Overflow Check
            and #$0F                                ;
            cmp #COUNTER_DIGIT_MAX                  ;
            bcc Clock_End                           ; Branch If Second Counter < 10
            ;                                       ;
            lda SecondCounter                       ; Second Counter - 10
            sbc #COUNTER_DIGIT_MAX                  ;
            clc                                     ;
            adc #COUNTER_DIGIT_INC                  ; Second Counter + 16
            sta SecondCounter                       ;
            ;                                       ;
            lda SecondCounter                       ; Second Minute Overflow Check
            cmp #COUNTER_OVERFLOW                   ;
            bne Clock_End                           ; Branch If Second Counter < 60
            ;                                       ;
            lda #RESET                              ; Reset Second Counter
            sta SecondCounter                       ;
            ;                                       ;
        Minute_Increment: ;_________________________+
            inc MinuteCounter                       ; Increment Minute Counter
            ;                                       ;
            lda MinuteCounter                       ; Minute Digit Overflow Check
            and #$0F                                ;
            cmp #COUNTER_DIGIT_MAX                  ;
            bcc Clock_End                           ; Branch If Minute Counter < 10
            ;                                       ;
            lda MinuteCounter                       ; Minute Counter - 10
            sbc #COUNTER_DIGIT_MAX                  ;
            clc                                     ;
            adc #COUNTER_DIGIT_INC                  ; Minute Counter + 16
            sta MinuteCounter                       ;
            ;                                       ;
            lda MinuteCounter                       ; Minute Hour Overflow Check
            cmp #COUNTER_OVERFLOW                   ;
            bne Clock_End                           ; Branch If Minute Counter < 60
            ;                                       ;
            lda #RESET                              ; Reset Minute Counter
            sta MinuteCounter                       ;
            ;                                       ;
        Clock_End: ;________________________________+
            rts                                     ;
;