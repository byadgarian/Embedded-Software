'---------- SETTINGS ------------------------------------------------------------
$regfile = "m32def.dat"
$crystal = 8000000
Config Timer1 = Timer , Prescale = 1024
Ddra = &B11110000
Ddrb.0 = 1 : Portb.0 = 1
Ddrb.2 = 1 : Portb.2 = 1
Ddrb.3 = 1 : Portb.3 = 0
Ddrb.4 = 1 : Portb.4 = 0

'---------- VARIABLES ------------------------------------------------------------
Dim X As Byte
Dim T As Byte
Dim P1 As Byte
Dim P2 As Byte
Dim P3 As Byte
Dim P4 As Byte
Dim A As Byte
Dim B As Byte
Dim C As Byte
Dim D As Byte

'---------- PRESETS ------------------------------------------------------------
Cls
Cursor Off
Stop Timer1
Enable Interrupts
Enable Ovf1
On Ovf1 Increast Nosave

'---------- ANSWER AND AUTHENTICATE CALLER ------------------------------------------------------------
Wiatforring:
Do
    Debounce Pinb.1 , 1 , Holdthenanswer
Loop

Holdthenanswer:
Wait 10
Portb.2 = 0
Waitms 500
Portb.2 = 1
Timer1 = 0
Start Timer1
Readeeprom A , 1

Firsttime:
If A = 255 Then
    Portb.3 = 1
    Waitms 500
    Portb.3 = 0
    Waitms 250
    Portb.3 = 1
    Waitms 500
    Portb.3 = 0
    Waitms 250
    Portb.3 = 1
    Waitms 500
    Portb.3 = 0
    Goto Firstchangepassword
End If
Portb.3 = 1
Waitms 500
Portb.3 = 0

Waitforpassword:
X = 0
Do
    Debounce Pinb.5 , 1 , Checkpassword , Sub
Loop

Checkpassword:
Incr X
If X = 1 Then
    P1 = Pina
    Return
End If
If X = 2 Then
    P2 = Pina
    Return
End If
If X = 3 Then
    P3 = Pina
    Return
End If
P4 = Pina
Readeeprom A , 1
Readeeprom B , 2
Readeeprom C , 3
Readeeprom D , 4
If P1 = A Then
    If P2 = B Then
        If P3 = C Then
            If P4 = D Then Goto Main Else Goto Wrongpassword
        End If
        Goto Wrongpassword
    End If
    Goto Wrongpassword
End If
Goto Wrongpassword

Wrongpassword:
Portb.3 = 1
Waitms 250
Portb.3 = 0
Waitms 125
Portb.3 = 1
Waitms 250
Portb.3 = 0
P1 = 0 : P2 = 0 : P3 = 0 : P4 = 0
Goto Waitforpassword

Main:
Portb.3 = 1
Wait 1
Portb.3 = 0
Do
    Debounce Pinb.5 , 1 , Menue
Loop

'---------- PHONE MANUE ------------------------------------------------------------
Menue:
Do
    X = Pina
    If X = 1 Then Gosub Control
    If X = 2 Then Goto Changepassword
    If X = 3 Then Goto Shutdown
Loop

'---------- CONTROL EQUIPMENT ------------------------------------------------------------
Control:
Portb.3 = 1
Waitms 500
Portb.3 = 0
Do
    X = Pina
    If X = 12 Then
        Portb.4 = 1
        Wait 3
        Portb.3 = 1
        Wait 1
        Portb.3 = 0
        Return
    End If
    If X = 11 Then
        Portb.4 = 0
        Wait 3
        Portb.3 = 1
        Wait 1
        Portb.3 = 0
        Return
    End If
Loop

'---------- CHANGE PASSWORD ------------------------------------------------------------
Changepassword:
Portb.3 = 1
Waitms 500
Portb.3 = 0
X = 0

Firstchangepassword:
Do
    Debounce Pinb.5 , 1 , Setpassword , Sub
Loop

Setpassword:
Incr X
If X = 1 Then
    P1 = Pina
    Return
End If
If X = 2 Then
    P2 = Pina
    Return
End If
If X = 3 Then
    P3 = Pina
    Return
End If
P4 = Pina
Portb.3 = 1
Waitms 500
Portb.3 = 0
Do
    X = Pina
    If X = 12 Then
        A = P1 : B = P2 : C = P3 : D = P4
        Writeeeprom A , 1
        Writeeeprom B , 2
        Writeeeprom C , 3
        Writeeeprom D , 4
        Goto Main
    End If
Loop

'---------- SHUTDOWN SYSTEM ------------------------------------------------------------
Shutdown:
Portb.3 = 1
Waitms 500
Portb.3 = 0
Do
    X = Pina
    If X = 11 Then
        Portb.2 = 0
        Waitms 500
        Portb.2 = 1
        Portb.0 = 0
    End If
Loop

Increast:
Incr T
If T = 9 Then
    Portb.2 = 0
    Waitms 500
    Portb.2 = 1
    Wait 1
    Portb.2 = 0
    Waitms 500
    Portb.2 = 1
    Portb.0 = 0
End If
Return
End