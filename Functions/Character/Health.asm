

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

    Health_Damage: ;____________________+
        cpy #PROJECTILE                 ;
        bcc Health_Damage_Character     ;
        ;                               ;
        Health_Damage_Projectile: ;_____+
            tya                         ;
            sec                         ;
            sbc #PROJECTILE             ;
            cmp CCharacter              ;
            beq Damage_End              ;
            ;                           ;
        Health_Damage_Character: ;______+

        
        lda CharacterHealth, X          ;
        clc                             ;
        sbc Character_Damage, Y         ;
        sta CharacterHealth, X          ;
        ;                               ;
        lda MovementDir, X              ;
        ; ora #
        ;                               ;
        Damage_End: ;___________________+
            rts                         ;
            ;                           ;