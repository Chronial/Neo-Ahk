﻿;*********************
; Anfangsbedingungen *
;*********************
name=Neo 2.0 (Erweiterung für nativen Treiber)
enable=Aktiviere %name%
disable=Deaktiviere %name%
#usehook on
SetKeyDelay -1
#LTrim

; *** Benutze Bilder, wenn sie im aktuellen Verzeichnis vorhanden sind ***
FileInstall,neo_enabled.ico,neo_enabled.ico,1
FileInstall,neo_disabled.ico,neo_disabled.ico,1
FileInstall,ebene1.png,ebene1.png,1
FileInstall,ebene2.png,ebene2.png,1
FileInstall,ebene3.png,ebene3.png,1
FileInstall,ebene4.png,ebene4.png,1
FileInstall,ebene5.png,ebene5.png,1
FileInstall,ebene6.png,ebene6.png,1
if (FileExist("ebene1.png")&&FileExist("ebene2.png")&&FileExist("ebene3.png")&&FileExist("ebene4.png")&&FileExist("ebene5.png")&&FileExist("ebene6.png"))
  zeigeBildschirmTastatur = 1
if (FileExist("neo_enabled.ico")&&FileExist("neo_disabled.ico"))
  iconBenutzen=1


;*************************
; Menü des Systray-Icons *
;*************************
if (iconBenutzen)
  menu,tray,icon,neo_enabled.ico,,1
menu,tray,nostandard
menu,tray,add,AHK öffnen,open
  menu,helpmenu,add,Info,about
  menu,helpmenu,add
  menu,helpmenu,add,http://autohotkey.com/,autohotkey
  menu,helpmenu,add,http://www.neo-layout.org/,neo
menu,tray,add,Hilfe,:helpmenu
menu,tray,add
menu,tray,add,%disable%,togglesuspend
menu,tray,add
menu,tray,add,Skript bearbeiten,edit
menu,tray,add,Skript neu laden,reload
menu,tray,add,Bildschirmtastatur umschalten,Show
menu,tray,add
menu,tray,add,Nicht im Systray anzeigen,hide
menu,tray,add,%name% beenden,exitprogram
menu,tray,default,%disable%
menu,tray,tip,%name%


;******************
; Initialisierung *
;******************
isShiftRPressed := 0
isShiftLPressed := 0
isShiftPressed := 0
isMod2Locked := 0
isMod3RPressed := 0
isMod3LPressed := 0
isMod3Pressed := 0
isMod4RPressed := 0
isMod4LPressed := 0
isMod4Pressed := 0
isMod4Locked := 0
isMod4Active := 0
Ebene := 1


goto mapkeys

;***********************
; Fehlende Funktionen  *
;***********************
; *** benötigte Modifier werden gehookt ***
~*SC136::
  if (isShiftLPressed and !isShiftRPressed)
  ToggleMod2Lock()
  isShiftRPressed := 1
  isShiftPressed := 1
  goto modeToggled
return

~*SC136 up::
  isShiftRPressed := 0
  isShiftPressed := isShiftLPressed
  goto modeToggled
return

~*SC02A::
  if (isShiftRPressed and !isShiftLPressed)
  ToggleMod2Lock()
  isShiftLPressed := 1
  isShiftPressed := 1
  goto modeToggled
return

~*SC02A up::
  isShiftLPressed := 0
  isShiftPressed := isShiftRPressed
  goto modeToggled
return

~*SC02B::
  isMod3RPressed := 1
  isMod3Pressed := 1
  goto modeToggled
return

~*SC02B up::
  isMod3RPressed := 0
  isMod3Pressed := isMod3LPressed
  goto modeToggled
return

~*SC03A::
  isMod3LPressed := 1
  isMod3Pressed := 1
  goto modeToggled
return

~*SC03A up::
  isMod3LPressed := 0
  isMod3Pressed := isMod3RPressed
  goto modeToggled
return

~*SC138::
  if (isMod4LPressed and !isMod4RPressed)
   ToggleMod4Lock()
  isMod4RPressed := 1
  isMod4Pressed := 1
  doMod4()
  goto modeToggled
return

~*SC138 up::
  isMod4RPressed := 0
  isMod4Pressed := isMod4LPressed
  doMod4()
  goto modeToggled
return

~*SC056::
  if (isMod4RPressed and !isMod4LPressed)
   ToggleMod4Lock()
  isMod4LPressed := 1
  isMod4Pressed := 1
  doMod4()
  goto modeToggled
return
	
~*SC056 up::
  isMod4LPressed := 0
  isMod4Pressed := isMod4RPressed
  doMod4()
  goto modeToggled
return

; *** Welcher Modifier ist aktiv und CapsLock und Mod4Lock ***
ToggleMod2Lock() {
  global
  if (isMod2Locked)
  {
    isMod2Locked := 0
    SetCapslockState off
  }
  else
  {
    isMod2Locked := 1
    SetCapslockState on
  }
}

ToggleMod4Lock() {
  global
  if (isMod4Locked)
  {
   isMod4Locked := 0
   send {vk15}
  }
  else
  {
   isMod4Locked := 1
   send {vk15}
  }
}

doMod4() {
  global
  if (isMod4Locked)
  {
    if (isMod4Pressed)
      isMod4Active := 0
    else
      isMod4Active := 1
  }
  else
  {
    if (isMod4Pressed)
      isMod4Active := 1
    else
      isMod4Active := 0
  }
}

; *** Funktionstasten ***

*x::
*x up::
*v::
*v up::
*l::
*l up::
*c::
*c up::
*w::
*w up::
*u::
*u up::
*i::
*i up::
*a::
*a up::
*e::
*e up::
*o::
*o up::
*ü::
*ü up::
*ö::
*ö up::
*ä::
*ä up::
*p::
*p up::

goto allstarhook
return

mapkeys:
    CMCP4x = pgup
    CMCP4v = backspace
    CMCP4l = up
    CMCP4c = del
    CMCP4w = pgdn

    CMCP4u = home
    CMCP4i = left
    CMCP4a = down
    CMCP4e = right
    CMCP4o = end

    CMCP4ü = esc
    CMCP4ö = tab
    CMCP4ä = ins
    CMCP4p = enter
    
    AllLayers("NumLock","tab","tab","=","≠","≈","≡") ; NumLock
    AllLayers("NumpadDiv","NumpadDiv","NumpadDiv","÷","⌀","∣","⁄") ; NumpadDiv
    AllLayers("NumpadMult","NumpadMult","NumpadMult","⋅","×","⊙","⊗") ; NumpadMult
    AllLayers("NumpadSub","NumpadSub","NumpadSub","−","∖","⊖","∸") ; NumpadSub
    AllLayers("NumpadAdd","NumpadAdd","NumpadAdd","±","∓","⊕","∔") ; NumpadAdd

    AllLayers("Numpad7","Numpad7","✔","↕","NumpadHome","≪","⌈") ; Numpad7
    AllLayers("Numpad8","Numpad8","✘","↑","NumpadUp","∩","⋂") ; Numpad8
    AllLayers("Numpad9","Numpad9","†","⃗","NumpadPgUp","≫","⌉") ; Numpad9
    AllLayers("Numpad4","Numpad4","♣","←","NumpadLeft","⊂","⊆") ; Numpad4
    AllLayers("Numpad5","Numpad5","€",":","LButton","⊶","⊷") ; Numpad5
    AllLayers("Numpad6","Numpad6","‣","→","NumpadRight","⊃","⊇") ; Numpad6
    AllLayers("Numpad1","Numpad1","♦","↔","NumpadEnd","≤","⌊") ; Numpad1
    AllLayers("Numpad2","Numpad2","♥","↓","NumpadDown","∪","⋃") ; Numpad2
    AllLayers("Numpad3","Numpad3","♠","⇌","NumpadPgDn","≥","⌋") ; Numpad3
    AllLayers("Numpad0","Numpad0","␣","%","NumpadIns","‰","□") ; Numpad0
    AllLayers("NumpadDot","NumpadDot",".",",","NumpadDel","′","″") ; NumpadDot

    RemapKey("NumpadIns", "Numpad0")
    RemapKey("NumpadEnd", "Numpad1")
    RemapKey("NumpadDown", "Numpad2")
    RemapKey("NumpadPgDn", "Numpad3")
    RemapKey("NumpadLeft", "Numpad4")
    RemapKey("NumpadClear", "Numpad5")
    RemapKey("NumpadRight", "Numpad6")
    RemapKey("NumpadHome", "Numpad7")
    RemapKey("NumpadUp", "Numpad8")
    RemapKey("NumpadPgUp", "Numpad9")
    RemapKey("NumpadDel", "NumpadDot")
return

AllLayers(key, e1, e2, e3, e4, e5, e6){
    global
    dnkey := "*" . key
    upkey := dnkey . " up"
    Hotkey,% dnkey,allstarhook
    Hotkey,% upkey,allstarhook
    CMCP1%key% := e1
    CMCP2%key% := e2
    CMCP3%key% := e3
    CMCP4%key% := e4
    CMCP5%key% := e5
    CMCP6%key% := e6
}

RemapKey(key, target){
    global
    dnkey := "*" . key
    upkey := dnkey . " up"
    Hotkey,% dnkey,allstarhook
    Hotkey,% upkey,allstarhook
    KRM%key% := target
}


allstarhook:
    AllStar(a_thishotkey)
return

AllStar(This_HotKey) {
    global
    ;MsgBox %CMCP2Numpad4%
    PhysKey := This_HotKey
    if (SubStr(PhysKey,1,1) == "*")
        PhysKey := SubStr(PhysKey,2)
    if (SubStr(PhysKey,-2) == " up") {
        PhysKey := SubStr(PhysKey,1,StrLen(PhysKey)-3)
        IsDown := 0
    } else
        IsDown := 1
    RealEbene := Ebene
    if (KRM%PhysKey% != ""){
        PhysKey := KRM%PhysKey%
        if (isMod3Pressed) {
            RealEbene := 5
        } else {
            RealEbene := 2
        }
    }

    Char = CP%RealEbene%%PhysKey%
    if (IsDown == 1) {
        ;MsgBox % This_HotKey . " -> " . PhysKey . " -> " . Char . " ---> " . "%CM" . Char . ": " . CM%Char%
        CharStarDown(PhysKey, Char)
    } else {
        CharStarUp(PhysKey)
    }
}

CharStarDown(PhysKey, Char) {
    global
    if (CM%Char% != "") {
        tosend := CM%Char%
    } else {
        tosend := PhysKey
    }
    
    if (PR%PhysKey% != "" && PR%PhysKey% != tosend){
        CharOutUp(PR%PhysKey%)
    }
    
    ;MsgBox CM%Char%
    ;MsgBox %tosend%
    CharOutDown(tosend)
    PR%PhysKey% := tosend
}

CharStarUp(PhysKey) {
    global
    if (PR%PhysKey% != "") {
        tosend := PR%PhysKey%
        PR%PhysKey% := ""
        CharOutUp(tosend)
    }
}

CharOutDown(char){
    send % "{blind}{" . char . " DownTemp}"
}

CharOutUp(char){
    send % "{blind}{" . char . " Up}"
}

*z::
if (isMod4Active and !isMod3Pressed) {
    if (key_z_down){
        Send {Blind}{z up}
        key_z_down := 0
    }
	Send {Blind}{Ctrl DownTemp}{z DownTemp}
	key_z_down_mod := 1
} else {
    if (key_z_down_mod){
        Send {Blind}{Ctrl Up}{z Up}
        key_z_down_mod := 0
    }
	Send {Blind}{z DownTemp}
	key_z_down := 1
}
return

*z up::
if (key_z_down_mod){
    Send {Blind}{Ctrl Up}{z Up}
    key_z_down_mod := 0
}
if (key_z_down){
    Send {Blind}{z up}
    key_z_down := 0
}
return


;*****************
; Menüfunktionen *
;*****************
togglesuspend:
  if A_IsSuspended {
    menu,tray,rename,%enable%,%disable%
    menu,tray,tip,%name%
    if (iconBenutzen)
      menu,tray,icon,neo_enabled.ico,,1
    suspend,off ; Schaltet Suspend aus
  } else {
    menu,tray,rename,%disable%, %enable%
    menu,tray,tip,%name% : Deaktiviert
    if (iconBenutzen)
      menu,tray,icon,neo_disabled.ico,,1
    suspend,on ; Schaltet Suspend ein
  } return

about:
  msgbox, 64, NEO 2.0 – Ergonomische Tastaturbelegung, 
  (
  %name% 
  `nDas Neo-Layout ist ein alternatives deutsches Tastaturlayout
  Näheres finden Sie unter http://neo-layout.org/. 
  `nDieses Skript erweitert den nativen Tastaturtreiber um 
  einige fehlende Funktionen.
  )
return

neo:
  run http://neo-layout.org/
return

autohotkey:
  run http://autohotkey.com/
return

open:
  ListLines ; shows the Autohotkey window
return

edit:
  edit
return

reload:
  Reload
return

hide:
  menu, tray, noicon
return

exitprogram:
  exitapp
return


;*********************
; BildschirmTastatur *
;*********************
guiErstellt = 0
alwaysOnTop = 1
showingShift = 0
showShiftTimer = 0

showShift:
showingShift = 1
showShiftTimer = 0
goto modeToggled
return

modeToggled:
    if ((isMod3Pressed) && (isMod4Pressed || isMod4Locked)) {
        Ebene := 6
    } else if ((isMod3Pressed) && (isShiftPressed || isMod2Locked)) {
        Ebene := 5
    } else if (isMod4Active) {
        Ebene := 4
    } else if (isMod3Pressed) {
        Ebene := 3
    } else if (isShiftPressed || isMod2Locked) {
        Ebene := 2
    } else {
        Ebene := 1
    }

  if (isShiftPressed && !showingShift && !showShiftTimer){
    SetTimer, showShift, -500
    showShiftTimer = 1
  } else if (!isShiftPressed){
    SetTimer, showShift, Off
    showShiftTimer = 0
    showingShift = 0
  }
  
  if (guiErstellt) {
    if ((isMod3Pressed) && (isMod4Pressed || isMod4Locked)) {
      goto Switch6
    } else if ((isMod3Pressed) && (isShiftPressed || isMod2Locked)) {
      goto Switch5
    } else if (isMod4Active) {
      goto Switch4
    } else if (isMod3Pressed) {
      goto Switch3
    } else if (showingShift || isMod2Locked) {
      goto Switch2
    } else {
      goto Switch1
    }
  }
return

SplashOff:
  SplashTextOff
return

*F7::
  if (isMod4Pressed&&zeigeBildschirmTastatur)
    goto Show
  else send {blind}{F7}
return

*F8::
  if (isMod4Pressed&&zeigeBildschirmTastatur)
    goto ToggleAlwaysOnTop
  else send {blind}{F8}
return

Switch1:
  tImage := "ebene1.png"
  goto Switch
Return

Switch2:
  tImage := "ebene2.png"
  goto Switch
Return

Switch3:
  tImage := "ebene3.png"
  goto Switch
Return

Switch4:
  tImage := "ebene4.png"
  goto Switch
Return

Switch5:
  tImage := "ebene5.png"
  goto Switch
Return

Switch6:
  tImage := "ebene6.png"
  goto Switch
Return

Switch:
  if guiErstellt {
    if (Image = tImage) {
      ;goto Close
    } else {
      Image := tImage
      SetTimer, Refresh
    }
  } else {
    Image := tImage
    goto Show    
  }
Return

Show:
  if guiErstellt {
     goto Close
  } else {
    if (Image = "") {
      Image := "ebene1.png"
    }     
    yPosition := A_ScreenHeight -270
    Gui,Color,FFFFFF
    Gui,Add,Picture,  AltSubmit BackgroundTrans xm ym vPicture,%Image% ;
    Gui,+AlwaysOnTop
    Gui +LastFound
    WinSet, TransColor, FFFFFF
    Gui -Caption +ToolWindow 
    Gui,Show,NA y%yposition% Autosize
    OnMessage(0x201, "WM_LBUTTONDOWN")
    OnMessage(0x203, "WM_LBUTTONDBLCLK")
    guiErstellt = 1
  } 
Return

WM_LBUTTONDOWN()
{
   PostMessage, 0xA1, 2
}

WM_LBUTTONDBLCLK()
{
   SetTimer, Close, -1
}

Close:
  guiErstellt = 0
  Gui,Destroy
Return

Refresh:
  If (Image != OldImage) {
    GuiControl,,Picture,%Image%
    OldImage := Image
  }
Return

ToggleAlwaysOnTop:
  if alwaysOnTop {
    Gui, -AlwaysOnTop
    alwaysOnTop = 0    
  } else {
    Gui, +AlwaysOnTop
    alwaysOnTop = 1
  }
Return

