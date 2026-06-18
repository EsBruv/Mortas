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
            lda XPosition, X                ; CCRight
            clc                             ;
            adc #CHARACTER_WIDTH            ;
            cmp XPosition, Y                ; CYLeft
            bcc Dynamic_Collision_Loop_End  ; Branch If CYLeft > CCRight
            ;                               ;
            lda XPosition, Y                ; CYRight
            clc                             ;
            adc #CHARACTER_WIDTH            ;
            cmp XPosition, X                ; CCLeft
            bcc Dynamic_Collision_Loop_End  ; Branch If CYRight < CCLeft
            ;                               ;
            lda YPosition, X                ; CCUp
            clc                             ;
            adc #CHARACTER_HEIGHT           ;
            cmp YPosition, Y                ; CYDown
            bcc Dynamic_Collision_Loop_End  ; Branch If CYDown > CCUp
            ;                               ;
            lda YPosition, Y                ; CCDown
            clc                             ;
            adc #CHARACTER_HEIGHT           ;
            cmp YPosition, X                ; CYUp
            bcc Dynamic_Collision_Loop_End  ; Branch If CYUp < CCDown
                ;                           ;

                
                ; Character Type
                ;                           ;
                jsr Health_Damage           ;
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