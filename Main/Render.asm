; ================================================================
;   Render.asm (Render Loop)
;   Handles Render Logic 
; 
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

; --------------------------------= Render =--------------------------------
    Render: ;___________________________+
        jsr Clock                       ;
        lda #RESET                      ;
        sta OAMADDR                     ;
        sta CCharacter                  ;
        tax                             ;
        tay                             ;
        ;                               ;
        Background_Swap_Render: ;_______+
            lda BKG_Control             ; Background Swap Latch
            and #BKG_SWAP_LATCH         ;
            beq Render_Update           ; Branch If Background Swap Latch = 0
                jsr Background_Swap     ; Swap Background
                jmp Render_End          ;
                ;                       ;
        Render_Update: ;________________+
            lda Counter                 ;
            and #OFFSET                 ;
            bne Render_Offset           ;
            ;                           ;
            Render_Fixed: ;_____________+
                jsr Fixed_Render        ;
                jmp Render_End          ;
                ;                       ;
            Render_Offset: ;____________+
                jsr Offset_Render       ;
                jmp Render_End          ;
                ;                       ;
        Render_End: ;___________________+
            lda PPUSTATUS               ;
            ;                           ;
            lda CPPUCTRL                ;
            sta PPUCTRL                 ;
            lda CPPUMASK                ;
            sta PPUMASK                 ;
            ;                           ;
            lda CamXPosition            ;
            sta PPUSCROLL               ;
            lda CamYPosition            ;
            sta PPUSCROLL               ;
            ;                           ;
        Render_Exit: ;__________________+
            bit PPUSTATUS               ;
            bmi Render_Exit             ;
            rti                         ;
;

; --------------------------------= Methods =--------------------------------
    Fixed_Render: ;_____________+
        jsr Render_OAM          ;
        ;                       ;
        Fixed_Render_End: ;_____+
            rts                 ;
        ;

    Offset_Render: ;____________+
        jsr Render_OAM          ;
        ;                       ;
        Offset_Render_End: ;____+
            rts                 ;
    ;