
HotKeySet("{F10}", "Quit")
Func Quit()
  Exit
EndFunc

Func file_write($record)
  If $iFileExists Then
    FileWriteLine(@WorkingDir & $file_name, $record)
  EndIf
EndFunc

Func initTrello($status)
  If $status = "warm_up" Then
    $tf = 4
  Else
    $tf = 0.8
  EndIf

  Send("{LWINDOWN}{m down}{m up}{LWINUP}") ; minimize all windows	
  RunWait(@ComSpec & " /c " & $start_chrome) 
  Sleep($m*$tf)
  Send("{CTRLDOWN}n{CTRLUP}")
  Sleep($m*$tf)
  Send("{LWINDOWN}{LEFT}{LWINUP}")
  Sleep($m*$tf)
  Send("{Esc}")
  Send($board_url)
  Send("{ENTER}")
  waitScreen(22, 1000)
  Sleep($xxl * $tf )
  ;---- Board Opened! ----;
  if $status = "warm_up" Then
    killChrome()
  EndIf

EndFunc

Func clickWaitScreen($waitX, $waitY, $clickX, $clickY)
  $old_screen = PixelGetColor($waitX, $waitY)
  $new_screen = $old_screen
  Sleep($m)
  MouseClick($MOUSE_CLICK_LEFT, $clickX, $clickY, 1)
  Sleep($m)

  While True
    If $old_screen = $new_screen Then
      $new_screen = PixelGetColor($waitX, $waitY)
      ToolTip("Waiting...")
      Sleep($m)
    Else
      ToolTip("")
      ExitLoop
    EndIf
  WEnd
  Sleep($l)
EndFunc

Func waitScreen($waitX, $waitY)
  $old_screen = PixelGetColor($waitX, $waitY)
  $new_screen = $old_screen
  Sleep($m)

  While True
    If $old_screen = $new_screen Then
      $new_screen = PixelGetColor($waitX, $waitY)
      ToolTip("Waiting...")
      Sleep($m)
    Else
      ToolTip("")
      ExitLoop
    EndIf
  WEnd
  Sleep($l)
EndFunc

Func saveCardData()
  $tf = 0.8
  TABs(3)
  copyAllBox()
  $title = '"' & ClipGet() & '"'
  Sleep($m * $tf)

  TABs(3)
  Send("{ENTER}")
  Sleep($m * $tf)
  copyAllBox()
  $desc = '"' & ClipGet() & '"'
  $desc = sanitDesc($desc)

  $doc = $title & ", " & $desc
  file_write($doc)
  ESCs(2)
EndFunc

Func killChrome()
  Send("{CTRLDOWN}w{CTRLUP}")
EndFunc

Func moveCardX($xPos, $yPos, $width)
  $fixOffset = 20
  MouseMove($xPos, $yPos, 1)
  ; Sleep($s) 
  MouseDown("left")
  ; Sleep($s)
  MouseMove($xPos+$width, $yPos-$fixOffset,1)
  MouseUp("left")
  ; Sleep($s)
EndFunc

Func TABs($num)
  For $i = 1 To $num
    Send("{TAB}")
  Next
EndFunc

Func copyAllBox()
  Send("{CTRLDOWN}a{CTRLUP}")
  Send("{CTRLDOWN}c{CTRLUP}")
  Sleep($s)
EndFunc

Func ESCs($num)
  For $i = 1 To $num
    Send("{ESC}")
  Next
  Sleep($s)
EndFunc

Func sanitDesc($str)
  $str = StringReplace($str, @CRLF, "\n")
  $str = StringReplace($str, @LF, "\n")
  $str = StringReplace($str, ',', "0x2C")
  Sleep($s)
  Return $str
EndFunc