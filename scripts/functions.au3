
HotKeySet("{F10}", "Quit")
Func Quit()
  Exit
EndFunc

Func debug($message)
  ToolTip($message)
  Sleep($xl * 25)
EndFunc

Func file_write($record)
  If $iFileExists Then
    FileWriteLine(@WorkingDir & $result_csv, $record)
  EndIf
EndFunc

Func initTrello()
  $tf = 0.8
  Send("{LWINDOWN}{m down}{m up}{LWINUP}") ; minimize all windows	
  RunWait(@ComSpec & " /c " & $start_chrome) 
  Sleep($m*$tf)
  Send("{CTRLDOWN}n{CTRLUP}")
  Sleep($m*$tf)
  Send("{LWINDOWN}{LEFT}{LWINUP}")
  Sleep($m*$tf)
  Send("{Esc}")
  Send($board_url)
  Sleep($m*$tf)
  Send("{ENTER}")
  Sleep($m*$tf)
  waitScreen(22, 1000, "no_click")
  Sleep($xl * $tf)
EndFunc


Func waitScreen($waitX, $waitY, $isClick = 0)
  $old_screen = PixelGetColor($waitX, $waitY)
  $new_screen = $old_screen
  If $isClick = "click" Then
    Sleep($m)
    MouseClick($MOUSE_CLICK_LEFT, $waitX, $waitY)
  EndIf
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

  $row = $id & "," & $title & ", " & $desc
  file_write($row)

  Sleep($s * $tf)
  saveAllImages()

  Sleep($m * $tf)
  ESCs(3)
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

Func saveAllImages()
  TABs(5)
  Send("{ENTER}")
  Sleep($l)
  saveImage()
EndFunc

Func saveImage()
  $imgIdx = 1
  Sleep($m)
  MouseClick($MOUSE_CLICK_RIGHT, 470, 200, 1)
  Sleep($m)
  MouseClick($MOUSE_CLICK_LEFT, 500, 236, 1)
  Sleep($l)
  copyAllBox() 
  $currName = ClipGet()
  $ext = StringSplit($currName, ".")
  Sleep($l)
  Global $imgName = $gId & "_" & $imgIdx & "." & $ext[2]
  Sleep($m)
  Send($imgName)
  Send("{ENTER}")
  ToolTip("Saving image: " & $imgName)
  Sleep($l)
  ToolTip("")
  FileMove($chrome_save_dir & $imgName, $images_result_dir)
  FileDelete($images_result_dir & $imgName)
  ; debug("--deleting: " & $images_result_dir & $imgName)
  Sleep($m)
EndFunc

Func killChrome()
  Send("{CTRLDOWN}w{CTRLUP}")
EndFunc

Func moveCardX($xPos, $yPos, $width)
  $fixOffset = 20
  MouseMove($xPos, $yPos, 1)
  MouseDown("left")
  MouseMove($xPos+$width, $yPos-$fixOffset,1)
  MouseUp("left")
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