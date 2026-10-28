; ; ================================================================
; ;   Alt_Swap.asm
; ;   Handles Background Rendering Alternatively
; ; 
; ;   Revision History:
; ;       Essam Erbab, April 2026: Created
; ; ================================================================

; ; --------------------------------= Background =--------------------------------
;     Alt_Background_Swap: ;__________________________+
;         ;                                           ;
;         ldy #RESET                                  ;
;         Alt_Background_Swap_Loop: ;_________________+
;             lda #$01                                ;
;             sta $0300, Y                            ;
;             lda #$01                                ;
;             sta $0400, Y                            ;
;             lda #$01                                ;
;             sta $0500, Y                            ;
;             lda #$01                                ;
;             sta $0600, Y                            ;
;             ;                                       ;
;             iny                                     ;
;             bne Alt_Background_Swap_Loop            ;
;         ;                                           ;
;         rts                                         ;
;     ;

;     Alt_Background_Render: ;________________________+
;         ;                                           ;
;         lda #$20                                    ;
;         sta PPUADDR                                 ;
;         ;                                           ;
;         lda #$00                                    ;
;         sta PPUADDR                                 ;
;         ;                                           ;
;         ldy #RESET                                  ;
;         Alt_Background_Render_Loop: ;_______________+
;             lda $0300, Y                            ;
;             sta PPUDATA                             ;
;             ;                                       ;
;             lda $0400, Y                            ;
;             sta PPUDATA                             ;
;             ;                                       ;
;             lda $0500, Y                            ;
;             sta PPUDATA                             ;
;             ;                                       ;
;             lda $0600, Y                            ;
;             sta PPUDATA                             ;
;             ;                                       ;
;             ;                                       ;
;                 lda BKG_Control                 ;
;                 and #BKG_CLEAR                  ;
;                 sta BKG_Control                 ;
;                 ;                               ;
;                 lda CPPUCTRL                    ;
;                 ora #PPU_BKG_TABLE              ;
;                 ora #PPU_NMI                    ;
;                 sta CPPUCTRL                    ;
;                 ;                               ;
;                 lda CPPUMASK                    ;
;                 ora #PPU_BKG                    ;
;                 ora #PPU_SPR                    ;
;                 sta CPPUMASK                    ;
;             iny                                     ;
;             bne Alt_Background_Render_Loop          ;
;             ;                                       ;
;         rts                                         ;
;     ;
