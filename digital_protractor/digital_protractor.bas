'---------- SETTINGS ------------------------------------------------------------
$regfile = "m32def.dat"
$crystal = 10000000
Config Lcdpin = Pin , Db4 = Portb.4 , Db5 = Portb.5 , Db6 = Portb.6 , Db7 = Portb.7 , Rs = Portb.0 , E = Portb.1
Config Timer1 = Timer , Prescale = 64
Config Timer0 = Timer , Prescale = 1024
Config Int1 = Rising
Config Int0 = Falling

'---------- VARIABLES ------------------------------------------------------------
Dim C As Byte
Dim T1 As Word
Dim T2 As Word
Dim D As Single
Dim T As Single
Dim A As Single
Dim P As Single

'---------- PRESETS ------------------------------------------------------------
Deflcdchar 0 , 28 , 20 , 28 , 32 , 32 , 32 , 32 , 32
Cursor Off
Cls
Timer1 = 0
T1 = 0
T2 = 0
C = 0
Enable Interrupts
Enable Int1
Enable Int0
Enable Ovf0
On Int1 Isr1
On Int0 Isr2
On Ovf0 Isr3 Nosave
Stop Timer0
Timer0 = 0

'---------- EXECUTE ROUTINE ------------------------------------------------------------
Start Timer0
Do
Loop

'---------- INTERRUPT SERVICE ROUTINES (ISR) ------------------------------------------------------------
Isr1:
T2 = Timer1
Stop Timer1
Timer1 = 0
Start Timer1
D = T1 / T2
Return

Isr2:
T1 = Timer1
Return

Isr3:
Incr C
If C = 20 Then
    C = 0
    If D >= 0.5625 Then D = D + 0.017
    If D < 0.5625 Then
        If D > 0.4375 Then
            D = D + 0.0115
        End If
    End If
    T = D - 0.5
    A = T / 0.125
    P = Asin(a)
    P = Rad2deg(p)
    If Pind.6 = 1 Then
        P = P - 90
        P = P * -1
    End If
    Locate 1 , 1
    Lcd "Angle = " ; P ; "  "
    Locate 1 , 14
    Lcd Chr(0) ; "   "
End If
Return