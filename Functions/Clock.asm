; ================================================================
;   Clock.asm
;   Handles Clock Timing
; 
;   Revision History:
;       Essam Erbab, April 2026: Created
;       Essam Erbab, November 2026: Updated
; ================================================================

; --------------------------------= Constants =--------------------------------

    ; RESET                 = $00 (Global.asm)

    NMI_FLAG                = $80

    FPS                     = $3C   ; 60 FPS
    FRAME_QUARTER_ONE       = $0F   ; Frame 15 (1/4)
    FRAME_HALF              = $1E   ; Frame 30 (1/2)
    FRAME_QUARTER_THREE     = $2D   ; Frame 45 (3/4)

    COUNTER_DIGIT_MAX       = $0A
    COUNTER_DIGIT_CHECK     = $0F
    COUNTER_DIGIT_INC       = $10
    COUNTER_OVERFLOW        = $60

; --------------------------------= Clock =--------------------------------

    Clock: ;________________________________________+
        inc Counter                                 ; Increments FPS Counter
        ;                                           ;
        lda Counter                                 ; Checks if FPS Counter >= 60
        and #MAX - NMI_FLAG                         ;
        cmp #FPS                                    ;
        bne Clock_End                               ; Ends if FPS Counter < 60
        ;                                           ;
        lda #RESET                                  ; Resets FPS Counter
        sta Counter                                 ;
        ;                                           ;
        Second_Increment: ;_________________________+
            inc SecondCounter                       ; Increments Second Counter
            ;                                       ;
            lda SecondCounter                       ; Second Digit Overflow Check
            and #COUNTER_DIGIT_CHECK                ;
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
            and #COUNTER_DIGIT_CHECK                ;
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