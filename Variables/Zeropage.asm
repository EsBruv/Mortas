; ================================================================
;   Zeropage.asm
;   Outlines Zeropage Registers
;
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

.segment "ZEROPAGE"
    MapColumn: .res 1
    MapRow: .res 1
    Tile: .res 1
    MetaTileOffset: .res 1

    Temp: .res 1

    Joypad: .res 1
    Button_Held_Timer: .res 8
    Counter: .res 1
    SecondCounter: .res 1
    MinuteCounter: .res 1

    CPPUCRTL: .res 1
    CPPUMASK: .res 1

    CPPUADDR: .res 2

    CamXPosition: .res 1
    CamYPosition: .res 1

    BKG_Control: .res 1
        ; uUSD TTPP
        ; |||| ||||
        ; |||| ||++_ Time                       (Frame 0 - Frame 3)
        ; |||| ++___ Background Screen Position (0: $2000;          1: $2400;           2: $2800; 3: $2C00)
        ; ||||
        ; |||+______ Underground Bit            (0: Overworld;      1: Underground)
        ; ||+_______ Background Swap Bit        (0: Don't Swap;     1: Swap)
        ; |+________ Shift Direction            (0: Up / Left;      1: Down / Right)
        ; +_________ Shift Bit                  (0: Don't Shift;    1: Shift)

    ; --------------------------------= Pointer =--------------------------------

    

    ; --------------------------------= Pointer =--------------------------------

    PointerReserve: .res 2

    MapPointer: .res 2
    AttributePointer: .res 2

    MetaPointer: .res 2
    TilePointer: .res 2