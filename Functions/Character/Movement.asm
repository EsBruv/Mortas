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
            beq MoveY                   ; Branch if X Velocity = 0
            ;                           ;
            jsr Move_X                  ; Jump to Subroutine
            ;                           ;
        MoveY: ;________________________+
            lda MovementDir             ; Y Velocity Check
            and #MOVEMENT_YVEL          ;
            beq Movement_End            ; Branch if Y Velocity = 0
            ;                           ;
            jsr Move_Y                  ; Jump to Subroutine
            ;                           ;
        Movement_End: ;_________________+
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
            jsr Wall_Collision_Top_Left         ; Top Left Collision Check
            bne Move_X_Collision                ;
            ;                                   ;
            jsr Wall_Collision_Bottom_Left      ; Bottom Left Collision Check
            bne Move_X_Collision                ;
            ;                                   ;
            rts                                 ;
            ;                                   ;
        Move_X_Right: ;_________________________+
            inc XPosition                       ; Increment XPosition
            inc XPosition                       ;
            ;                                   ;
            jsr Wall_Collision_Top_Right        ; Top Right Collision Check
            bne Move_X_Collision                ;
            ;                                   ;
            jsr Wall_Collision_Bottom_Right     ; Bottom Right Collision Check
            bne Move_X_Collision                ;
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
            jsr Wall_Collision_Top_Left         ; Top Left Collision Check
            bne Move_Y_Collision                ;
            ;                                   ;
            jsr Wall_Collision_Top_Right        ; Top Right Collision Check
            bne Move_Y_Collision                ;
            ;                                   ;
            rts                                 ;
            ;                                   ;
        Move_Y_Down: ;__________________________+
            inc YPosition                       ; Increment YPosition
            inc YPosition                       ;
            ;                                   ;
            jsr Wall_Collision_Bottom_Left      ; Bottom Left Collision Check
            bne Move_Y_Collision                ;
            ;                                   ;
            jsr Wall_Collision_Bottom_Right     ; Bottom Right Collision Check
            bne Move_Y_Collision                ;
            ;                                   ;
            rts                                 ;
;

; --------------------------------= Collision =--------------------------------

    Move_X_Collision: ;_________________+ X Collision Controller
        cmp #COLLISION_SOLID            ;
        beq Move_X_Collision_Solid      ; Branch if Tile == SOLID
        ;                               ;
        cmp #COLLISION_SHIFT            ; Branch if Tile == SHIFT
        beq Move_X_Collision_Shift      ;
        ;                               ;
        Move_X_Collision_Locked: ;______+ Locked Collision Controller
            ; if locked, collide        ;
            jmp Move_X_Collision_Solid  ; 
            ;                           ;
            ; if Not Locked, Shift      ;
            jmp Move_X_Collision_Shift  ;
            ;                           ;
        Move_X_Collision_Solid: ;_______+
            jsr Move_X_Return           ;
            rts                         ;
            ;                           ;
        Move_X_Collision_Shift: ;_______+
            jsr Move_X_Shift            ;
            rts                         ;

    Move_Y_Collision: ;_________________+
        cmp #COLLISION_SOLID            ;
        beq Move_Y_Collision_Solid      ;
        ;                               ;
        cmp #COLLISION_SHIFT            ;
        beq Move_Y_Collision_Shift      ;
        ;                               ;
        Move_Y_Collision_Locked: ;______+
            ; if locked, collide        ;
            jmp Move_Y_Collision_Solid  ;
            ;                           ;
            ; if Not Locked, Shift      ;
            jmp Move_Y_Collision_Shift  ;
        ;                               ;
        Move_Y_Collision_Solid: ;_______+
            jsr Move_Y_Return           ;
            rts                         ;
            ;                           ;
        Move_Y_Collision_Shift: ;_______+
            jsr Move_Y_Shift            ;
            rts                         ;

; --------------------------------= Return =--------------------------------

    Move_X_Return: ;________________________+
        lda MovementDir                     ; Direction Check
        and #MOVEMENT_RIGHT                 ;
        bne Move_X_Right_Return             ; Branch if Right
        ;                                   ;
        Move_X_Left_Return: ;_______________+
            inc XPosition                   ; Increment XPosition
            inc XPosition                   ;
            rts                             ;
            ;                               ;
        Move_X_Right_Return: ;______________+
            dec XPosition                   ; Decrement XPosition
            dec XPosition                   ;
            rts                             ;
    ;                                       ;

    Move_Y_Return: ;________________________+
        lda MovementDir                     ; Direction Check
        and #MOVEMENT_DOWN                  ;
        bne Move_Y_Down_Return              ; Branch if Right
        ;                                   ;
        Move_Y_Up_Return: ;_________________+
            inc YPosition                   ; Increment YPosition
            inc YPosition                   ;
            rts                             ;
            ;                               ;
        Move_Y_Down_Return: ;_______________+
            dec YPosition                   ; Decrement YPosition
            dec YPosition                   ;
            rts                             ;
    ;

; --------------------------------= Shift =--------------------------------
    Move_X_Shift: ;_____________________+
        lda XPosition                   ; Shift Left Check
        cmp #SCREEN_LEFT                ;
        bcc Move_X_Shift_Left           ;
        ;                               ;
        cmp #SCREEN_RIGHT               ; Shift Right Check
        bcs Move_X_Shift_Right          ;
        ;                               ;
        Move_X_Shift_Center: ;__________+ Shift Center
            ;                           ;
            rts                         ;
            ;                           ;
        Move_X_Shift_Left: ;____________+ Shift Left
            lda #BKG_SHIFT_LATCH        ;
            ora #BKG_SWAP_LATCH         ;
            ora #SCREEN_2               ;
            sta BKG_Control             ;
            ;                           ;
            rts                         ;
            ;                           ;
        Move_X_Shift_Right: ;___________+ Shift Right
            lda #BKG_SHIFT_LATCH        ;
            ora #BKG_SWAP_LATCH         ;
            ora #BKG_SHIFT_DIRECTION    ;
            ora #SCREEN_2               ;
            sta BKG_Control             ;
            ;                           ;
            rts                         ;
        ;

    Move_Y_Shift: ;_____________________+
        lda YPosition                   ; Shift Up Check
        cmp #SCREEN_UP                  ;
        bcc Move_Y_Shift_Up             ; Branch if Yposition < $09
        ;                               ;
        cmp #SCREEN_DOWN                ; Shift Down Check
        bcs Move_Y_Shift_Down           ; Branch if Yposition > $E0
        ;                               ;
        Move_Y_Shift_Center: ;__________+ Shift Center
            ;                           ;
            rts                         ;
            ;                           ;
        Move_Y_Shift_Up: ;______________+ Shift Up
            lda #BKG_SHIFT_LATCH        ;
            ora #BKG_SWAP_LATCH         ;
            ora #SCREEN_3               ;
            sta BKG_Control             ;
            ;                           ;
            rts                         ;
            ;                           ;
        Move_Y_Shift_Down: ;____________+ Shift Down
            lda #BKG_SHIFT_LATCH        ;
            ora #BKG_SWAP_LATCH         ;
            ora #BKG_SHIFT_DIRECTION    ;
            ora #SCREEN_3               ;
            sta BKG_Control             ;
            ;                           ;
            rts                         ;
;