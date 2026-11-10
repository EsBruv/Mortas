; ================================================================
;   Level.asm
;   Handles Map Selection
;
;   Revision History:
;       Essam Erbab, May 2026: Created
;       Essam Erbab, November 2026: Updated
; ================================================================

; --------------------------------= Constants =--------------------------------

    ; RESET                 = $00 (Global.asm)

    SCREEN_SIZE = 64

; --------------------------------= Selection =--------------------------------

    Selection: ;________________+
        lda #RESET              ;
        sta PointerReserve      ;
        sta PointerReserve + 1  ;
        ;                       ;
        jsr Select_Map          ;
        ;                       ;
        rts                     ;
    ;

    Select_Map: ;_______________________________+
        ldx BKG_Index                           ; Background Index
        ;                                       ;
        lda Map_Low, X                          ; 
        sta PointerReserve                      ;
        Lda Map_High, X                         ;
        sta PointerReserve + 1                  ;
        ;                                       ;
        Select_Map_Transfer: ;__________________+
            jsr Background_Screen               ;
            ;                                   ;
            ldy #SCREEN_SIZE - 1                ; Screen Size
            Select_Map_Transfer_Loop: ;_________+
                lda (PointerReserve), Y         ;
                sta (MapPointer), Y             ;
                dey                             ;
                bpl Select_Map_Transfer_Loop    ;
                ;                               ;
            rts                                 ;
    ;

; --------------------------------= Table =--------------------------------

    Map_Low:
        .byte <Map_00
        .byte <Map_01
        .byte <Map_00
        .byte <Map_00
        .byte <Map_00
        .byte <Map_00
        .byte <Map_00
        .byte <Map_00
        .byte <Map_00
        .byte <Map_00
        .byte <Map_00
        .byte <Map_00
        .byte <Map_00
        .byte <Map_00
        .byte <Map_00
        .byte <Map_00
        .byte <Map_10
        .byte <Map_11

    Map_High:
        .byte >Map_00
        .byte >Map_01
        .byte >Map_00
        .byte >Map_00
        .byte >Map_00
        .byte >Map_00
        .byte >Map_00
        .byte >Map_00
        .byte >Map_00
        .byte >Map_00
        .byte >Map_00
        .byte >Map_00
        .byte >Map_00
        .byte >Map_00
        .byte >Map_00
        .byte >Map_00
        .byte >Map_10
        .byte >Map_11