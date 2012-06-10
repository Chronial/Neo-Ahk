;*********************
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



*z::
if (isMod4Active and !isMod3Pressed) {
	Send {Blind}{Ctrl DownTemp}{z DownTemp}
	key_z_down_mod := 1
} else {
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

; Do not change anything within this block by hand
; the contents should be genareted by helper.py
; *************************************** Begin Auto-Generate ***********************************

*x::
if (isMod4Active and !isMod3Pressed) {
	Send {Blind}{PGUP DownTemp}
	key_x_down_mod := 1
} else {
	Send {Blind}{x DownTemp}
	key_x_down := 1
}
return

*x up::
if (key_x_down){
    Send {Blind}{x up}
    key_x_down := 0
}
if (key_x_down_mod){
    Send {Blind}{PGUP up}
    key_x_down_mod := 0
}
return


*v::
if (isMod4Active and !isMod3Pressed) {
	Send {Blind}{BACKSPACE DownTemp}
	key_v_down_mod := 1
} else {
	Send {Blind}{v DownTemp}
	key_v_down := 1
}
return

*v up::
if (key_v_down){
    Send {Blind}{v up}
    key_v_down := 0
}
if (key_v_down_mod){
    Send {Blind}{BACKSPACE up}
    key_v_down_mod := 0
}
return


*l::
if (isMod4Active and !isMod3Pressed) {
	Send {Blind}{UP DownTemp}
	key_l_down_mod := 1
} else {
	Send {Blind}{l DownTemp}
	key_l_down := 1
}
return

*l up::
if (key_l_down){
    Send {Blind}{l up}
    key_l_down := 0
}
if (key_l_down_mod){
    Send {Blind}{UP up}
    key_l_down_mod := 0
}
return


*c::
if (isMod4Active and !isMod3Pressed) {
	Send {Blind}{DEL DownTemp}
	key_c_down_mod := 1
} else {
	Send {Blind}{c DownTemp}
	key_c_down := 1
}
return

*c up::
if (key_c_down){
    Send {Blind}{c up}
    key_c_down := 0
}
if (key_c_down_mod){
    Send {Blind}{DEL up}
    key_c_down_mod := 0
}
return


*w::
if (isMod4Active and !isMod3Pressed) {
	Send {Blind}{PGDN DownTemp}
	key_w_down_mod := 1
} else {
	Send {Blind}{w DownTemp}
	key_w_down := 1
}
return

*w up::
if (key_w_down){
    Send {Blind}{w up}
    key_w_down := 0
}
if (key_w_down_mod){
    Send {Blind}{PGDN up}
    key_w_down_mod := 0
}
return


*u::
if (isMod4Active and !isMod3Pressed) {
	Send {Blind}{HOME DownTemp}
	key_u_down_mod := 1
} else {
	Send {Blind}{u DownTemp}
	key_u_down := 1
}
return

*u up::
if (key_u_down){
    Send {Blind}{u up}
    key_u_down := 0
}
if (key_u_down_mod){
    Send {Blind}{HOME up}
    key_u_down_mod := 0
}
return


*i::
if (isMod4Active and !isMod3Pressed) {
	Send {Blind}{LEFT DownTemp}
	key_i_down_mod := 1
} else {
	Send {Blind}{i DownTemp}
	key_i_down := 1
}
return

*i up::
if (key_i_down){
    Send {Blind}{i up}
    key_i_down := 0
}
if (key_i_down_mod){
    Send {Blind}{LEFT up}
    key_i_down_mod := 0
}
return


*a::
if (isMod4Active and !isMod3Pressed) {
	Send {Blind}{DOWN DownTemp}
	key_a_down_mod := 1
} else {
	Send {Blind}{a DownTemp}
	key_a_down := 1
}
return

*a up::
if (key_a_down){
    Send {Blind}{a up}
    key_a_down := 0
}
if (key_a_down_mod){
    Send {Blind}{DOWN up}
    key_a_down_mod := 0
}
return


*e::
if (isMod4Active and !isMod3Pressed) {
	Send {Blind}{RIGHT DownTemp}
	key_e_down_mod := 1
} else {
	Send {Blind}{e DownTemp}
	key_e_down := 1
}
return

*e up::
if (key_e_down){
    Send {Blind}{e up}
    key_e_down := 0
}
if (key_e_down_mod){
    Send {Blind}{RIGHT up}
    key_e_down_mod := 0
}
return


*o::
if (isMod4Active and !isMod3Pressed) {
	Send {Blind}{END DownTemp}
	key_o_down_mod := 1
} else {
	Send {Blind}{o DownTemp}
	key_o_down := 1
}
return

*o up::
if (key_o_down){
    Send {Blind}{o up}
    key_o_down := 0
}
if (key_o_down_mod){
    Send {Blind}{END up}
    key_o_down_mod := 0
}
return


*ü::
if (isMod4Active and !isMod3Pressed) {
	Send {Blind}{ESC DownTemp}
	key_ü_down_mod := 1
} else {
	Send {Blind}{ü DownTemp}
	key_ü_down := 1
}
return

*ü up::
if (key_ü_down){
    Send {Blind}{ü up}
    key_ü_down := 0
}
if (key_ü_down_mod){
    Send {Blind}{ESC up}
    key_ü_down_mod := 0
}
return


*ö::
if (isMod4Active and !isMod3Pressed) {
	Send {Blind}{TAB DownTemp}
	key_ö_down_mod := 1
} else {
	Send {Blind}{ö DownTemp}
	key_ö_down := 1
}
return

*ö up::
if (key_ö_down){
    Send {Blind}{ö up}
    key_ö_down := 0
}
if (key_ö_down_mod){
    Send {Blind}{TAB up}
    key_ö_down_mod := 0
}
return


*ä::
if (isMod4Active and !isMod3Pressed) {
	Send {Blind}{INS DownTemp}
	key_ä_down_mod := 1
} else {
	Send {Blind}{ä DownTemp}
	key_ä_down := 1
}
return

*ä up::
if (key_ä_down){
    Send {Blind}{ä up}
    key_ä_down := 0
}
if (key_ä_down_mod){
    Send {Blind}{INS up}
    key_ä_down_mod := 0
}
return


*p::
if (isMod4Active and !isMod3Pressed) {
	Send {Blind}{ENTER DownTemp}
	key_p_down_mod := 1
} else {
	Send {Blind}{p DownTemp}
	key_p_down := 1
}
return

*p up::
if (key_p_down){
    Send {Blind}{p up}
    key_p_down := 0
}
if (key_p_down_mod){
    Send {Blind}{ENTER up}
    key_p_down_mod := 0
}
return
; *************************************** End of Auto-Generate ***********************************


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

