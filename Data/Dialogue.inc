; ================================================================
;   Dialogue.inc
;   Handles Dialogue Data
; 
;   Revision History:
;       Essam Erbab, July 2026: Created
; ================================================================
    
; --------------------------------= Table =--------------------------------

    Dialogue_:
        .byte $03                       ; X_START
        .byte $03                       ; Y_START
        .byte $1D                       ; X_END
        .byte $0A                       ; Y_END
        .byte $03                       ; Option Amount
        .byte $00                       ; Unused
        .word Dialogue_Text             ; Text
        .word $0000                     ; Pointer 0
        .word Dialogue_Continue_Table   ; Pointer 1
        .word $0000                     ; Pointer 2
        .word $0000                     ; Pointer 3
        .word $0000                     ; Pointer 4
        .word $0000                     ; Pointer 5
        .word $0000                     ; Pointer 6
        .word $0000                     ; Pointer 7

    Dialogue_Text:
        .byte M, O, R, T, _A, SPACE     ;
        .byte M, O, R, T, _A, SPACE     ;
        .byte M, O, R, T, _A, SPACE     ;
        .byte M, O, R, T, _A, SPACE     ;
        .byte M, O, R, T, _A, SPACE     ;
        .byte M, O, R, T, _A, SPACE     ;
        .byte M, O, R, T, _A, SPACE     ;
        .byte M, O, R, T, _A, SPACE     ;
        .byte M, O, R, T, _A, SPACE     ;
        .byte M, O, R, T, _A, SPACE     ;
        .byte M, O, R, T, _A, SPACE     ;
        .byte M, O, R, T, _A, SPACE     ;
        .byte $00


    Dialogue_Table:
        .byte $03                       ; X_START
        .byte $03                       ; Y_START
        .byte $1D                       ; X_END
        .byte $0A                       ; Y_END
        .word Dialogue_Continue_Table   ; Pointer 1
        .word $0000                     ; Pointer 2
        .word $0000                     ; Pointer 3
        .word $0000                     ; Pointer 4
        .word $0000                     ; Pointer 5
        .word $0000                     ; Pointer 6
        .byte M, O, R, T, _A, SPACE     ; Dialogue text
        .byte M, O, R, T, _A, SPACE     ; Dialogue text
        .byte M, O, R, T, _A, SPACE     ; Dialogue text
        .byte M, O, R, T, _A, SPACE     ; Dialogue text
        .byte M, O, R, T, _A, SPACE     ; Dialogue text
        .byte M, O, R, T, _A, SPACE     ; Dialogue text
        .byte M, O, R, T, _A, SPACE     ; Dialogue text
        .byte M, O, R, T, _A, SPACE     ; Dialogue text
        .byte M, O, R, T, _A, SPACE     ; Dialogue text
        .byte M, O, R, T, _A, SPACE     ; Dialogue text
        .byte M, O, R, T, _A, SPACE     ; Dialogue text
        .byte M, O, R, T, _A, SPACE     ; Dialogue text
        .byte $00                       ; End

    Dialogue_Continue_Table:
        .byte $03                       ; X_START
        .byte $03                       ; Y_START
        .byte $1D                       ; X_END
        .byte $0A                       ; Y_END
        .word $0000                     ; Pointer 1
        .word $0000                     ; Pointer 2
        .word $0000                     ; Pointer 3
        .word $0000                     ; Pointer 4
        .word $0000                     ; Pointer 5
        .word $0000                     ; Pointer 6
        .byte V, I, T, _A, N, SPACE     ; Dialogue text
        .byte V, I, T, _A, N, SPACE     ; Dialogue text
        .byte V, I, T, _A, N, SPACE     ; Dialogue text
        .byte V, I, T, _A, N, SPACE     ; Dialogue text
        .byte V, I, T, _A, N, SPACE     ; Dialogue text
        .byte V, I, T, _A, N, SPACE     ; Dialogue text
        .byte V, I, T, _A, N, SPACE     ; Dialogue text
        .byte V, I, T, _A, N, SPACE     ; Dialogue text
        .byte V, I, T, _A, N, SPACE     ; Dialogue text
        .byte V, I, T, _A, N, SPACE     ; Dialogue text
        .byte V, I, T, _A, N, SPACE     ; Dialogue text
        .byte V, I, T, _A, N, SPACE     ; Dialogue text
        .byte $00                       ; End


    Option_Table:
        .byte $03                       ; X_START
        .byte $0A                       ; Y_START
        .byte $1D                       ; X_END
        .byte $1B                       ; Y_END
        .word $0000                     ; Pointer
        .word Option_Text_Table         ; TEXT
    
    Option_Text_Table: 
        .byte V, I, T, _A, N, SPACE     ; Dialogue text

    