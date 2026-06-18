; ================================================================
;   Selection.asm
;   Handles Character Selection
;
;   Revision History:
;       Essam Erbab, June 2026: Created
; ================================================================

    Characters:
        .byte $00, $00, $00, $00
        .byte $04, $05, $04, $05
        .byte $01, $01, $01, $01

    Projectiles:
        .byte $00, $00, $00, $00
        .byte $0B, $00, $00, $00

    Character_Damage:
        .byte $00, $00, $00, $00
        .byte $02, $00, $00, $00
        .byte $00, $00, $00, $00
        .byte $00, $00, $00, $00

    Character_Speed:
        .byte $00, $00, $00, $00
        .byte $02, $00, $00, $00
        .byte $00, $00, $00, $00
        .byte $00, $00, $00, $00
        .byte $00, $00, $00, $00
        .byte $00, $00, $00, $00
        .byte $00, $00, $00, $00
        .byte $00, $00, $00, $00
        .byte $00, $00, $00, $00
        .byte $00, $00, $00, $00
        .byte $00, $00, $00, $00
        .byte $00, $00, $00, $00
        .byte $00, $00, $00, $00
        .byte $00, $00, $00, $00
        .byte $00, $00, $00, $00
        .byte $00, $00, $00, $00
        .byte $00, $00, $00, $00
        .byte $00, $00, $00, $00

    Character_Selection: ;__________________+
        ldx CCharacter                      ;
        ;                                   ;
        lda CharacterType, X                ;
        and #$FC                            ;
        sta Temp                            ;
        ;                                   ;
        tya                                 ;
        and #$0C                            ;
        lsr                                 ;
        lsr                                 ;
        clc                                 ;
        adc Temp                            ;
        tax                                 ;
        ;                                   ;
        lda #RESET                          ;
        sta Temp                            ;
        ;                                   ;
        lda CCharacter                      ;
        cmp #PROJECTILE                     ;
        bcs Projectile_Selected             ;
        ;                                   ;
        Character_Selected: ;_______________+
            lda Characters, X               ;
            jmp Character_Selection_End     ;
            ;                               ;
        Projectile_Selected: ;______________+
            lda Projectiles, X              ;
            ;                               ;
        Character_Selection_End: ;__________+
            ldx CCharacter                  ;
            rts                             ;
    ;
