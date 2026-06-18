; ================================================================
;   Selection.asm
;   Handles Map Selection
;
;   Revision History:
;       Essam Erbab, May 2026: Created
; ================================================================

; --------------------------------= Selection =--------------------------------
    Selection: ;____________________;
        lda #$00                    ;
        sta PointerReserve          ;
        sta PointerReserve + 1      ;
        ;                           ;
        Selection_Low: ;____________+
            ldx BKG_Index           ;
            ;                       ;
            lda Map_Data_Low, X     ;
            sta PointerReserve      ;
            Lda Map_Data_High, X    ;
            sta PointerReserve + 1  ;
            ;                       ;
        Selection_Jump: ;___________+
            jmp (PointerReserve)    ;

; --------------------------------= Table =--------------------------------
    Map_Data_Low:
        .byte <Selection_00
        .byte <Selection_01
        .byte <Selection_00
        .byte <Selection_00
        .byte <Selection_00
        .byte <Selection_00
        .byte <Selection_00
        .byte <Selection_00
        .byte <Selection_00
        .byte <Selection_00
        .byte <Selection_00
        .byte <Selection_00
        .byte <Selection_00
        .byte <Selection_00
        .byte <Selection_00
        .byte <Selection_00
        .byte <Selection_10
        .byte <Selection_11

    Map_Data_High:
        .byte >Selection_00
        .byte >Selection_01
        .byte >Selection_00
        .byte >Selection_00
        .byte >Selection_00
        .byte >Selection_00
        .byte >Selection_00
        .byte >Selection_00
        .byte >Selection_00
        .byte >Selection_00
        .byte >Selection_00
        .byte >Selection_00
        .byte >Selection_00
        .byte >Selection_00
        .byte >Selection_00
        .byte >Selection_00
        .byte >Selection_10
        .byte >Selection_11

; --------------------------------= Map Data =--------------------------------
    Selection_00: ;_________________________+
        lda #<Map_00                        ; Set Map Pointer
        sta MapPointer                      ;
        lda #>Map_00                        ;
        sta MapPointer + 1                  ;
        ;                                   ;
        rts                                 ;
    ;

    Selection_01: ;_________________________+
        lda #<Map_01                        ; Set Map Pointer
        sta MapPointer                      ;
        lda #>Map_01                        ;
        sta MapPointer + 1                  ;
        ;                                   ;
        rts                                 ;
    ;

    Selection_10: ;_________________________+
        lda #<Map_10                        ; Set Map Pointer
        sta MapPointer                      ;
        lda #>Map_10                        ;
        sta MapPointer + 1                  ;
        ;                                   ;
        rts                                 ;
    ;
    
    Selection_11: ;_________________________+
        lda #<Map_11                        ; Set Map Pointer
        sta MapPointer                      ;
        lda #>Map_11                        ;
        sta MapPointer + 1                  ;
        ;                                   ;
        rts                                 ;
    ;