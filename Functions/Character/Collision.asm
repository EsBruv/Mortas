; ================================================================
;   Collision.asm
;   Handles Character Collision
;
;   Revision History:
;       Essam Erbab, June 2026: Created
; ================================================================

    Dynamic_Collision: ;____________________+
        pha                                 ;
        txa                                 ;
        pha                                 ;
        tya                                 ;
        pha                                 ;
        ;                                   ;
        ldx CCharacter                      ;
        ldy #ENTITY_AMOUNT                  ;
        ;                                   ;
        Dynamic_Collision_Loop: ;___________+
            lda CharacterHealth, Y          ;
            beq Dynamic_Collision_Loop_End  ;
            ;                               ;
            cpy CCharacter                  ; Current Character Check
            beq Dynamic_Collision_Loop_End  ; Branch If Current Character
            ;                               ;
            lda XPosition, X                ; Collided Right
            clc                             ;
            adc #CHARACTER_WIDTH            ;
            cmp XPosition, Y                ; Collider Left
            bcc Dynamic_Collision_Loop_End  ; Branch If Collider Left > Collided Right
            ;                               ;
            lda XPosition, Y                ; Collider Right
            clc                             ;
            adc #CHARACTER_WIDTH            ;
            cmp XPosition, X                ; Collided Left
            bcc Dynamic_Collision_Loop_End  ; Branch If Collider Right < Collided Left
            ;                               ;
            lda YPosition, X                ; Collided Up
            clc                             ;
            adc #CHARACTER_HEIGHT           ;
            cmp YPosition, Y                ; Collider Down
            bcc Dynamic_Collision_Loop_End  ; Branch If Collider Down > Collided Up
            ;                               ;
            lda YPosition, Y                ; Collider Down
            clc                             ;
            adc #CHARACTER_HEIGHT           ;
            cmp YPosition, X                ; Collided Down
            bcc Dynamic_Collision_Loop_End  ; Branch If Collided Down < Collider Up
                jsr Damage                  ;
                ;                           ;
            Dynamic_Collision_Loop_End: ;___+
                dey                         ;
                bne Dynamic_Collision_Loop  ;
                ;                           ;
                pla                         ;
                tay                         ;
                pla                         ;
                tax                         ;
                pla                         ;
                ;                           ;
                rts                         ;