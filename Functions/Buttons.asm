; ================================================================
;   Input.asm
;   Handles Button Functionality
;
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

; --------------------------------= Button Loop =--------------------------------
    Button_Function: ;______________________________+
        ldx #RESET                                  ; Loop Amount
        ;                                           ;
        Button_Function_Loop: ;_____________________+
            lda Button_Held_Timer, X                ; Checks Held Timer
            beq Button_Held                         ;
            ;                                       ;
            dec Button_Held_Timer, X                ;
            lsr Joypad                              ;
            ;                                       ;
            jmp Button_Function_Loop_End            ;
            ;                                       ;
            Button_Held: ;__________________________+
                lsr Joypad                          ; Shift CButtonFunction
                bcc Button_Function_Loop_End        ; Branch If Button Not Held
                ;                                   ;
                lda #RESET                          ; Pointer Clear
                sta PointerReserve                  ;
                sta PointerReserve+1                ;
                ;                                   ;
                txa                                 ; X -> A
                asl                                 ; Shift A Left
                tay                                 ; A -> Y
                ;                                   ;
                lda Button_Functions, Y             ; Select Function 
                sta PointerReserve                  ;
                lda Button_Functions + 1, Y         ;
                sta PointerReserve + 1              ;
                ;                                   ;
                jsr Button_Function_Pointer_Jump    ;
                ;                                   ;
            Button_Function_Loop_End: ;_____________+
                inx                                 ; X++
                cpx #BUTTON_AMOUNT                  ;
                bne Button_Function_Loop            ; Branch if X != 8
                ;                                   ;
                rts                                 ;
                ;                                   ;
        Button_Function_Pointer_Jump: ;_____________+
            jmp (PointerReserve)                    ;
    ;

; --------------------------------= Function List =--------------------------------
    Button_Functions:
        .word A_Button_Function
        .word B_Button_Function
        .word Select_Button_Function
        .word Start_Button_Function

        .word Up_Button_Function
        .word Down_Button_Function
        .word Left_Button_Function
        .word Right_Button_Function

; --------------------------------= Functions =--------------------------------
    A_Button_Function: ;________________+
        lda #HELD_TIMER_AMOUNT          ; Resets Held Timer
        sta Button_Held_Timer, X        ;
        ;                               ;
        ; FUNCTIONALITY                 ;
        ;                               ;
        A_Button_Function_End: ;________+
            rts                         ;
    ;

    B_Button_Function: ;________________+
        lda #HELD_TIMER_AMOUNT          ; Resets Held Timer
        sta Button_Held_Timer, X        ;
        ;                               ;
        ; FUNCTIONALITY                 ;
        ;                               ;
        B_Button_Function_End: ;________+
            rts                         ;
    ;

    Select_Button_Function: ;___________+
        lda #HELD_TIMER_AMOUNT          ; Resets Held Timer
        sta Button_Held_Timer, X        ;
        ;                               ;
        ; FUNCTIONALITY                 ;
        ;                               ;
        Select_Button_Function_End: ;___+
            rts                         ;
    ;

    Start_Button_Function: ;____________+
        lda #HELD_TIMER_AMOUNT          ; Resets Held Timer
        sta Button_Held_Timer, X        ;
        ;                               ;
        ; FUNCTIONALITY                 ;
        ;                               ;
        Start_Button_Function_End: ;____+
            rts                         ;
    ;

    Up_Button_Function: ;_______________+
        lda #HELD_TIMER_AMOUNT          ; Resets Held Timer
        sta Button_Held_Timer, X        ;
        ;                               ;
        ; FUNCTIONALITY                 ;
        ;                               ;
        Up_Button_Function_End: ;_______+
            rts                         ;
    ;

    Down_Button_Function: ;_____________+
        lda #HELD_TIMER_AMOUNT          ; Resets Held Timer
        sta Button_Held_Timer, X        ;
        ;                               ;
        ; FUNCTIONALITY                 ;
        ;                               ;
        Down_Button_Function_End: ;_____+
            rts                         ;
    ;

    Left_Button_Function: ;_____________+
        lda #HELD_TIMER_AMOUNT          ; Resets Held Timer
        sta Button_Held_Timer, X        ;
        ;                               ;
        ; FUNCTIONALITY                 ;
        ;                               ;
        Left_Button_Function_End: ;_____+
            rts                         ;
    ;

    Right_Button_Function: ;____________+
        lda #HELD_TIMER_AMOUNT          ; Resets Held Timer
        sta Button_Held_Timer, X        ;
        ;                               ;
        ; FUNCTIONALITY                 ;
        ;                               ;
        Right_Button_Function_End: ;____+
            rts                         ;
    ;