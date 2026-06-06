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
        tax                             ;
        tay                             ;
        ;                               ;
        lda #RESET                      ;
        sta OAMADDR                     ;
        ;                               ;
        Background_Swap_Render: ;_______+
            lda BKG_Control             ; Background Swap Latch
            and #BKG_SWAP_LATCH         ;
            beq Render_Update           ; Branch If Background Swap Latch = 0
                jsr Background_Swap     ; Swap Background
                ;                       ;
        Render_Shift_Shift: ;___________+
            lda BKG_Control             ; Screen Shift Latch
            and #BKG_SHIFT_LATCH        ;
            beq Render_Update           ; Branch if !Shift Latch
                ; jsr Shift               ; Shift Screen
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
            ;                           ;
            lda CPPUMASK                ;
            sta PPUMASK                 ;
            ;                           ;
            lda CamXPosition            ;
            sta PPUSCROLL               ;
            lda CamYPosition            ;
            sta PPUSCROLL               ;
            ;                           ;
            lda #RESET                  ;
            sta OAMADDR                 ;
            ;                           ;
        Render_Exit: ;__________________+
            bit PPUSTATUS               ;
            bmi Render_Exit             ;
            rti                         ;
;

; --------------------------------= Methods =--------------------------------
    Fixed_Render: ;_________________________+
        ;                                   ;
        Fixed_Render_Loop: ;________________+
            ;                               ;
            Fixed_Render_Character: ;_______+
                jsr Render_Character        ;
                ;                           ;
        Fixed_Render_End: ;_________________+
            rts                             ;
        ;

    Offset_Render: ;________________________+
        ;                                   ;
        Offset_Render_Loop: ;_______________+
            ;                               ;
            Offset_Render_Character: ;______+
                jsr Render_Character        ;
                ;                           ;
        Offset_Render_End: ;________________+
            rts                             ;
    ;