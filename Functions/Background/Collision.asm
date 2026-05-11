; =======================================================================
;   Collision.asm
;   Handles Collision Detection
;   
;   Revision History:
;       Essam Erbab, May 2026: Created
; =======================================================================

; --------------------------------= Calculations =--------------------------------
    Collision: ;____________________________+
        ;                                   ; Temp      = X
        ;                                   ; Temp + 1  = Y
        ;                                   ; Temp + 2  = Map Position
        ;                                   ; Temp + 3  = Map Index
        ;                                   ; Temp + 4  = Tile Index
        Collision_Position: ;_______________+
            txa                             ; Load X Offset
            clc                             ;
            adc XPosition                   ; Add Character X Position
            sta Temp                        ;
            ;                               ;
            tya                             ; Load Y Offset
            clc                             ;
            adc YPosition                   ; Add Character Y Position
            sta Temp + 1                    ;
            ;                               ;
        Collision_Map_Position: ;___________+
            lda Temp + 1                    ; (YPosition / 31) * 8 = (Row)
            and #COLLISION_MAP              ;
            lsr                             ;
            lsr                             ;
            sta Temp + 2                    ;
            ;                               ;
            lda Temp                        ; XPosition / 32 = (Column)
            lsr                             ;
            lsr                             ;
            lsr                             ;
            lsr                             ;
            lsr                             ;
            ora Temp + 2                    ; Column + Row
            sta Temp + 2                    ;
            tay                             ; Collision Position
            ;                               ;
            lda (MapPointer), Y             ;
            sta Temp + 3                    ;
            ;                               ;
        Collision_Tile_Position: ;__________+
            lda Temp + 1                    ;
            and #COLLISION_TILE             ;
            lsr                             ;
            lsr                             ;
            lsr                             ;
            sta Temp + 4                    ;
            ;                               ;
            lda Temp                        ;
            and #COLLISION_TILE             ;
            lsr                             ;
            lsr                             ;
            lsr                             ;
            lsr                             ;
            ora Temp + 4                    ;
            sta Temp + 4                    ;
            ;                               ;
            lda Temp + 3                    ;
            clc                             ;
            adc Temp + 4                    ;
            tax                             ;
            ;                               ;
            lda MetaTiles, X                ;
            sta Temp + 5                    ;
            lsr                             ;
            lsr                             ;
            tax                             ;
            ;                               ;
            lda MetaCollision, X            ;
            sta Temp + 6                    ;
            ;                               ;
            ldx Temp + 4                    ;
            beq Collision_Position_End      ;
            ;                               ;
            Collision_Tile_Shift: ;_________+
                lsr                         ;
                lsr                         ;
                dex                         ;
                bne Collision_Tile_Shift    ;
            ;                               ;
        Collision_Position_End: ;___________+
            and #TILE_COLLISION             ;
            sta Temp + 7                    ;
            rts                             ;














        ; Collision_Tile_Position: ;__________+
        ;     ;                               ;
        ;     
        ;     sta Temp + 3                    ;
        ;     ;                               ;
        ;     lda MetaCollision, X            ;
        ;     sta Temp + 4                    ;
        ;     ;                               ;
        ;     lda Temp + 3                    ;
        ;     beq Collision_Position_End      ;
        ;     tax                             ;
        ;     ;                               ;
        ;     Collision_Tile_Shift: ;_________+
        ;         lsr Temp + 4                ;
        ;         lsr Temp + 4                ;
        ;         dex                         ;
        ;         bne Collision_Tile_Shift    ;
        ;     ;                               ;
        ; Collision_Position_End: ;___________+
        ;     lda Temp + 4                    ;
        ;     and #TILE_COLLISION             ;
            rts                             ;
;

; --------------------------------= Collision Check =--------------------------------
    Wall_Collision_Top_Left: ;______+
        ldx #CHARACTER_BASE         ; XOffset = 00
        ldy #CHARACTER_BASE         ; YOffset = 00
        jsr Collision               ; Collision
        ;                           ;
        rts                         ;
        ;                           ;
    Wall_Collision_Top_Right: ;_____+
        ldx #CHARACTER_WIDTH        ; XOffset = 0F
        ldy #CHARACTER_BASE         ; YOffset = 00
        jsr Collision               ; Collision
        ;                           ;
        rts                         ;
        ;                           ;
    Wall_Collision_Bottom_Left: ;___+
        ldx #CHARACTER_BASE         ; XOffset = 00
        ldy #CHARACTER_HEIGHT       ; YOffset = 0F
        jsr Collision               ; Collision
        ;                           ;
        rts                         ;
        ;                           ;
    Wall_Collision_Bottom_Right: ;__+
        ldx #CHARACTER_WIDTH        ; XOffset = 0F
        ldy #CHARACTER_HEIGHT       ; YOffset = 0F
        jsr Collision               ; Collision
        ;                           ;
        rts                         ;
;