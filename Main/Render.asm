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
                ;                           ;
        Fixed_Render_End: ;_________________+
            rts                             ;
        ;

    Offset_Render: ;________________________+
        ;                                   ;
        Offset_Render_Loop: ;_______________+
            ;                               ;
        Offset_Render_End: ;________________+
            rts                             ;
    ;