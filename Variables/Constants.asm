; ================================================================
;   Constants.asm
;   Outlines Constant Variables
; 
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

; --------------------------------= Alphabet =--------------------------------

    ALPHABET_OFFSET = $00

    _A = $41
    B = $42
    C = $43
    D = $44
    E = $45
    F = $46
    G = $47
    H = $48
    I = $49
    J = $4A
    K = $4B
    L = $4C
    M = $4D
    N = $4E
    O = $4F
    P = $50
    Q = $51
    R = $52
    S = $53
    T = $54
    U = $55
    V = $56
    W = $57
    _X = $58
    _Y = $59
    Z = $5A

; --------------------------------= Banks =--------------------------------
    
    SPRBANK0 = $00
    SPRBANK1 = $01

    BKGBANK0 = $02
    BKGBANK1 = $03
    BKGBANK2 = $04
    BKGBANK3 = $05

    PRGBANK0 = $06
    PRGBANK1 = $07

    CHR_SECTION_1 = $00
    CHR_SECTION_2 = $01
    CHR_SECTION_3 = $02
    CHR_SECTION_4 = $03

    ; <<<=-= PRG Banks =-=>>>
        PRG00 = $00
        PRG01 = $01
        PRG02 = $02
        PRG03 = $03
        PRG04 = $04
        PRG05 = $05
        PRG06 = $06
        PRG07 = $07
        PRG08 = $08
        PRG09 = $09
        PRG0A = $0A
        PRG0B = $0B
        PRG0C = $0C
        PRG0D = $0D

    ; <<<=-= Sprite =-=>>>

        SPR00 = $00
        SPR01 = $08
        SPR02 = $10
        SPR03 = $18
        SPR04 = $20
        SPR05 = $28
        SPR06 = $30
        SPR07 = $38

    ; <<<=-= Background =-=>>>

        BKG00 = $04
        BKG01 = $0C
        BKG02 = $14
        BKG03 = $1C
        BKG04 = $24
        BKG05 = $2C
        BKG06 = $34
        BKG07 = $3C
;

; --------------------------------= Character =--------------------------------

    RESET = $00
    MAX = $FF


    FPS = $78

    COUNTER_DIGIT_MAX = $0A
    COUNTER_DIGIT_INC = $10
    COUNTER_OVERFLOW = $60

    OFFSET = $02

; --------------------------------= Input =--------------------------------

    PRESSED = $01
    BUTTON_AMOUNT = $08

    HELD_TIMER_AMOUNT = $00

; --------------------------------= PPU =--------------------------------

    PPU_X = $01
    PPU_Y = $02
    PPU_VRAM_INC = $04
    PPU_BKG_TABLE = $10
    PPU_NMI = $80

    PPU_GREY = $01
    PPU_BKG = $08
    PPU_SPR = $10
    PPU_RED = $20
    PPU_BLUE = $40
    PPU_GREEN = $80

    PALETTE_HIGH = $3F

    PALETTE_BKG_1 = $00
    PALETTE_BKG_2 = $01
    PALETTE_BKG_3 = $02
    PALETTE_BKG_4 = $03
    PALETTE_SPR_1 = $04
    PALETTE_SPR_2 = $05
    PALETTE_SPR_3 = $06
    PALETTE_SPR_4 = $07

    BLACK = $00
    GREY = $04
    BLUE = $08
    PURPLE = $0C
    MEGENTA = $10
    PINK = $14
    RED = $18
    ORANGE = $1C
    GOLD = $20
    PUKE = $24
    GREEN = $28
    EMERALD = $2C
    TEAL = $30
    CYAN = $34