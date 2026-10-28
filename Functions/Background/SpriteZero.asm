
    Sprite_Zero: ;__________________+
        lda PPUSTATUS               ;
        ;                           ;
        lda #RESET                  ;
        sta PPUSCROLL               ;
        sta PPUSCROLL               ;
        ;                           ;
        lda CPPUCTRL                ;
        ora PPU_X                   ;
        ora PPU_Y                   ;
        sta PPUCTRL                 ;
        ;                           ;
        Sprite_Zero_Wait: ;_________+
            bit PPUSTATUS           ;
            bvs Sprite_Zero_Wait    ;
            ;                       ;
        Sprite_Zero_Hit: ;__________+
            bit PPUSTATUS           ;
            bvc Sprite_Zero_Hit     ;
            ;                       ;
        ;                           ;
        rts                         ;