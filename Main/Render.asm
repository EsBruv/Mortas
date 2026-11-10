; ================================================================
;   Render.asm (Render Loop)
;   Handles Render Logic 
; 
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

; --------------------------------= Render =--------------------------------
    Render: ;___________________________+
        pha                             ; Save A
        ;                               ;
        txa                             ; Save X
        pha                             ;
        ;                               ;
        tya                             ; Save Y
        pha                             ;
        ;                               ;
        lda Counter                     ; NMI Ready Check
        and #NMI_FLAG                   ;
        beq Render_Exit                 ; Branch if !NMI Ready
        ;                               ;
        lda Counter                     ;
        ora #NMI_FLAG                   ;
        eor #NMI_FLAG                   ;
        sta Counter                     ;
        ;                               ;
        jsr Clock                       ;
        ;                               ;
        lda #RESET                      ;
        sta OAMADDR                     ;
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
            pla                         ; Restore Y
            tay                         ;
            ;                           ;
            pla                         ;
            tax                         ;
            ;                           ;
            pla                         ;
            ;                           ;
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