; ================================================================================
;   Movement.asm
;   Handle Character Movement
;   
;   Revision History:
;       Essam Erbab, May 2026: Created
; ================================================================================

; --------------------------------= Calculations =--------------------------------
    Movement: ;_____________________________+
        lda BKG_Control                     ; Background Control Check
        bne Movement_Clear                  ;
        ;                                   ;
        MoveX: ;____________________________+
            ldx CCharacter                  ;
            lda MovementDir, X              ; X Velocity Check
            and #MOVEMENT_XVEL              ;
            beq MoveY                       ; Branch if X Velocity = 0
            ;                               ;
            jsr Move_X                      ; Jump to Subroutine
            ;                               ;
        MoveY: ;____________________________+
            ldx CCharacter                  ;
            lda MovementDir, X              ; Y Velocity Check
            and #MOVEMENT_YVEL              ;
            beq Movement_Clear              ; Branch if Y Velocity = 0
            ;                               ;
            jsr Move_Y                      ; Jump to Subroutine
            ;                               ;
        Movement_Clear: ;___________________+
            jsr Primary_Direction           ;
            ;                               ;
            lda #RESET                      ; Reset Variables
            tax                             ; A -> X
            tay                             ; A -> Y
            ;                               ;
        Movement_End: ;_____________________+
            rts                             ;
;

; --------------------------------= Move =--------------------------------
    Move_X: ;___________________________________+
        ldx CCharacter                          ;
        lda MovementDir, X                      ; Direction Check
        and #MOVEMENT_RIGHT                     ;
        bne Move_X_Right                        ; Branch if Right
        ;                                       ;
        Move_X_Left: ;__________________________+
            ;                                   ;
            Move_X_Left_Speed: ;________________+
                lda CharacterType, X            ;
                tay                             ;
                ;                               ;
                lda XPosition, X                ;
                sec                             ;
                sbc Character_Speed, Y          ;
                ;                               ;
                cpx #PROJECTILE                 ; Projectile Check
                bcc Move_X_Left_Speed_Store     ;
                ;                               ;
                clc                             ;
                sbc Character_Speed, Y          ;
                ;                               ;
            Move_X_Left_Speed_Store: ;__________+
                sta XPosition, X                ;
            ;                                   ;
            jsr Wall_Collision_Top_Left         ; Top Left Collision Check
            sta Temp + 8                        ;
            ;                                   ;
            jsr Wall_Collision_Bottom_Left      ; Bottom Left Collision Check
            sta Temp + 9                        ;
            ;                                   ;
            jmp Move_X_Collision                ;
            ;                                   ;
        Move_X_Right: ;_________________________+
            ;                                   ;
            Move_X_Right_Speed: ;_______________+
                lda CharacterType, X            ;
                tay                             ;
                ;                               ;
                lda XPosition, X                ;
                clc                             ;
                adc Character_Speed, Y          ;
                ;                               ;
                cpx #PROJECTILE                 ; Projectile Check
                bcc Move_X_Right_Speed_Store    ;
                ;                               ;
                adc Character_Speed, Y          ;
                ;                               ;
            Move_X_Right_Speed_Store: ;_________+
                sta XPosition, X                ;
            ;                                   ;
            jsr Wall_Collision_Top_Right        ; Top Right Collision Check
            sta Temp + 8                        ;
            ;                                   ;
            jsr Wall_Collision_Bottom_Right     ; Bottom Right Collision Check
            sta Temp + 9                        ;
            ;                                   ;
            jmp Move_X_Collision                ;
        ;

    Move_Y: ;___________________________________+
        ldx CCharacter                          ;
        lda MovementDir, X                      ; Direction Check
        and #MOVEMENT_DOWN                      ;
        bne Move_Y_Down                         ; Branch if Down
        ;                                       ;
        Move_Y_Up: ;____________________________+
            ;                                   ;
            Move_Y_Up_Speed: ;__________________+
                lda CharacterType, X            ;
                tay                             ;
                ;                               ;
                lda YPosition, X                ;
                sec                             ;
                sbc Character_Speed, Y          ;
                ;                               ;
                cpx #PROJECTILE                 ; Projectile Check
                bcc Move_Y_Up_Speed_Store       ;
                ;                               ;
                clc
                sbc Character_Speed, Y          ;
                ;                               ;
            Move_Y_Up_Speed_Store: ;____________+
                sta YPosition, X                ;
            ;                                   ;
            jsr Wall_Collision_Top_Left         ; Top Left Collision Check
            sta Temp + 8                        ;
            ;                                   ;
            jsr Wall_Collision_Top_Right        ; Top Right Collision Check
            sta Temp + 9                        ;
            ;                                   ;
            jmp Move_Y_Collision                ;
            ;                                   ;
        Move_Y_Down: ;__________________________+
            ;                                   ;
            Move_Y_Down_Speed: ;________________+
                lda CharacterType, X            ;
                tay                             ;
                ;                               ;
                lda YPosition, X                ;
                clc                             ;
                adc Character_Speed, Y          ;
                ;                               ;
                cpx #PROJECTILE                 ; Projectile Check
                bcc Move_Y_Down_Speed_Store     ;
                ;                               ;
                adc Character_Speed, Y          ;
                ;                               ;
            Move_Y_Down_Speed_Store: ;__________+
                sta YPosition, X                ;
            ;                                   ;
            jsr Wall_Collision_Bottom_Left      ; Bottom Left Collision Check
            sta Temp + 8                        ;
            ;                                   ;
            jsr Wall_Collision_Bottom_Right     ; Bottom Right Collision Check
            sta Temp + 9                        ;
            ;                                   ;
            jmp Move_Y_Collision                ;
;

; --------------------------------= Collision =--------------------------------

    Move_X_Collision: ;_________________+ X Collision Controller
        lda Temp + 8                    ;
        cmp #COLLISION_SOLID            ;
        beq Move_X_Collision_Solid      ; Branch if Tile == SOLID
        ;                               ;
        lda Temp + 9                    ;
        cmp #COLLISION_SOLID            ;
        beq Move_X_Collision_Solid      ; Branch if Tile == SOLID
        ;                               ;
        lda Temp + 8                    ;
        cmp #COLLISION_SHIFT            ; Branch if Tile == SHIFT
        bne Move_X_Collision_Air        ;
        ;                               ;
        lda Temp + 9                    ;
        cmp #COLLISION_SHIFT            ; Branch if Tile == SHIFT
        bne Move_X_Collision_Air        ;
        ;                               ;
        jmp Move_X_Collision_Shift      ;
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
            lda CCharacter              ;
            bne Move_X_Collision_Solid  ;
            ;                           ;
            jsr Move_X_Shift            ;
            rts                         ;
            ;                           ;
        Move_X_Collision_Air: ;_________+
            rts                         ;
    ;

    Move_Y_Collision: ;_________________+
        lda Temp + 8                    ;
        cmp #COLLISION_SOLID            ;
        beq Move_Y_Collision_Solid      ; Branch if Tile == SOLID
        ;                               ;
        lda Temp + 9                    ;
        cmp #COLLISION_SOLID            ;
        beq Move_Y_Collision_Solid      ; Branch if Tile == SOLID
        ;                               ;
        lda Temp + 8                    ;
        cmp #COLLISION_SHIFT            ; Branch if Tile == SHIFT
        bne Move_Y_Collision_Air        ;
        ;                               ;
        lda Temp + 9                    ;
        cmp #COLLISION_SHIFT            ; Branch if Tile == SHIFT
        bne Move_Y_Collision_Air        ;
        ;                               ;
        jmp Move_Y_Collision_Shift      ;
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
            lda CCharacter              ;
            bne Move_Y_Collision_Solid  ;
            ;                           ;
            jsr Move_Y_Shift            ;
            rts                         ;
            ;                           ;
        Move_Y_Collision_Air: ;_________+
            rts                         ;
;

; --------------------------------= Return =--------------------------------

    Move_X_Return: ;____________________+
        ldx CCharacter                  ;
        ;                               ;
        cpx #PROJECTILE                 ; Projectile Check
        bcs Move_X_Projectile_Return    ;
        ;                               ;
        lda MovementDir, X              ; Direction Check
        and #MOVEMENT_RIGHT             ;
        bne Move_X_Right_Return         ; Branch if Right
        ;                               ;
        Move_X_Left_Return: ;___________+
            inc XPosition, X            ; Increment XPosition
            inc XPosition, X            ;
            rts                         ;
            ;                           ;
        Move_X_Right_Return: ;__________+
            dec XPosition, X            ; Decrement XPosition
            dec XPosition, X            ;
            rts                         ;
            ;                           ;
        Move_X_Projectile_Return: ;_____+
            lda #RESET                  ;
            sta CharacterHealth, X      ;
            rts                         ;
    ;                                   ;

    Move_Y_Return: ;____________________+
        ldx CCharacter                  ;
        ;                               ;
        cpx #PROJECTILE                 ; Projectile Check
        bcs Move_Y_Projectile_Return    ;
        ;                               ;
        lda MovementDir, X              ; Direction Check
        and #MOVEMENT_DOWN              ;
        bne Move_Y_Down_Return          ; Branch if Right
        ;                               ;
        Move_Y_Up_Return: ;_____________+
            inc YPosition, X            ; Increment YPosition
            inc YPosition, X            ;
            rts                         ;
            ;                           ;
        Move_Y_Down_Return: ;___________+
            dec YPosition, X            ; Decrement YPosition
            dec YPosition, X            ;
            rts                         ;
            ;                           ;
        Move_Y_Projectile_Return: ;_____+
            lda #RESET                  ;
            sta CharacterHealth, X      ;
            rts                         ;
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
            lda BKG_Index               ;
            sec                         ;
            sbc #SCREEN_X_INCREMENT     ;
            sta BKG_Index               ;
            ;                           ;
            jsr Selection               ;
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
            lda BKG_Index               ;
            clc                         ;
            adc #SCREEN_X_INCREMENT     ;
            sta BKG_Index               ;
            ;                           ;
            jsr Selection               ;
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
            lda CamYPosition            ;
            sec                         ;
            sbc #SHIFT_Y_OFFSET         ;
            sta CamYPosition            ;
            ;                           ;
            lda BKG_Index               ;
            sec                         ;
            sbc #SCREEN_Y_INCREMENT     ;
            sta BKG_Index               ;
            ;                           ;
            jsr Selection               ;
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
            lda BKG_Index               ;
            clc                         ;
            adc #SCREEN_Y_INCREMENT     ;
            sta BKG_Index               ;
            ;                           ;
            jsr Selection               ;
            ;                           ;
            rts                         ;
;

; --------------------------------= Primary Direction =--------------------------------

    Primary_Direction: ;____________________+
        ldx CCharacter                      ;
        ;                                   ;
        cpx #PROJECTILE                     ; Projectile Check
        bcs Primary_Direction_End           ; Branch If Projectile
        ;                                   ;
        lda MovementDir, X                  ;
        and #MOVEMENT_VELOCITY              ;
        ;                                   ;
        cmp #MOVEMENT_YVEL                  ;
        beq Primary_Direction_Y             ;
        ;                                   ;
        cmp #MOVEMENT_XVEL                  ;
        beq Primary_Direction_X             ;
        ;                                   ;
        cmp #MOVEMENT_VELOCITY              ;
        bne Primary_Direction_None          ;
        ;                                   ;
        Primary_Direction_X: ;______________+
            lda MovementDir, X              ;
            ora #MOVEMENT_PRIMARY           ;
            sta MovementDir, X              ;
            ;                               ;
            jmp Primary_Direction_Store     ;
            ;                               ;
        Primary_Direction_Y: ;______________+
            lda MovementDir, X              ;
            ora #MOVEMENT_PRIMARY           ;
            eor #MOVEMENT_PRIMARY           ;
            sta MovementDir, X              ;
            ;                               ;
            jmp Primary_Direction_Store     ;
            ;                               ;
        Primary_Direction_None: ;___________+
            lda Previous_MovementDir, X     ;
            sta Previous_MovementDir, X     ;
            jmp Primary_Direction_Clear     ;
            ;                               ;
        Primary_Direction_Store: ;__________+
            lda MovementDir, X              ;
            and #MOVEMENT_DIRECTION         ;
            sta Previous_MovementDir, X     ;
            ;                               ;
        Primary_Direction_Clear: ;__________+
            lda #RESET                      ;
            sta MovementDir, X              ;
            ;                               ;
        Primary_Direction_End: ;____________+
            rts                             ;
    ;