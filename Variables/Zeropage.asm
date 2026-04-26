; ================================================================
;   Zeropage.asm
;   Outlines Zeropage Registers
;
;   Revision History:
;       Essam Erbab, April 2026: Created
; ================================================================

.segment "ZEROPAGE"
    Temp: .res 1

    Joypad: .res 1
    Button_Held_Timer: .res 8
    Counter: .res 1
    SecondCounter: .res 1
    MinuteCounter: .res 1

    CPPUCRTL: .res 1
    CPPUMASK: .res 1

    CamXPosition: .res 1
    CamYPosition: .res 1