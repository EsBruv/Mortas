; ================================================================
;   Background.asm
;   Handles Background Rendering
; 
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

; --------------------------------= Background =--------------------------------
    Background_Swap: ;__________________________+
        lda PPUSTATUS                           ;
        sei                                     ;
        ;                                       ;
        lda #RESET                              ;
        sta PPUCTRL                             ;
        sta CPPUCRTL                            ;
        ;                                       ;
        sta PPUMASK                             ;
        sta CPPUMASK                            ;
        ;                                       ;
        sta CPPUADDR                            ;
        sta CPPUADDR + 1                        ;
        ;                                       ;
        tax                                     ;
        tay                                     ;
        ;                                       ;
        sta MapColumn                           ;
        sta MapRow                              ;
        ;                                       ;
        ;                                       ;
        Background_Swap_Loop: ;_________________+
            jsr Background_MetaTile             ;
                ;                               ;
            Background_Swap_Column: ;___________+
                inc MapColumn                   ;
                lda MapColumn                   ;
                cmp #COLUMN_MAX                 ;
                beq Background_Swap_Row         ;
                    jmp Background_Swap_Loop    ;
                    ;                           ;
            Background_Swap_Row: ;______________+
                lda #RESET                      ;
                sta MapColumn                   ;
                inc MapRow                      ;
                ;                               ;
                lda MapRow                      ;
                cmp #ROW_MAX                    ;
                beq Background_Swap_Loop_End    ;
                    lda CPPUADDR + 1            ;
                    clc                         ;
                    adc #SCREEN_WIDTH           ;
                    adc #SCREEN_WIDTH           ;
                    adc #SCREEN_WIDTH           ;
                    sta CPPUADDR + 1            ;
                    ;                           ;
                    jmp Background_Swap_Loop    ;
                    ;                           ;
            Background_Swap_Loop_End: ;_________+
                lda BKG_Control                 ;
                and #BKG_CURRENT_TIME           ;
                cmp #BKG_TIME_MAX               ;
                beq Background_Swap_Clear       ;
                    inc BKG_Control             ;
                    jmp Background_Swap_End     ;
                    ;                           ;
            Background_Swap_Clear: ;____________+
                lda BKG_Control                 ;
                and #ATTRIBUTE_HIGH             ;
                sta PPUADDR                     ;
                ;                               ;
                lda #ATTRIBUTE_LOW              ;
                sta PPUADDR                     ;
                ldy #RESET                      ;
                ;                               ;
                Attribute_Loop: ;_______________+
                    lda (AttributePointer), Y   ;
                    sta PPUDATA                 ;
                    iny                         ;
                    cpy #ATTRIBUTE_MAX          ;
                    bne Attribute_Loop          ;
                    ;                           ;
                lda BKG_Control                 ;
                and #BKG_CLEAR                  ;
                sta BKG_Control                 ;
                ;                               ;
                lda #RESET                      ;
                sta MapColumn                   ;
                sta MapRow                      ;
                sta Tile                        ;
                ;                               ;
        Background_Swap_End: ;__________________+
            lda CPPUCRTL                        ;
            ora #PPU_BKG_TABLE                  ;
            ora #PPU_NMI                        ;
            sta PPUCTRL                         ;
            sta CPPUCRTL                        ;
            ;                                   ;
            lda CPPUMASK                        ;
            ora #PPU_BKG                        ;
            ora #PPU_SPR                        ;
            sta PPUMASK                         ;
            ;                                   ;
            lda CamXPosition                    ;
            sta PPUSCROLL                       ;
            lda CamYPosition                    ;
            sta PPUSCROLL                       ;
            ;                                   ;
            rts                                 ;
    ;
    
    Background_Tile_Index: ;____+
        lda BKG_Control         ;
        and #BKG_CURRENT_TIME   ;
        asl                     ;
        asl                     ;
        asl                     ;
        asl                     ;
        sta CPPUADDR            ;
        ;                       ;
        lda MapRow              ;
        asl                     ;
        asl                     ;
        asl                     ;
        ;                       ;
        clc                     ;
        adc MapColumn           ;
        adc CPPUADDR            ;
        tay                     ;
        ;                       ;
        lda (MapPointer), Y     ;
        clc                     ;
        adc MetaTileOffset      ;
        tax                     ;
        ;                       ;
        lda MetaTiles, X        ;
        clc                     ;
        adc Tile                ;
        tax                     ;
        ;                       ;
        rts                     ;
    ;

    Nametable_Address: ;________+
        lda BKG_Control         ;
        and #NAMETABLE_HIGH     ;
        sta PPUADDR             ;
        sta CPPUADDR            ;
        ;                       ;
        lda CPPUADDR + 1        ;
        sta PPUADDR             ;
        ;                       ;
        rts                     ;
    ;

    Background_Sprite: ;____+
        lda Tiles, X        ;
        sta PPUDATA         ;
        ;                   ;
        rts                 ;
    ;

    Background_Tile: ;__________+
        jsr Nametable_Address   ;
        ;                       ;
        jsr Background_Sprite   ;
        inc Tile                ;
        inc CPPUADDR + 1        ;
        ;                       ;
        jsr Background_Sprite   ;
        inc Tile                ;
        ;                       ;
        lda CPPUADDR + 1        ;
        clc                     ;
        adc #SCREEN_WIDTH       ;
        sta CPPUADDR + 1        ;
        dec CPPUADDR + 1        ;
        ;                       ;
        jsr Nametable_Address   ;
        ;                       ;
        jsr Background_Sprite   ;
        inc Tile                ;
        inc CPPUADDR + 1        ;
        ;                       ;
        jsr Background_Sprite   ;
        dec Tile                ;
        dec Tile                ;
        dec Tile                ;
        inc CPPUADDR + 1        ;
        ;                       ;
        lda CPPUADDR + 1        ;
        sec                     ;
        sbc #SCREEN_WIDTH       ;
        sta CPPUADDR + 1        ;
        clc                     ;
        ;                       ;
        rts                     ;
    ;

    Background_MetaTile: ;__________+
        jsr Background_Tile_Index   ;
        jsr Background_Tile         ;
        inc MetaTileOffset          ;
        ;                           ;
        jsr Background_Tile_Index   ;
        jsr Background_Tile         ;
        inc MetaTileOffset          ;
        ;                           ;
        lda CPPUADDR + 1            ;
        clc                         ;
        adc #SCREEN_WIDTH           ;
        adc #SCREEN_WIDTH           ;
        sec                         ;
        sbc #METATILE_OFFSET        ;
        sta CPPUADDR + 1            ;
        clc                         ;
        ;                           ;
        jsr Background_Tile_Index   ;
        jsr Background_Tile         ;
        inc MetaTileOffset          ;
        ;                           ;
        jsr Background_Tile_Index   ;
        jsr Background_Tile         ;
        ;                           ;
        dec MetaTileOffset          ;
        dec MetaTileOffset          ;
        dec MetaTileOffset          ;
        ;                           ;
        lda CPPUADDR + 1            ;
        sec                         ;
        sbc #SCREEN_WIDTH           ;
        sbc #SCREEN_WIDTH           ;
        sta CPPUADDR + 1            ;
        clc                         ;
        ;                           ;
        rts                         ;
    ;