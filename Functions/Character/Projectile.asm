; ================================================================
;   Projectile.asm
;   Handles Projectile Logic
;
;   Revision History:
;       Essam Erbab, June 2026: Created
; ================================================================

    Projectile_Spawn: ;_____________________+
        txa                                 ;
        pha                                 ;
        ;                                   ;
        ldy CCharacter                      ; Current Character
        ;                                   ;
        cpy #PROJECTILE                     ; Projectile Check
        bcs Projectile_Spawn_End            ;
        ;                                   ;
        lda CCharacter                      ;
        clc                                 ;
        adc #PROJECTILE                     ;
        tax                                 ;
        ;                                   ;
        lda CharacterHealth, X              ;
        bne Projectile_Spawn_End            ; Branch If Projectile Exists
        ;                                   ;
            lda XPosition, Y                ; Current Character X Position
            sta Temp                        ;
            ;                               ;
            lda YPosition, Y                ; Current Character Y Position
            sta Temp + 1                    ;
            ;                               ;
            lda CharacterType, Y            ; Current Character Type
            sta Temp + 2                    ;
            ;                               ;
            lda Previous_MovementDir, Y     ;
            sta Temp + 3                    ;
            ;                               ;
            jsr Projectile_Direction        ;
        ;                                   ;
            lda Temp                        ;
            sta XPosition, X                ; Projectile X Position
            ;                               ;
            lda Temp + 1                    ;
            sta YPosition, X                ; Projectile Y Position
            ;                               ;
            lda Temp + 2                    ;
            sta CharacterType, X            ; Projectile Type
            ;                               ;
            lda #$02                        ;
            sta CharacterHealth, X          ; Projectile Health
        ;                                   ;
        Projectile_Spawn_End: ;_____________+
            pla                             ;
            tax                             ;
            ;                               ;
            rts                             ;
    ;


    Projectile_Direction: ;_____________________+
        lda Temp + 3                            ;
        and #MOVEMENT_PRIMARY                   ;
        beq Projectile_Y                        ;
        ;                                       ;
        Projectile_X: ;_________________________+
            lda Temp + 3                        ;
            and #MOVEMENT_RIGHT                 ;
            beq Projectile_Left                 ;
            ;                                   ;
            Projectile_Right: ;_________________+
                lda #MOVEMENT_XVEL              ;
                ora #MOVEMENT_PRIMARY           ;
                ora #MOVEMENT_RIGHT             ;
                sta MovementDir, X              ;
                jmp Projectile_Direction_End    ;
                ;                               ;
            Projectile_Left: ;__________________+
                lda #MOVEMENT_XVEL              ;
                ora #MOVEMENT_PRIMARY           ;
                sta MovementDir, X              ;
                jmp Projectile_Direction_End    ;
                ;                               ;
        Projectile_Y: ;_________________________+
            lda Temp + 3                        ;
            and #MOVEMENT_DOWN                  ;
            beq Projectile_Up                   ;
            ;                                   ;
            Projectile_Down: ;__________________+
                lda #MOVEMENT_YVEL              ;
                ora #MOVEMENT_DOWN              ;
                sta MovementDir, X              ;
                jmp Projectile_Direction_End    ;
                ;                               ;
            ;                                   ;
            Projectile_Up: ;____________________+
                lda #MOVEMENT_YVEL              ;
                sta MovementDir, X              ;
                jmp Projectile_Direction_End    ;
                ;                               ;
        Projectile_Direction_End: ;_____________+
            rts                                 ;
    ;