; ================================================================
;   Constants.asm
;   Outlines Constant Variables
; 
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

; --------------------------------= Alphabet =--------------------------------

    ALPHABET_OFFSET     = $00

    _A                  = $41
    B                   = $42
    C                   = $43
    D                   = $44
    E                   = $45
    F                   = $46
    G                   = $47
    H                   = $48
    I                   = $49
    J                   = $4A
    K                   = $4B
    L                   = $4C
    M                   = $4D
    N                   = $4E
    O                   = $4F
    P                   = $50
    Q                   = $51
    R                   = $52
    S                   = $53
    T                   = $54
    U                   = $55
    V                   = $56
    W                   = $57
    _X                  = $58
    _Y                  = $59
    Z                   = $5A

; --------------------------------= Character =--------------------------------

    RESET   = $00
    HALF    = $80
    MAX     = $FF

    OFFSET  = $01

; --------------------------------= PPU =--------------------------------

    PPU_X               = $01
    PPU_Y               = $02
    PPU_SCROLL_CLEAR    = $FC
    PPU_VRAM_INC        = $04
    PPU_BKG_TABLE       = $10
    PPU_NMI             = $80

    PPU_GREY            = $01
    PPU_BKG             = $08
    PPU_SPR             = $10
    PPU_RED             = $20
    PPU_BLUE            = $40
    PPU_GREEN           = $80

; --------------------------------= Background =--------------------------------

    METATILE_OFFSET = $04

    ; <<<=-= Control =-=>>>
    
        BKG_UNDERGROUND = $10
        BKG_SWAP_LATCH = $20
        BKG_SHIFT_DIRECTION = $40
        BKG_SHIFT_LATCH = $80

    ;<<<=-= Collision =-=>>>

        COLLISION_WALK = $00    ; Not Used
        COLLISION_SOLID = $01
        COLLISION_SHIFT = $02
        COLLISION_LOCKED = $03  ; Not Used 

        COLLISION_MAP = $E0
        COLLISION_TILE = $10
        TILE_INDEX = $03
        TILE_COLLISION = $03

        CHARACTER_BASE = $00
        CHARACTER_MIDDLE = $08
        CHARACTER_WIDTH = $0F
        CHARACTER_HEIGHT = $0F

; --------------------------------= Character =--------------------------------

    PROJECTILE                          = $06
    ENTITY_AMOUNT                       = $0F

    ; <<<=-= Render =-=>>>

        

    ; <<<=-= Movement =-=>>>

        MOVEMENT_DIRECTION  = MOVEMENT_PRIMARY + MOVEMENT_DOWN + MOVEMENT_RIGHT

        MOVEMENT_VELOCITY   = MOVEMENT_YVEL + MOVEMENT_XVEL

        MOVEMENT_PRIMARY    = $08
        MOVEMENT_YVEL       = $10
        MOVEMENT_XVEL       = $40
        MOVEMENT_DOWN       = $20
        MOVEMENT_RIGHT      = $80

    ; <<<=-= Sprite =-=>>>

        DRAKON = $00
        BOOK = $01