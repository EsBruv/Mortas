; ================================================================
;   Health.asm
;   Handles Health Logic
;
;   Revision History:
;       Essam Erbab, June 2026: Created
; ================================================================

; --------------------------------= Constants =--------------------------------

    ; PROJECTILE            = $08 (Global.asm)
    CHARACTER_TYPE          = $1C

    STUNNED                 = $07
    STUN_ONE_SEC            = $01
    STUN_TWO_SEC            = $02

; --------------------------------= Health =--------------------------------

    ; Health_Heal: ;______________________+
    ;     cpy #PROJECTILE                 ;
    ;     bcs Damage_End                  ;
    ;     ;                               ;
    ;     Health_Damage_Character: ;______+
    ;     ;                               ;
    ;     lda CharacterHealth, X          ;
    ;     clc                             ;
    ;     sbc Character_Damage, Y         ;
    ;     sta CharacterHealth, X          ;
    ;     ;                               ;
    ;     Damage_End: ;___________________+
    ;         rts                         ;
    ;         ;                           ;

    Damage: ;___________________________+
        tya                             ;
        pha                             ;
        ;                               ;
        lda MovementDir, X              ; Check If Attacked == Stunned
        and #STUNNED                    ;
        bne Damage_End                  ; Branch If Attacked == Stunned
        ;                               ;
        cpy #PROJECTILE                 ;
        bcc Damage_Character            ;
        ;                               ;
        Damage_Projectile: ;____________+
            tya                         ;
            sec                         ;
            sbc #PROJECTILE             ;
            cmp CCharacter              ;
            beq Damage_End              ;
            ;                           ;
        Damage_Character: ;_____________+
            lda CharacterType, Y        ; Check Attacker Type
            and #CHARACTER_TYPE         ;
            tay                         ; Store Attacker Type
            ;                           ;
            lda CharacterHealth, X      ;
            sec                         ;
            sbc Character_Damage, Y     ;
            bcs Damage_Character_Store  ; Branch if (Character Health - Damage) > 0
            ;                           ;
            lda #RESET                  ; Set Character Health to 0
            ;                           ;
        Damage_Character_Store: ;_______+
            sta CharacterHealth, X      ;
            ;                           ;
        Damage_Stun_Store: ;____________+
            ;                           ;
            lda MovementDir, X          ; Set Stun Timer
            ora #STUNNED                ;
            sta MovementDir, X          ;
            ;                           ;
        ;                               ;
        lda MovementDir, X              ;
        ; ora #
        ;                               ;
        Damage_End: ;___________________+
            pla                         ;
            tay                         ;
            ;                           ;
            rts                         ;
            ;                           ;