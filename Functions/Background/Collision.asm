; =======================================================================
;   Collision.asm
;   Handles Collision Detection
;   
;   Revision History:
;       Essam Erbab, May 2026: Created
; =======================================================================

; --------------------------------= Calculations =--------------------------------
    Collision: ;____________________________+
        ;                                   ;
        Collision_Position: ;_______________+
            txa                             ; Load X Offset
            ldx CCharacter                  ; 
            clc                             ;
            adc XPosition, X                ; Add Character X Position
            sta Temp                        ;
            ;                               ;
            tya                             ; Load Y Offset
            clc                             ;
            adc YPosition, X                ; Add Character Y Position
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