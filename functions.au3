
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

Func saveCardData($idx)
  $tf = 0.8
  Global $gId = $idx
  $id = '"' & $idx & '"'
  TABs(3)
  copyAllBox()
  Global $gTitle = ClipGet()
  $title = '"' & ClipGet() & '"'
  Sleep($m * $tf)

  TABs(3)
  Send("{ENTER}")
  Sleep($m * $tf)
  copyAllBox()
  $desc = '"' & ClipGet() & '"'
  $desc = sanitDesc($desc)

  $doc = $id & "," & $title & ", " & $desc
  file_write($doc)

  Sleep($s * $tf)
  saveImages()

  Sleep($m * $tf)
  ESCs(2)
EndFunc

Func SavingSleepTimer($x,$y,$mustBe)
    For $i = 1 To 1 Step 1
      $checkCurrent = PixelGetColor($x,$y)
      If $checkCurrent=$mustBe Then
      Else
        $i=$i-1
        Sleep(50)
      EndIf
    Next
	Sleep(50)
EndFunc

Func msgBoxNext()
  $msg = MsgBox(4, "go ahead and save one image", "Click Yes when you are done")
  $file_bar = true
  If $msg = 6 Then
    Return True
  Else
    Return False
  EndIf
  
EndFunc

Func saveImages()
  TABs(4)
  Send("{ENTER}")
  ; if $file_bar = false Then
  ;   msgBoxNext()
  ; EndIf
  saveXImage()
  ; todo: make that a loop
  ; $getArrow = $arrow_color
  ; While ($getArrow = $arrow_color)
  ;   Send("{RIGHT}")
  ;   saveXImage()
  ;   Sleep(200)
  ; WEnd
  ; ToolTip("Finished Saving Images")
  ; Sleep(200)
  ; ToolTip("looK!" & $getArrow)
  ; Sleep(50000)
EndFunc

Func saveXImage()
  $imgIdx = 1
  MouseClick($MOUSE_CLICK_RIGHT, 470, 200, 1)
  Sleep($m)
  MouseClick($MOUSE_CLICK_LEFT, 500, 236, 1)
  Sleep($l)
  ; $getArrow = PixelGetColor($arrow[0], $arrow[1])
  copyAllBox() 
  $currName = ClipGet()
  $ext = StringSplit($currName, ".")
  Sleep($l)
  Global $imgName = $gId & "_" & $imgIdx & "." & $ext[2]
  Sleep($m)
  Send($imgName)
  Sleep($m)
  Send("{ENTER}")
  Sleep($m)
  FileMove($save_directory & $imgName, $images_directory)
  ; ToolTip($save_directory & $imgName & " moved to " & $save_directory)
  ; Sleep(999999)

  ; $moveCmd = "move " & "'" & $save_directory & $imgName & "' '" & $images_directory & "'"
  ; ToolTip($moveCmd)
  ; RunWait(@ComSpec & $moveCmd)
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