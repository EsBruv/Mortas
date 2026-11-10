; ================================================================
;   Render.asm
;   Handles Character Rendering
; 
;   Revision History:
;       Essam Erbab, May 2026: Created
;       Essam Erbab, November 2026: Updated
; ================================================================

; --------------------------------= Constants =--------------------------------

    ; RESET                     = $00 (Global.asm)
    ; MAX                       = $FF (Global.asm)

    DMA                         = $0200
    SPRITE_AMOUNT               = $0F

    SPRITE_YPOSITION_FIX        = $01
    SPRITE_BASE                 = $00
    SPRITE_OFFSET               = $08
    SPRITE_ZERO_OFFSET          = $10
    SPRITE_EMPTY_LOOP_AMOUNT    = $10

    SPRITE_ATTRIBUTE_BASE       = $00

    SPRITE_ATTRIBUTE_PAL0       = $00
    SPRITE_ATTRIBUTE_PAL1       = $01
    SPRITE_ATTRIBUTE_PAL2       = $02
    SPRITE_ATTRIBUTE_PAL3       = $03

    SPRITE_ATTRIBUTE_PRIORITY   = $20

    SPRITE_ATTRIBUTE_H_FLIP     = $40
    SPRITE_ATTRIBUTE_V_FLIP     = $80

    SPRITE_HIDE_Y               = $F0

; --------------------------------= Character Render =--------------------------------

    Render_OAM: ;_______+
        lda #RESET      ;
        sta OAMADDR     ;
        lda #>DMA       ;
        sta OAMDMA      ;
        ;               ;
        rts             ;
    ;

    Render_Entity: ;________________+
        lda CCharacter              ; Current Character
        asl                         ;
        asl                         ;
        asl                         ;
        asl                         ;
        clc                         ;
        adc #SPRITE_ZERO_OFFSET     ; Add Sprite 0 Offset
        tay                         ;
        ;                           ;
        ldx CCharacter              ; Current Character
        ;                           ;
        lda CharacterHealth, X      ;
        beq Render_Hidden           ; Branch if Character Health == 0
        lda YPosition, X            ;
        cmp #SPRITE_HIDE_Y          ; Compare Y Position to Hide Value
        bcs Render_Hidden           ; 
        ;                           ;
        jmp Render_Character        ;
    ;

    Render_Entity_Reverse: ;________+
        lda #ENTITY_AMOUNT          ;
        sec                         ;
        sbc CCharacter              ;
        asl                         ;
        asl                         ;
        asl                         ;
        asl                         ;
        clc                         ;
        adc #SPRITE_ZERO_OFFSET     ; Add Sprite 0 Offset
        tay                         ;
        ;                           ;
        ldx CCharacter              ; Current Character
        ;                           ;
        lda CharacterHealth, X      ;
        beq Render_Hidden           ; Branch if Character Health == 0
        lda YPosition, X            ;
        cmp #SPRITE_HIDE_Y          ; Compare Y Position to Hide Value
        bcs Render_Hidden           ; 
        ;                           ;
        jmp Render_Character        ;
    ;

    Render_Hidden: ;_____________________+
        ldx #SPRITE_EMPTY_LOOP_AMOUNT   ; Loop Amount
        ;                               ;
        Render_Hidden_Loop: ;____________+
            lda #MAX                    ; Clear Sprite 0
            sta DMA, Y                  ;
            iny                         ;
            ;                           ;
            dex                         ;
            bne Render_Hidden_Loop      ; Branch if X != 0
        ;                               ;
        rts                             ;
    ;

    Render_Character: ;_________________+
        lda YPosition, X                ;
        clc                             ;
        adc #SPRITE_BASE                ;
        sec                             ;
        sbc #SPRITE_YPOSITION_FIX       ;
        sta DMA, Y                      ;
        iny                             ;
        ;                               ;
        jsr Character_Selection         ;
        sta DMA, Y                      ;
        iny                             ;
        ;                               ;
        lda #SPRITE_ATTRIBUTE_BASE      ;
        sta DMA, Y                      ;
        iny                             ;
        ;                               ;
        lda XPosition, X                ;
        clc                             ;
        adc #SPRITE_BASE                ;
        sta DMA, Y                      ;
        iny                             ;
        ;                               ;
        lda YPosition, X                ;
        clc                             ;
        adc #SPRITE_OFFSET              ;
        sec                             ;
        sbc #SPRITE_YPOSITION_FIX       ;
        sta DMA, Y                      ;
        iny                             ;
        ;                               ;
        jsr Character_Selection         ;
        sta DMA, Y                      ;
        iny                             ;
        ;                               ;
        lda #SPRITE_ATTRIBUTE_BASE      ;
        sta DMA, Y                      ;
        iny                             ;
        ;                               ;
        lda XPosition, X                ;
        clc                             ;
        adc #SPRITE_BASE                ;
        sta DMA, Y                      ;
        iny                             ;
        ;                               ;
        lda YPosition, X                ;
        clc                             ;
        adc #SPRITE_BASE                ;
        sec                             ;
        sbc #SPRITE_YPOSITION_FIX       ;
        sta DMA, Y                      ;
        iny                             ;
        ;                               ;
        jsr Character_Selection         ;
        sta DMA, Y                      ;
        iny                             ;
        ;                               ;
        lda #SPRITE_ATTRIBUTE_H_FLIP    ;
        sta DMA, Y                      ;
        iny                             ;
        ;                               ;
        lda XPosition, X                ;
        clc                             ;
        adc #SPRITE_OFFSET              ;
        sta DMA, Y                      ;
        iny                             ;
        ;                               ;
        lda YPosition, X                ;
        clc                             ;
        adc #SPRITE_OFFSET              ;
        sec                             ;
        sbc #SPRITE_YPOSITION_FIX       ;
        sta DMA, Y                      ;
        iny                             ;
        ;                               ;
        jsr Character_Selection         ;
        sta DMA, Y                      ;
        iny                             ;
        ;                               ;
        lda #SPRITE_ATTRIBUTE_H_FLIP    ;
        sta DMA, Y                      ;
        iny                             ;
        ;                               ;
        lda XPosition, X                ;
        clc                             ;
        adc #SPRITE_OFFSET              ;
        sta DMA, Y                      ;
        iny                             ;
        ;                               ;
        rts                             ;
    ;
