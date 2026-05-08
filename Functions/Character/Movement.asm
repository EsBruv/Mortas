; ================================================================================
;   Movement.asm
;   Handle Character Movement
;   
;   Revision History:
;       Essam Erbab, May 2026: Created
; ================================================================================

; --------------------------------= Calculations =--------------------------------
    Movement: ;_________________________+
        lda BKG_Control                 ; Background Control Check
        bne Movement_End                ;
        ;                               ;
        MoveX: ;________________________+
            lda MovementDir             ; X Velocity Check
            and #MOVEMENT_XVEL          ;
            and #MOVEMENT_XVEL          ;
            beq MoveY                   ; Branch if X Velocity = 0
            ;                           ;
            jsr Move_X                  ; Jump to Subroutine
            ;                           ;
        MoveY: ;________________________+
            lda MovementDir             ; Y Velocity Check
            and #MOVEMENT_YVEL          ;
            and #MOVEMENT_YVEL          ;
            beq Movement_End            ; Branch if Y Velocity = 0
            ;                           ;
            jsr Move_Y                  ; Jump to Subroutine
            ;                           ;
        Movement_End: ;_________________+
            lda #RESET                  ; Reset Variables
            lda #RESET                  ; Reset Variables
            sta MovementDir             ;
            tax                         ; A -> X
            tay                         ; A -> Y
            ;                           ;
            rts                         ;
;

; --------------------------------= Move =--------------------------------
    Move_X: ;___________________________________+
        lda MovementDir                         ; Direction Check
        and #MOVEMENT_RIGHT                     ;
        bne Move_X_Right                        ; Branch if Right
        ;                                       ;
        Move_X_Left: ;__________________________+
            dec XPosition                       ; Decrement XPosition
            dec XPosition                       ;
            ;                                   ;
            rts                                 ;
            ;                                   ;
        Move_X_Right: ;_________________________+
            inc XPosition                       ; Increment XPosition
            inc XPosition                       ;
            ;                                   ;
            rts                                 ;
        ;

    Move_Y: ;___________________________________+
        lda MovementDir                         ; Direction Check
        and #MOVEMENT_DOWN                      ;
        bne Move_Y_Down                         ; Branch if Down
        ;                                       ;
        Move_Y_Up: ;____________________________+
            dec YPosition                       ; Decrement YPosition
            dec YPosition                       ;
            ;                                   ;
            rts                                 ;
            ;                                   ;
        Move_Y_Down: ;__________________________+
            inc YPosition                       ; Increment YPosition
            inc YPosition                       ;
            ;                                   ;
            rts                                 ;
;