; ================================================================
;   Zeropage.asm
;   Outlines Zeropage Registers
;
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

.segment "ZEROPAGE"

    Temp: .res 16

    ; --------------------------------= Character =--------------------------------

        XPosition: .res 16
        YPosition: .res 16

        MovementDir: .res 16
            ; XxYy PSSS
            ; |||| ||||
            ; |||| |+++_ Stun Timer         (0 Pxl - 7 Pxl)
            ; |||| +____ Primary Direction  (0: Y Direction;    1: X Direction)
            ; ||||
            ; |||+______ Y Velocity         (0: None;           1: Move)
            ; ||+_______ Y Direction        (0: Up;             1: Down)
            ; |+________ X Velocity         (0: None;           1: Move)
            ; +_________ X Direction        (0: Left;           1: Right)

        Previous_MovementDir: .res 16
            ; XxYy PSSS
            ; |||| ||||
            ; |||| |+++_ Stun Timer         (0 Pxl - 7 Pxl)
            ; |||| +____ Primary Direction  (0: Y Direction;    1: X Direction)
            ; ||||
            ; |||+______ Y Velocity         (0: None;           1: Move)
            ; ||+_______ Y Direction        (0: Up;             1: Down)
            ; |+________ X Velocity         (0: None;           1: Move)
            ; +_________ X Direction        (0: Left;           1: Right)

        CharacterType: .res 16
            ; VVVV DDAA
            ; |||| ||||
            ; |||| ||++_ Attribute Bits
            ; |||| ||||
            ; |||| ||++_ NPC                (X0: Male;      X1: Female)
            ; |||| ||||                     (0X: Adult;     1X: Other)
            ; |||| ||||
            ; |||| ||++_ Enemy              (X0: Easy;      X1: Hard)
            ; |||| ||                       (0X: Female;    1X: Male)
            ; |||| ++___ Character Type     (0: NPC;        1: Enemy;   2: Player;  3: Boss)
            ; ||||
            ; ++++______ Character Variant  (Variant 0 - Variant 7)

            ;           | NPC   | Enemy |Player | Boss  |

            ;   |       |00     |01     |10     |11     |
            ;   |-------|-------|-------|-------|-------|
            ;   |0000   |N/A    |Drakon |Player |       |
            ;   |-------|-------|-------|-------|-------|
            ;   |0001   |       |       |       |       |
            ;   |-------|-------|-------|-------|-------|
            ;   |0010   |       |       |       |       |
            ;   |-------|-------|-------|-------|-------|
            ;   |0011   |       |       |       |       |
            ;   |-------|-------|-------|-------|-------|
            ;   |0100   |       |       |       |       |
            ;   |-------|-------|-------|-------|-------|
            ;   |0101   |       |       |       |       |
            ;   |-------|-------|-------|-------|-------|
            ;   |0110   |       |       |       |       |
            ;   |-------|-------|-------|-------|-------|
            ;   |0111   |       |       |       |       |
            ;   |-------|-------|-------|-------|-------|
            ;   |0000   |       |       |       |       |
            ;   |-------|-------|-------|-------|-------|
            ;   |0001   |       |       |       |       |
            ;   |-------|-------|-------|-------|-------|
            ;   |0010   |       |       |       |       |
            ;   |-------|-------|-------|-------|-------|
            ;   |0011   |       |       |       |       |
            ;   |-------|-------|-------|-------|-------|
            ;   |0100   |       |       |       |       |
            ;   |-------|-------|-------|-------|-------|
            ;   |0101   |       |       |       |       |
            ;   |-------|-------|-------|-------|-------|
            ;   |0110   |       |       |       |       |
            ;   |-------|-------|-------|-------|-------|
            ;   |0111   |       |       |       |       |
            ;   |-------|-------|-------|-------|-------|

        CharacterHealth: .res 16

        AnimationState: .res 16
            ; 7654 32SS
            ; |||| ||||
            ; |||| ||++_ State      (0: Idle;   1: Moving;  2: Idle;    3: Moving)
            ; |||| |+___
            ; |||| +____
            ; ||||      
            ; |||+______a
            ; ||+_______
            ; |+________
            ; +_________


    RNGReserve: .res 2

    ; --------------------------------= Character =--------------------------------

        Joypad: .res 2
        Button_Held_Timer: .res 8

    ; --------------------------------= Clock =--------------------------------

        Counter: .res 1
        SecondCounter: .res 1
        MinuteCounter: .res 1

    ; --------------------------------= Current =--------------------------------

        CPPUCTRL: .res 1
        CPPUMASK: .res 1

        CPPUADDR: .res 2

        CCharacter: .res 1
    
    ; --------------------------------= Background =--------------------------------
        BKG_Index: .res 1
        BKG_Control: .res 1
            ; uUSD TTPP
            ; |||| ||||
            ; |||| ||++_ Time                       (Frame 0 - Frame 3)
            ; |||| ++___ Background Screen Position (0: $2000;          1: $2400;       2: $2800;   3: $2C00)
            ; ||||
            ; |||+______ Underground Bit            (0: Overworld;      1: Underground)
            ; ||+_______ Background Swap Bit        (0: Don't Swap;     1: Swap)
            ; |+________ Shift Direction            (0: Up / Left;      1: Down / Right)
            ; +_________ Shift Bit                  (0: Don't Shift;    1: Shift)
        
        MapColumn: .res 1
        MapRow: .res 1
        Tile: .res 1
        MetaTileOffset: .res 1

        CamXPosition: .res 1
        CamYPosition: .res 1

    ; --------------------------------= Reserves =--------------------------------

        PointerReserve: .res 2

        MapPointer: .res 2

        DamageControl: .res 1