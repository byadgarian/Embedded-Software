'---------- SETTINGS ------------------------------------------------------------
$regfile = "m32def.dat"
$crystal = 12000000
Config Lcd = 16 * 2
Config Lcdpin = Pin , Db4 = Portb.4 , Db5 = Portb.5 , Db6 = Portb.6 , Db7 = Portb.7 , E = Portb.0 , Rs = Portb.1
Config Kbd = Porta , Delay = 100
Config Timer1 = Timer , Prescale = 8
Config Aci = On , Trigger = Rising
Config Int0 = Rising
Config Portc = Output
Config Portb.2 = Input
Config Portb.3 = Input
Config Portd.0 = Input

'---------- VARIABLES ------------------------------------------------------------
Dim X As Byte
Dim T1 As Word
Dim D As Single
Dim M As Byte
Dim K As Word
Dim Ds As Word
Dim C As Byte
Dim P As Bit
Dim L11 As Byte
Dim L12 As Byte
Dim L21 As Byte
Dim L22 As Byte
Dim L23 As Byte
Dim L24 As Byte
Dim L31 As Byte
Dim L32 As Byte
Dim L33 As Byte
Dim L34 As Byte
Dim L35 As Byte
Dim L11s As Single
Dim L12s As Single
Dim L21s As Single
Dim L22s As Single
Dim L23s As Single
Dim L24s As Single
Dim L31s As Single
Dim L32s As Single
Dim L33s As Single
Dim L34s As Single
Dim L35s As Single

'---------- PRESETS ------------------------------------------------------------
Cls
Cursor Off
Reset Portc.0
Reset Portc.1
Reset Portc.2
Reset Portc.3
Reset Portc.4
Reset Portc.5
Reset Portc.6
Reset Portc.7
Stop Timer1
Readeeprom L11 , 1
Readeeprom L12 , 2
Readeeprom L21 , 3
Readeeprom L22 , 4
Readeeprom L23 , 5
Readeeprom L24 , 6
Readeeprom L31 , 7
Readeeprom L32 , 8
Readeeprom L33 , 9
Readeeprom L34 , 10
Readeeprom L35 , 11
On Aci Control
On Int0 Pause
Disable Aci
Disable Int0
Disable Interrupts
L11 = 80

'---------- CONTROLLER MENU ------------------------------------------------------------
Locate 1 , 1
Lcd "START>1 SET>2"
Do
   K = Getkbd()
Loop Until K = 16
While K > 1
   K = Getkbd()
Wend
Select Case K
   Case 0 : Cls
            Locate 1 , 1
            Lcd "MODE"
            Locate 2 , 1
            Lcd "3>1 4-2>2 4-3>3"
            Do
               K = Getkbd()
            Loop Until K = 16
            While K > 2
               K = Getkbd()
            Wend
            Select Case K
               Case 0 : M = 1
               Case 1 : M = 2
               Case 2 : M = 3
            End Select
            Cls
            Goto Run
   Case 1 : Cls
            Locate 1 , 1
            Lcd "MODE"
            Locate 2 , 1
            Lcd "3>1 4-2>2 4-3>3"
            Do
               K = Getkbd()
            Loop Until K = 16
            While K > 2
               K = Getkbd()
            Wend
            Select Case K
               Case 0 : Cls
                        Nextl1:
                        Cursor Noblink
                        Cursor Off
                        Locate 1 , 1
                        Lcd "L1>1 L2>2"
                        Do
                           K = Getkbd()
                        Loop Until K = 16
                        While K > 1
                           K = Getkbd()
                        Wend
                        Select Case K
                           Case 0 : Cls
                                    Locate 1 , 1
                                    Lcd L11 ; "cm"
                                    Locate 2 , 1
                                    Lcd "EDIT>1 CANCEL>2"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K > 1
                                       K = Getkbd()
                                    Wend
                                    Cls
                                    If K = 1 Then Goto Nextl1
                                    Reenter1:
                                    Cursor Off
                                    Ds = 0
                                    Locate 2 , 1
                                    Lcd "CLR>RESET"
                                    Locate 1 , 1
                                    Cursor Blink
                                    None11:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None11
                                    K = Lookup(k , Data1)
                                    Locate 1 , 1
                                    Lcd K
                                    K = K * 100
                                    Ds = Ds + K
                                    None12:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter1
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None12
                                    K = Lookup(k , Data1)
                                    Locate 1 , 2
                                    Lcd K
                                    K = K * 10
                                    Ds = Ds + K
                                    None13:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter1
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None13
                                    K = Lookup(k , Data1)
                                    Locate 1 , 3
                                    Lcd K ; "cm"
                                    Cursor Off
                                    Ds = Ds + K
                                    Locate 2 , 1
                                    Lcd "CLR>RESET SV>SET"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K < 3 Or K = 4 Or K = 5 Or K = 6 Or K > 7
                                       K = Getkbd()
                                    Wend
                                    Select Case K
                                       Case 7 : Cls
                                                 Goto Reenter1
                                       Case 3 : L11 = Ds
                                                 Writeeeprom L11 , 1
                                                 Cls
                                                 Goto Nextl1
                                    End Select
                           Case 1 : Cls
                                    Locate 1 , 1
                                    Lcd L12 ; "cm"
                                    Locate 2 , 1
                                    Lcd "EDIT>1 CANCEL>2"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K > 1
                                       K = Getkbd()
                                    Wend
                                    Cls
                                    If K = 1 Then Goto Nextl1
                                    Reenter2:
                                    Cursor Off
                                    Ds = 0
                                    Locate 2 , 1
                                    Lcd "CLR>RESET"
                                    Locate 1 , 1
                                    Cursor Blink
                                    Cursor Blink
                                    None21:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None21
                                    K = Lookup(k , Data1)
                                    Locate 1 , 1
                                    Lcd K
                                    K = K * 100
                                    Ds = Ds + K
                                    None22:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter2
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None22
                                    K = Lookup(k , Data1)
                                    Locate 1 , 2
                                    Lcd K
                                    K = K * 10
                                    Ds = Ds + K
                                    None23:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter2
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None23
                                    K = Lookup(k , Data1)
                                    Locate 1 , 3
                                    Lcd K ; "cm"
                                    Cursor Off
                                    Ds = Ds + K
                                    Locate 2 , 1
                                    Lcd "CLR>RESET SV>SET"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K < 3 Or K = 4 Or K = 5 Or K = 6 Or K > 7
                                       K = Getkbd()
                                    Wend
                                    Select Case K
                                       Case 7 : Cls
                                                 Goto Reenter2
                                       Case 3 : L12 = Ds
                                                 Writeeeprom L12 , 2
                                                 Cls
                                                 Goto Nextl1
                                    End Select
                        End Select
               Case 1 : Cls
                        Nextl2:
                        Cursor Noblink
                        Cursor Off
                        Locate 1 , 1
                        Lcd "L1>1 L2>2 L3>3"
                        Locate 2 , 1
                        Lcd "L4>4"
                        Do
                           K = Getkbd()
                        Loop Until K = 16
                        While K = 3 Or K > 4
                           K = Getkbd()
                        Wend
                        Select Case K
                           Case 0 : Cls
                                    Locate 1 , 1
                                    Lcd L21 ; "cm"
                                    Locate 2 , 1
                                    Lcd "EDIT>1 CANCEL>2"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K > 1
                                       K = Getkbd()
                                    Wend
                                    Cls
                                    If K = 1 Then Goto Nextl2
                                    Reenter3:
                                    Cursor Off
                                    Ds = 0
                                    Locate 2 , 1
                                    Lcd "CLR>RESET"
                                    Locate 1 , 1
                                    Cursor Blink
                                    None31:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None31
                                    K = Lookup(k , Data1)
                                    Locate 1 , 1
                                    Lcd K
                                    K = K * 100
                                    Ds = Ds + K
                                    None32:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter3
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None32
                                    K = Lookup(k , Data1)
                                    Locate 1 , 2
                                    Lcd K
                                    K = K * 10
                                    Ds = Ds + K
                                    None33:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter3
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None33
                                    K = Lookup(k , Data1)
                                    Locate 1 , 3
                                    Lcd K ; "cm"
                                    Cursor Off
                                    Ds = Ds + K
                                    Locate 2 , 1
                                    Lcd "CLR>RESET SV>SET"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K < 3 Or K = 4 Or K = 5 Or K = 6 Or K > 7
                                       K = Getkbd()
                                    Wend
                                    Select Case K
                                       Case 7 : Cls
                                                 Goto Reenter3
                                       Case 3 : L21 = Ds
                                                 Writeeeprom L21 , 3
                                                 Cls
                                                 Goto Nextl2
                                    End Select
                           Case 1 : Cls
                                    Locate 1 , 1
                                    Lcd L22 ; "cm"
                                    Locate 2 , 1
                                    Lcd "EDIT>1 CANCEL>2"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K > 1
                                       K = Getkbd()
                                    Wend
                                    Cls
                                    If K = 1 Then Goto Nextl2
                                    Reenter4:
                                    Cursor Off
                                    Ds = 0
                                    Locate 2 , 1
                                    Lcd "CLR>RESET"
                                    Locate 1 , 1
                                    Cursor Blink
                                    Cursor Blink
                                    None41:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None41
                                    K = Lookup(k , Data1)
                                    Locate 1 , 1
                                    Lcd K
                                    K = K * 100
                                    Ds = Ds + K
                                    None42:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter4
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None42
                                    K = Lookup(k , Data1)
                                    Locate 1 , 2
                                    Lcd K
                                    K = K * 10
                                    Ds = Ds + K
                                    None43:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter4
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None43
                                    K = Lookup(k , Data1)
                                    Locate 1 , 3
                                    Lcd K ; "cm"
                                    Cursor Off
                                    Ds = Ds + K
                                    Locate 2 , 1
                                    Lcd "CLR>RESET SV>SET"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K < 3 Or K = 4 Or K = 5 Or K = 6 Or K > 7
                                       K = Getkbd()
                                    Wend
                                    Select Case K
                                       Case 7 : Cls
                                                 Goto Reenter4
                                       Case 3 : L22 = Ds
                                                 Writeeeprom L22 , 4
                                                 Cls
                                                 Goto Nextl2
                                    End Select
                           Case 2 : Cls
                                    Locate 1 , 1
                                    Lcd L23 ; "cm"
                                    Locate 2 , 1
                                    Lcd "EDIT>1 CANCEL>2"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K > 1
                                       K = Getkbd()
                                    Wend
                                    Cls
                                    If K = 1 Then Goto Nextl2
                                    Reenter5:
                                    Cursor Off
                                    Ds = 0
                                    Locate 2 , 1
                                    Lcd "CLR>RESET"
                                    Locate 1 , 1
                                    Cursor Blink
                                    Cursor Blink
                                    None51:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None51
                                    K = Lookup(k , Data1)
                                    Locate 1 , 1
                                    Lcd K
                                    K = K * 100
                                    Ds = Ds + K
                                    None52:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter5
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None52
                                    K = Lookup(k , Data1)
                                    Locate 1 , 2
                                    Lcd K
                                    K = K * 10
                                    Ds = Ds + K
                                    None53:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter5
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None53
                                    K = Lookup(k , Data1)
                                    Locate 1 , 3
                                    Lcd K ; "cm"
                                    Cursor Off
                                    Ds = Ds + K
                                    Locate 2 , 1
                                    Lcd "CLR>RESET SV>SET"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K < 3 Or K = 4 Or K = 5 Or K = 6 Or K > 7
                                       K = Getkbd()
                                    Wend
                                    Select Case K
                                       Case 7 : Cls
                                                 Goto Reenter5
                                       Case 3 : L23 = Ds
                                                 Writeeeprom L23 , 5
                                                 Cls
                                                 Goto Nextl2
                                    End Select
                           Case 4 : Cls
                                    Locate 1 , 1
                                    Lcd L24 ; "cm"
                                    Locate 2 , 1
                                    Lcd "EDIT>1 CANCEL>2"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K > 1
                                       K = Getkbd()
                                    Wend
                                    Cls
                                    If K = 1 Then Goto Nextl2
                                    Reenter6:
                                    Cursor Off
                                    Ds = 0
                                    Locate 2 , 1
                                    Lcd "CLR>RESET"
                                    Locate 1 , 1
                                    Cursor Blink
                                    Cursor Blink
                                    None61:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None61
                                    K = Lookup(k , Data1)
                                    Locate 1 , 1
                                    Lcd K
                                    K = K * 100
                                    Ds = Ds + K
                                    None62:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter6
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None62
                                    K = Lookup(k , Data1)
                                    Locate 1 , 2
                                    Lcd K
                                    K = K * 10
                                    Ds = Ds + K
                                    None63:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter6
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None63
                                    K = Lookup(k , Data1)
                                    Locate 1 , 3
                                    Lcd K ; "cm"
                                    Cursor Off
                                    Ds = Ds + K
                                    Locate 2 , 1
                                    Lcd "CLR>RESET SV>SET"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K < 3 Or K = 4 Or K = 5 Or K = 6 Or K > 7
                                       K = Getkbd()
                                    Wend
                                    Select Case K
                                       Case 7 : Cls
                                                 Goto Reenter6
                                       Case 3 : L24 = Ds
                                                 Writeeeprom L24 , 6
                                                 Cls
                                                 Goto Nextl2
                                    End Select
                        End Select
               Case 2 : Cls
                        Nextl3:
                        Cursor Noblink
                        Cursor Off
                        Locate 1 , 1
                        Lcd "L1>1 L2>2 L3>3"
                        Locate 2 , 1
                        Lcd "L4>4 L5>5"
                        Do
                           K = Getkbd()
                        Loop Until K = 16
                        While K = 3 Or K > 5
                           K = Getkbd()
                        Wend
                        Select Case K
                           Case 0 : Cls
                                    Locate 1 , 1
                                    Lcd L31 ; "cm"
                                    Locate 2 , 1
                                    Lcd "EDIT>1 CANCEL>2"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K > 1
                                       K = Getkbd()
                                    Wend
                                    Cls
                                    If K = 1 Then Goto Nextl3
                                    Reenter7:
                                    Cursor Off
                                    Ds = 0
                                    Locate 2 , 1
                                    Lcd "CLR>RESET"
                                    Locate 1 , 1
                                    Cursor Blink
                                    None71:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None71
                                    K = Lookup(k , Data1)
                                    Locate 1 , 1
                                    Lcd K
                                    K = K * 100
                                    Ds = Ds + K
                                    None72:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter7
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None72
                                    K = Lookup(k , Data1)
                                    Locate 1 , 2
                                    Lcd K
                                    K = K * 10
                                    Ds = Ds + K
                                    None73:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter7
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None73
                                    K = Lookup(k , Data1)
                                    Locate 1 , 3
                                    Lcd K ; "cm"
                                    Cursor Off
                                    Ds = Ds + K
                                    Locate 2 , 1
                                    Lcd "CLR>RESET SV>SET"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K < 3 Or K = 4 Or K = 5 Or K = 6 Or K > 7
                                       K = Getkbd()
                                    Wend
                                    Select Case K
                                       Case 7 : Cls
                                                 Goto Reenter7
                                       Case 3 : L31 = Ds
                                                 Writeeeprom L31 , 7
                                                 Cls
                                                 Goto Nextl3
                                    End Select
                           Case 1 : Cls
                                    Locate 1 , 1
                                    Lcd L32 ; "cm"
                                    Locate 2 , 1
                                    Lcd "EDIT>1 CANCEL>2"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K > 1
                                       K = Getkbd()
                                    Wend
                                    Cls
                                    If K = 1 Then Goto Nextl3
                                    Reenter8:
                                    Cursor Off
                                    Ds = 0
                                    Locate 2 , 1
                                    Lcd "CLR>RESET"
                                    Locate 1 , 1
                                    Cursor Blink
                                    Cursor Blink
                                    None81:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None81
                                    K = Lookup(k , Data1)
                                    Locate 1 , 1
                                    Lcd K
                                    K = K * 100
                                    Ds = Ds + K
                                    None82:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter8
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None82
                                    K = Lookup(k , Data1)
                                    Locate 1 , 2
                                    Lcd K
                                    K = K * 10
                                    Ds = Ds + K
                                    None83:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter8
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None83
                                    K = Lookup(k , Data1)
                                    Locate 1 , 3
                                    Lcd K ; "cm"
                                    Cursor Off
                                    Ds = Ds + K
                                    Locate 2 , 1
                                    Lcd "CLR>RESET SV>SET"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K < 3 Or K = 4 Or K = 5 Or K = 6 Or K > 7
                                       K = Getkbd()
                                    Wend
                                    Select Case K
                                       Case 7 : Cls
                                                 Goto Reenter8
                                       Case 3 : L32 = Ds
                                                 Writeeeprom L32 , 8
                                                 Cls
                                                 Goto Nextl3
                                    End Select
                           Case 2 : Cls
                                    Locate 1 , 1
                                    Lcd L33 ; "cm"
                                    Locate 2 , 1
                                    Lcd "EDIT>1 CANCEL>2"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K > 1
                                       K = Getkbd()
                                    Wend
                                    Cls
                                    If K = 1 Then Goto Nextl3
                                    Reenter9:
                                    Cursor Off
                                    Ds = 0
                                    Locate 2 , 1
                                    Lcd "CLR>RESET"
                                    Locate 1 , 1
                                    Cursor Blink
                                    Cursor Blink
                                    None91:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None91
                                    K = Lookup(k , Data1)
                                    Locate 1 , 1
                                    Lcd K
                                    K = K * 100
                                    Ds = Ds + K
                                    None92:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter9
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None92
                                    K = Lookup(k , Data1)
                                    Locate 1 , 2
                                    Lcd K
                                    K = K * 10
                                    Ds = Ds + K
                                    None93:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter9
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None93
                                    K = Lookup(k , Data1)
                                    Locate 1 , 3
                                    Lcd K ; "cm"
                                    Cursor Off
                                    Ds = Ds + K
                                    Locate 2 , 1
                                    Lcd "CLR>RESET SV>SET"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K < 3 Or K = 4 Or K = 5 Or K = 6 Or K > 7
                                       K = Getkbd()
                                    Wend
                                    Select Case K
                                       Case 7 : Cls
                                                 Goto Reenter9
                                       Case 3 : L33 = Ds
                                                 Writeeeprom L33 , 9
                                                 Cls
                                                 Goto Nextl3
                                    End Select
                           Case 4 : Cls
                                    Locate 1 , 1
                                    Lcd L34 ; "cm"
                                    Locate 2 , 1
                                    Lcd "EDIT>1 CANCEL>2"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K > 1
                                       K = Getkbd()
                                    Wend
                                    Cls
                                    If K = 1 Then Goto Nextl3
                                    Reenter10:
                                    Cursor Off
                                    Ds = 0
                                    Locate 2 , 1
                                    Lcd "CLR>RESET"
                                    Locate 1 , 1
                                    Cursor Blink
                                    Cursor Blink
                                    None101:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None101
                                    K = Lookup(k , Data1)
                                    Locate 1 , 1
                                    Lcd K
                                    K = K * 100
                                    Ds = Ds + K
                                    None102:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter10
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None102
                                    K = Lookup(k , Data1)
                                    Locate 1 , 2
                                    Lcd K
                                    K = K * 10
                                    Ds = Ds + K
                                    None103:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter10
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None103
                                    K = Lookup(k , Data1)
                                    Locate 1 , 3
                                    Lcd K ; "cm"
                                    Cursor Off
                                    Ds = Ds + K
                                    Locate 2 , 1
                                    Lcd "CLR>RESET SV>SET"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K < 3 Or K = 4 Or K = 5 Or K = 6 Or K > 7
                                       K = Getkbd()
                                    Wend
                                    Select Case K
                                       Case 7 : Cls
                                                 Goto Reenter10
                                       Case 3 : L34 = Ds
                                                 Writeeeprom L34 , 10
                                                 Cls
                                                 Goto Nextl3
                                    End Select
                           Case 5 : Cls
                                    Locate 1 , 1
                                    Lcd L35 ; "cm"
                                    Locate 2 , 1
                                    Lcd "EDIT>1 CANCEL>2"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K > 1
                                       K = Getkbd()
                                    Wend
                                    Cls
                                    If K = 1 Then Goto Nextl3
                                    Reenter11:
                                    Cursor Off
                                    Ds = 0
                                    Locate 2 , 1
                                    Lcd "CLR>RESET"
                                    Locate 1 , 1
                                    Cursor Blink
                                    Cursor Blink
                                    None111:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None111
                                    K = Lookup(k , Data1)
                                    Locate 1 , 1
                                    Lcd K
                                    K = K * 100
                                    Ds = Ds + K
                                    None112:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter11
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None112
                                    K = Lookup(k , Data1)
                                    Locate 1 , 2
                                    Lcd K
                                    K = K * 10
                                    Ds = Ds + K
                                    None113:
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K = 16
                                       K = Getkbd()
                                    Wend
                                    If K = 7 Then
                                       Cls
                                       Goto Reenter11
                                    End If
                                    If K = 3 Or K = 7 Or K = 11 Or K = 12 Or K = 14 Or K = 15 Then Goto None113
                                    K = Lookup(k , Data1)
                                    Locate 1 , 3
                                    Lcd K ; "cm"
                                    Cursor Off
                                    Ds = Ds + K
                                    Locate 2 , 1
                                    Lcd "CLR>RESET SV>SET"
                                    Do
                                       K = Getkbd()
                                    Loop Until K = 16
                                    While K < 3 Or K = 4 Or K = 5 Or K = 6 Or K > 7
                                       K = Getkbd()
                                    Wend
                                    Select Case K
                                       Case 7 : Cls
                                                 Goto Reenter11
                                       Case 3 : L35 = Ds
                                                 Writeeeprom L35 , 11
                                                 Cls
                                                 Goto Nextl3
                                    End Select
                        End Select
            End Select
End Select

'---------- EXECUTE ROUTINE ------------------------------------------------------------
Run:
Enable Int0
Enable Interrupts
Set Portc.1
Locate 1 , 1
Lcd "CHARGING WATER"
If M = 1 Then
   Wait 10
   Set Portc.5
End If
L11s = L11
L12s = L12
L21s = L21
L22s = L22
L23s = L23
L24s = L24
L31s = L31
L32s = L32
L33s = L33
L34s = L34
L35s = L35
Main:
Disable Aci
If D > 10 Then
   If M = 1 Then
      If D =< L11s Then
         Gosub Control11
      Elseif D >= L12s Then
         Gosub Control12
      End If
   Elseif M = 2 Then
      If D =< L21s And D > L22s Then
         Gosub Control21
      Elseif D =< L22s Then
         Gosub Control22
      Elseif D >= L23s And D < L24s Then
         Gosub Control23
      Elseif D >= L24s Then
         Gosub Control24
      End If
   Else
      If D =< L31s And D > L32s Then
         Gosub Control31
      Elseif D =< L32s Then
         Gosub Control32
      Elseif D >= L33s And D < L34s Then
         Gosub Control33
      Elseif D >= L34s And D < L35s Then
         Gosub Control34
      Elseif D >= L35s Then
         Gosub Control35
      End If
   End If
End If
Waitms 250
Timer1 = 0
X = 0
Set Portc.0
'Start Timer1
Do
   Waitus 1
   Waitus 1
   Waitus 1
   Waitus 1
   Waitus 1
   Waitus 1
   Waitus 1
   Waitus 1
   Waitus 1
   Waitus 1
   Toggle Portc.0
   Incr X
Loop Until X = 40
Start Timer1
'Waitus 20
Enable Aci
Do
If Timer1 >= 65500 Then Goto Main
If X >= 41 Then Goto Main
Loop

'---------- END PROCESS ------------------------------------------------------------
Finish:
End

'---------- INTERRUPT SERVICE ROUTINES (ISR) ------------------------------------------------------------
Control:
Stop Timer1
T1 = Timer1
D = T1 * 0.011
If D > 10 Then
   Locate 2 , 1
   Lcd T1
   Locate 2 , 6
   Lcd "cm         "
End If
Incr X
'Waitms 150
Return
Control11:
If C = 0 Then
   Reset Portc.1
   Locate 1 , 1
   Lcd "CONT>HOLD GREEN"
   P = 0
   Do
      Set Portc.6
      Sound Portd.6 , 1000 , 500
      Reset Portc.6
      Debounce Pind.0 , 1 , Continue1
      Re1:
      Wait 1
      Debounce Pind.0 , 1 , Continue1
   Loop
   Continue1:
   If P = 1 Then
      P = 0
      Goto Re1
   End If
   Set Portd.6
   Set Portc.3
   Locate 1 , 1
   Lcd "                "
   Locate 1 , 1
   Lcd "MIXING"
   Re2:
   Wait 5
   P = 0
   Bitwait Pind.0 , Set
   If P = 1 Then Goto Re2
   Reset Portc.5
   Reset Portc.3
   Locate 1 , 1
   Lcd "CONT>HOLD GREEN"
   P = 0
   Do
      Set Portc.6
      Sound Portd.6 , 1000 , 500
      Reset Portc.6
      Debounce Pind.0 , 1 , Continue2
      Re3:
      Wait 1
      Debounce Pind.0 , 1 , Continue2
   Loop
   Continue2:
   If P = 1 Then
      P = 0
      Goto Re3
   End If
   Set Portc.4
   Locate 1 , 1
   Lcd "                "
   Locate 1 , 1
   Lcd "DISCHARGING"
   Incr C
End If
Return
Control12:
If C = 1 Then
   Reset Portc.4
   Locate 1 , 1
   Lcd "           "
   Locate 1 , 1
   Lcd "FINISHED"
   Goto Finish
End If
Return
Control21:
If C = 0 Then
   Reset Portc.1
   Locate 1 , 1
   Lcd "              "
   Wait 5
   Set Portc.2
   Locate 1 , 1
   Lcd "CHARGING MASH"
   Incr C
End If
Return
Control22:
If C = 1 Then
   Reset Portc.2
   Locate 1 , 1
   Lcd "CONT>HOLD GREEN"
   P = 0
   Do
      Set Portc.6
      Sound Portd.6 , 1000 , 500
      Reset Portc.6
      Debounce Pind.0 , 1 , Continue3
      Re4:
      Wait 1
      Debounce Pind.0 , 1 , Continue3
   Loop
   Continue3:
   If P = 1 Then
      P = 0
      Goto Re4
   End If
   Set Portd.6
   Set Portc.3
   Locate 1 , 1
   Lcd "                "
   Locate 1 , 1
   Lcd "MIXING"
   Wait 60
   Reset Portc.3
   Locate 1 , 1
   Lcd "CONT>HOLD GREEN"
   P = 0
   Do
      Set Portc.6
      Sound Portd.6 , 1000 , 500
      Reset Portc.6
      Debounce Pind.0 , 1 , Continue4
      Re5:
      Wait 1
      Debounce Pind.0 , 1 , Continue4
   Loop
   Continue4:
   If P = 1 Then
      P = 0
      Goto Re5
   End If
   Set Portc.4
   Locate 1 , 1
   Lcd "                "
   Locate 1 , 1
   Lcd "DISCHARGING"
   Incr C
End If
Return
Control23:
If C = 2 Then
   Reset Portc.4
   Locate 1 , 1
   Lcd "CONT>HOLD GREEN"
   P = 0
   Do
      Set Portc.6
      Sound Portd.6 , 1000 , 500
      Reset Portc.6
      Debounce Pind.0 , 1 , Continue5
      Re6:
      Wait 1
      Debounce Pind.0 , 1 , Continue5
   Loop
   Continue5:
   If P = 1 Then
      P = 0
      Goto Re6
   End If
   Set Portd.6
   Set Portc.4
   Locate 1 , 1
   Lcd "                "
   Locate 1 , 1
   Lcd "DISCHARGING"
   Incr C
End If
Return
Control24:
If C = 3 Then
   Reset Portc.4
   Locate 1 , 1
   Lcd "           "
   Locate 1 , 1
   Lcd "FINISHED"
   Goto Finish
End If
Return
Control31:
If C = 0 Then
   Reset Portc.1
   Locate 1 , 1
   Lcd "              "
   Wait 5
   Set Portc.2
   Locate 1 , 1
   Lcd "CHARGING MASH"
   Incr C
End If
Return
Control32:
If C = 1 Then
   Reset Portc.2
   Locate 1 , 1
   Lcd "CONT>HOLD GREEN"
   P = 0
   Do
      Set Portc.6
      Sound Portd.6 , 1000 , 500
      Reset Portc.6
      Debounce Pind.0 , 1 , Continue6
      Re7:
      Wait 1
      Debounce Pind.0 , 1 , Continue6
   Loop
   Continue6:
   If P = 1 Then
      P = 0
      Goto Re7
   End If
   Set Portd.6
   Set Portc.3
   Locate 1 , 1
   Lcd "                "
   Locate 1 , 1
   Lcd "MIXING"
   Wait 60
   Reset Portc.3
   Locate 1 , 1
   Lcd "CONT>HOLD GREEN"
   P = 0
   Do
      Set Portc.6
      Sound Portd.6 , 1000 , 500
      Reset Portc.6
      Debounce Pind.0 , 1 , Continue7
      Re8:
      Wait 1
      Debounce Pind.0 , 1 , Continue7
   Loop
   Continue7:
   If P = 1 Then
      P = 0
      Goto Re8
   End If
   Set Portc.4
   Locate 1 , 1
   Lcd "                "
   Locate 1 , 1
   Lcd "DISCHARGING"
   Incr C
End If
Return
Control33:
If C = 2 Then
   Reset Portc.4
   Locate 1 , 1
   Lcd "CONT>HOLD GREEN"
   P = 0
   Do
      Set Portc.6
      Sound Portd.6 , 1000 , 500
      Reset Portc.6
      Debounce Pind.0 , 1 , Continue8
      Re9:
      Wait 1
      Debounce Pind.0 , 1 , Continue8
   Loop
   Continue8:
   If P = 1 Then
      P = 0
      Goto Re9
   End If
   Set Portd.6
   Set Portc.4
   Locate 1 , 1
   Lcd "                "
   Locate 1 , 1
   Lcd "DISCHARGING"
   Incr C
End If
Return
Control34:
If C = 3 Then
   Reset Portc.4
   Locate 1 , 1
   Lcd "CONT>HOLD GREEN"
   P = 0
   Do
      Set Portc.6
      Sound Portd.6 , 1000 , 500
      Reset Portc.6
      Debounce Pind.0 , 1 , Continue9
      Re10:
      Wait 1
      Debounce Pind.0 , 1 , Continue9
   Loop
   Continue9:
   If P = 1 Then
      P = 0
      Goto Re10
   End If
   Set Portd.6
   Set Portc.4
   Locate 1 , 1
   Lcd "                "
   Locate 1 , 1
   Lcd "DISCHARGING"
   Incr C
End If
Return
Control35:
If C = 4 Then
   Reset Portc.4
   Locate 1 , 1
   Lcd "           "
   Locate 1 , 1
   Lcd "FINISHED"
   Goto Finish
End If
Return
Pause:
Set Portc.7
Bitwait Pind.0 , Set
Reset Portc.7
P = 1
Return

'---------- DATA TABLES ------------------------------------------------------------
Data1:
Data 1% , 2% , 3% , % , 4% , 5% , 6% , % , 7% , 8% , 9% , % , % , 0% , % , %