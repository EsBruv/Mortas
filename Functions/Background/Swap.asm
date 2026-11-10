; ================================================================
;   Swap.asm
;   Handles Background Rendering
; 
;   Revision History:
;       Essam Erbab, April 2026: Created
;       Essam Erbab, November 2026: Updated
; ================================================================

; --------------------------------= Constants =--------------------------------

    ; RESET             = $00 (Global.asm)

    ; PPU_NMI           = $80 (Global.asm)
    ; PPU_BKG_TABLE     = $10 (Global.asm)
    ; PPU_BKG           = $08 (Global.asm)
    ; PPU_SPR           = $10 (Global.asm)

    BKG_CLEAR           = $DC

    BKG_TIME_CURRENT    = $03
    BKG_TIME_MAX        = $03
    TEMP_CURRENT_TIME   = Temp

    NAMETABLE_HIGH      = $20
    NAMETABLE_MAX       = $23

    ATTRIBUTE_HIGH      = $2F
    ATTRIBUTE_LOW       = $C0
    ATTRIBUTE_MAX       = $40

    CURRENT_SCREEN      = $0C
    SCREEN_1            = $00
    SCREEN_2            = $04
    SCREEN_3            = $08
    SCREEN_4            = $0C

    COLUMN_MAX          = $08
    ROW_MAX             = $02

    SCREEN_WIDTH        = $20
    SCREEN_HIGHT        = $1E   ; Unused

; --------------------------------= Background =--------------------------------

    Initialize_Background: ;____________+
        lda #SCREEN_1                   ;
        sta BKG_Control                 ;
        ;                               ;
        jsr Selection                   ;
        ;                               ;
        lda #BKG_SWAP_LATCH             ;
        sta BKG_Control                 ;
        ;                               ;
        rts                             ;
        ;

    Background_Swap: ;__________________________+
        lda PPUSTATUS                           ;
        sei                                     ;
        ;                                       ;
        jsr Background_Screen                   ;
        ;                                       ;
        lda #RESET                              ;
        sta CPPUCTRL                            ;
        sta PPUCTRL                             ;
        sta CPPUMASK                            ;
        sta PPUMASK                             ;
        ;                                       ;
        sta CPPUADDR                            ;
        sta CPPUADDR + 1                        ;
        sta MapColumn                           ;
        sta MapRow                              ;
        ;                                       ;
        tax                                     ;
        tay                                     ;
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
                and #BKG_TIME_CURRENT           ;
                cmp #BKG_TIME_MAX               ;
                beq Background_Swap_Clear       ;
                    inc BKG_Control             ;
                    jmp Background_Swap_End     ;
                    ;                           ;
            Background_Swap_Clear: ;____________+
                lda BKG_Control                 ;
                and #CURRENT_SCREEN             ;
                ora #NAMETABLE_MAX              ;
                sta PPUADDR                     ;
                ;                               ;
                lda #ATTRIBUTE_LOW              ;
                sta PPUADDR                     ;
                ldy #RESET                      ;
                ;                               ;
                Attribute_Loop: ;_______________+
                    lda (MapPointer), Y         ;
                    lsr                         ;
                    lsr                         ;
                    tax                         ;
                    lda Attribute, X            ;
                    sta PPUDATA                 ;
                    ;                           ;
                    iny                         ;
                    cpy #ATTRIBUTE_MAX          ;
                    bne Attribute_Loop          ;
                    ;                           ;
                lda BKG_Control                 ;
                and #BKG_CLEAR                  ;
                sta BKG_Control                 ;
                ;                               ;
                lda CPPUCTRL                    ;
                ora #PPU_BKG_TABLE              ;
                ora #PPU_NMI                    ;
                sta CPPUCTRL                    ;
                ;                               ;
                lda CPPUMASK                    ;
                ora #PPU_BKG                    ;
                ora #PPU_SPR                    ;
                sta CPPUMASK                    ;
                ;                               ;
                lda #RESET                      ;
                sta MapColumn                   ;
                sta MapRow                      ;
                sta Tile                        ;
                ;                               ;
        Background_Swap_End: ;__________________+
            lda CPPUCTRL                        ;
            ora #PPU_NMI                        ;
            sta CPPUCTRL                        ;
            ;                                   ;
            cli                                 ;
            rts                                 ;
    ;
    
    Background_Screen: ;____________+
        lda BKG_Control             ;
        and #CURRENT_SCREEN         ;
        cmp #SCREEN_2               ;
        beq Background_Screen_X     ;
        cmp #SCREEN_3               ;
        beq Background_Screen_Y     ;
        cmp #SCREEN_4               ;
        beq Background_Screen_UI    ;
        ;                           ;
        Background_Screen_Main: ;___+
            lda #<Screen_Main       ;
            sta MapPointer          ;
            lda #>Screen_Main       ;
            sta MapPointer + 1      ;
            rts                     ;
            ;                       ;
        Background_Screen_X: ;______+
            lda #<Screen_X          ;
            sta MapPointer          ;
            lda #>Screen_X          ;
            sta MapPointer + 1      ;
            rts                     ;
            ;                       ;
        Background_Screen_Y: ;______+
            lda #<Screen_Y          ;
            sta MapPointer          ;
            lda #>Screen_Y          ;
            sta MapPointer + 1      ;
            rts                     ;
            ;                       ;
        Background_Screen_UI: ;_____+
            lda #<Screen_UI         ;
            sta MapPointer          ;
            lda #>Screen_UI         ;
            sta MapPointer + 1      ;
            rts                     ;
            ;

    Background_Tile_Index: ;____+
        lda BKG_Control         ;
        and #BKG_TIME_CURRENT   ;
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
        and #BKG_TIME_CURRENT   ;
        sta TEMP_CURRENT_TIME   ;
        ;                       ;
        lda BKG_Control         ;
        and #CURRENT_SCREEN     ;
        ora #NAMETABLE_HIGH     ;
        ora TEMP_CURRENT_TIME   ;
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