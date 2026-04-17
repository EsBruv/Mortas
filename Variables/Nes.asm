; ================================================================
;   Nes.asm 
;   Outlines NES Hardware Registers
;
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

;   |============================================|
;   |                Documentaion                |
;   |============================================|

    PPUCTRL             = $2000
        ;VPHB SIYX
        ;|||| ||||
        ;|||| |||+_ X Scroll Position                   (0: Add 0;                          1: Add 256 (FF))
        ;|||| ||+__ Y Scroll Position                   (0: Add 0;                          1: Add 240 (F0))
        ;|||| |+___ VRAM address increment              (0: Across;                         1: Down)
        ;|||| +____ Sprite pattern table address        (0: $0000;                          1: $1000; ignored in 8x16 mode)
        ;|||+______ Background pattern table address    (0: $0000;                          1: $1000)
        ;||+_______ Sprite size                         (0: 8x8 pixels;                     1: 8x16 pixels)
        ;|+________ PPU master/slave select             (0: read backdrop from EXT pins;    1: output color on EXT pins)
        ;+_________ NMI Generation                      (0: off;                            1: on)

        ;10010000

    PPUMASK             = $2001
        ; BGRs bMmG
        ; |||| |||+_ Greyscale                  (0: normal color,       1: produce a greyscale display)
        ; |||| ||+__ Left Padding Background    (0: Hide;               1: Show background)
        ; |||| |+___ Left Padding Sprites       (0: Hide;               1: Show sprites)
        ; |||| +____ Display Background         (0: Hide Background;    1: Show background)
        ; |||+______ Display Sprites            (0: Hide Sprites;       1: Show sprites)
        ; ||+_______ Emphasize red              (green on PAL/Dendy)
        ; |+________ Emphasize green            (red on PAL/Dendy)
        ; +_________ Emphasize blue

    PPUSTATUS           = $2002
        ; VSOx xxxx
        ; |||| ||||
        ; |||+-++++- (PPU open bus or 2C05 PPU identifier)
        ; ||+------- Sprite overflow flag
        ; |+-------- Sprite 0 hit flag
        ; +--------- Vblank flag, cleared on read. Unreliable; see below.

    OAMADDR             = $2003
    OAMDATA             = $2004
        ; Byte 0: Y Position
        ; Byte 1: Tile Index
        ; Byte 2: Attributes
            ; VHpU UUPP
            ; |||| ||||
            ; |||| ||++_ Palette (4 - 7)
            ; |||+ ++___ Unused
            ; ||+_______ Priority           (0: front; 1: behind)
            ; |+________ Horizontal Flip
            ; +_________ Vertical Flip
        ; Byte 3: X Position

        
    PPUSCROLL           = $2005
    PPUADDR             = $2006
    PPUDATA             = $2007
    OAMDMA              = $4014

    JOY1                = $4016
    JOY2                = $4017

    MMC3_BANK_SELECT    = $8000
    MMC3_BANK_DATA      = $8001

    
    SQ1VOL              = $4000
    SQ1SWEEP            = $4001
    SQ1LO               = $4002
    SQ1HI               = $4003
    SQ2VOL              = $4004
    SQ2SWEEP            = $4005
    SQ2LO               = $4006
    SQ2HI               = $4007
    TRILINEAR           = $4008
    TRILO               = $400A
    TRIHI               = $400B
    NOISEVOL            = $400C
    NOISELO             = $400E
    NOISEHI             = $400F
    DMCFREQ             = $4010
    DMCRAW              = $4011
    DMCSTART            = $4012
    DMCLEN              = $4013
    APUSTATUS           = $4015