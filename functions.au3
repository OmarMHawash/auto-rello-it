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
    $tf = 5
  Else
    $tf = 2
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
  Sleep($xxxl * $tf * 1.8)
  ;---- Board Opened! ----;
  if $status = "warm_up" Then
    killChrome()
  EndIf

EndFunc

Func clickWaitScreen($posX, $posY, $actX, $actY)
  $old_screen = PixelGetColor($posX, $posY)
  $new_screen = $old_screen
  Sleep($m)
  MouseClick($MOUSE_CLICK_LEFT, $actX, $actY, 1)
  Sleep($m)

  While True
    If $old_screen = $new_screen Then
      $new_screen = PixelGetColor($posX, $posY)
      Sleep($m)
    Else
      ExitLoop
    EndIf
  WEnd
  Sleep($l)
EndFunc

Func saveCardData()
  tabs(3)
  copyAllBox()
  $title = '"' & ClipGet() & '"'
  Sleep($m)

  tabs(3)
  Send("{ENTER}")
  Sleep($m)
  copyAllBox()
  $desc = '"' & ClipGet() & '"'
  $desc = removeLF($desc)

  $doc = $title & ", " & $desc
  file_write($doc)
  ESCs(2)
EndFunc

Func killChrome()
  Send("{CTRLDOWN}w{CTRLUP}")
EndFunc

Func moveCardX($xPos, $yPos, $width)
  $mf = 20
  MouseMove($xPos, $yPos)
  Sleep($s) 
  MouseDown("left")
  Sleep($s)
  MouseMove($xPos+$width, $yPos-$mf)
  MouseUp("left")
  Sleep($s)
EndFunc

Func tabs($num)
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

Func removeLF($str)
  $str = StringReplace($str, @CRLF, "\n")
  $str = StringReplace($str, @LF, "\n")
  Sleep($s)
  Return $str
EndFunc