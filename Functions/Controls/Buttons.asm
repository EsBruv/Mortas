; ================================================================
;   Input.asm
;   Handles Button Functionality
;
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

; --------------------------------= Button Loop =--------------------------------
    Button: ;_______________________________________+
        ldx #RESET                                  ; Loop Amount
        ;                                           ;
        Button_Loop: ;______________________________+
            lda Button_Held_Timer, X                ; Checks Held Timer
            beq Button_Held                         ;
            ;                                       ;
            dec Button_Held_Timer, X                ;
            lsr Joypad                              ;
            ;                                       ;
            jmp Button_Loop_End                     ;
            ;                                       ;
            Button_Held: ;__________________________+
                lsr Joypad                          ; Shift CButtonFunction
                bcc Button_Loop_End                 ; Branch If Button Not Held
                ;                                   ;
                lda #RESET                          ; Pointer Clear
                sta PointerReserve                  ;
                sta PointerReserve+1                ;
                ;                                   ;
                txa                                 ; X -> A
                asl                                 ; Shift A Left
                tay                                 ; A -> Y
                ;                                   ;
                lda Buttons, Y                      ; Select Function 
                sta PointerReserve                  ;
                lda Buttons + 1, Y                  ;
                sta PointerReserve + 1              ;
                ;                                   ;
                jsr Button_Pointer_Jump             ;
                ;                                   ;
            Button_Loop_End: ;______________________+
                inx                                 ; X++
                cpx #BUTTON_AMOUNT                  ;
                bne Button_Loop                     ; Branch if X != 8
                ;                                   ;
                rts                                 ;
                ;                                   ;
        Button_Pointer_Jump: ;______________________+
            jmp (PointerReserve)                    ;
    ;

; --------------------------------= Function List =--------------------------------
    Buttons:
        .word A_Button
        .word B_Button
        .word Select_Button
        .word Start_Button

        .word Up_Button
        .word Down_Button
        .word Left_Button
        .word Right_Button

; --------------------------------= Functions =--------------------------------
    A_Button: ;_____________________________+
        ;                                   ;
        A_Button_Menu_State: ;______________+
            lda Menu_Control                ; Menu Open State
            and #MENU_OPEN                  ;
            beq A_Button_State_End          ;
                jsr Menu_A_Button           ;
                jmp A_Button_End            ;
                ;                           ;
            A_Button_State_End: ;___________+
            ;                               ;
        A_Button_End: ;_____________________+
            rts                             ;
    ;

    B_Button: ;_____________________________+
        ;                                   ;
        B_Button_Menu_State: ;______________+
            lda Menu_Control                ; Menu Open State
            and #MENU_OPEN                  ;
            beq B_Button_State_End          ;
                jsr Menu_B_Button           ;
                jmp B_Button_End            ;
                ;                           ;
            B_Button_State_End: ;___________+
            ;                               ;
        B_Button_End: ;_____________________+
            rts                             ;
    ;

    Select_Button: ;___________+
        lda #HELD_TIMER_AMOUNT          ; Resets Held Timer
        sta Button_Held_Timer, X        ;
        ;                               ;
        ; lda #BKG_SWAP_LATCH             ;
        ; sta BKG_Control                 ;
        ; FUNCTIONALITY                 ;
        ;                               ;
        Select_Button_End: ;___+
            rts                         ;
    ;

    Start_Button: ;____________    +
        lda #30                             ; Resets Held Timer
        sta Button_Held_Timer, X            ;
        ;                                   ;
        lda Menu_Control                    ;
        ora #MENU_NEXT                      ;
        sta Menu_Control                    ;
        ;                                   ;
        
                ;                           ;
        ; FUNCTIONALITY                     ;
        ;                                   ;
        Start_Button_End: ;____    +
            rts                             ;
    ;

    Up_Button: ;________________________________+
        ;                                       ;
        Up_Button_Menu_State: ;_________________+
            lda Menu_Control                    ; Menu Open State
            and #MENU_OPEN                      ;
            beq Up_Button_Movement_State        ;
                jsr Menu_Up_Button              ;
                jmp Up_Button_End               ;
                ;                               ;
        Up_Button_Movement_State: ;_____________+
            ;                                   ; If Not Stunned
            lda MovementDir                     ;
            ora #MOVEMENT_YVEL                  ;
            sta MovementDir                     ;
            ;                                   ;
            Up_Button_State_End: ;______________+
            ;                                   ;
        Up_Button_End: ;________________________+
            rts                                 ;
            ;                                   ;
    Down_Button: ;______________________________+
        ;                                       ;
        Down_Button_Menu_State: ;_______________+
            lda Menu_Control                    ; Menu Open State
            and #MENU_OPEN                      ;
            beq Down_Button_Movement_State      ;
                jsr Menu_Down_Button            ;
                jmp Down_Button_End             ;
                ;                               ;
        Down_Button_Movement_State: ;___________+
            ;                                   ; If Not Stunned
            lda MovementDir                     ;
            ora #MOVEMENT_YVEL                  ;
            ora #MOVEMENT_DOWN                  ;
            sta MovementDir                     ;
            ;                                   ;
            Down_Button_State_End: ;____________+
            ;                                   ;
        Down_Button_End: ;______________________+
            rts                                 ;
            ;                                   ;

    Left_Button: ;_____________+
        ;                               ;
        lda MovementDir                 ;
        ora #MOVEMENT_XVEL              ;
        sta MovementDir                 ;
        ;                               ;
        Left_Button_End: ;_____+
            rts                         ;
    ;

    Right_Button: ;____________+
        ;                               ;
        lda MovementDir                 ;
        ora #MOVEMENT_XVEL              ;
        ora #MOVEMENT_RIGHT             ;
        sta MovementDir                 ;
        ;                               ;
        Right_Button_End: ;____+
            rts                         ;
    ;