Func file_write($record, $target)
  if $target = $log_file Then
    $logCount += 1
  EndIf
  If $iFileExists Then
    FileWriteLine(@WorkingDir & $target, $record)
  EndIf
EndFunc

Func initTrello()
  file_write($logCount & " Starting Trello..." & @CRLF, $log_file)
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
  waitScreen($bEdge[0], $bEdge[1])
  waitScreen($bEdge[0], $bEdge[1])
  waitScreen($bEdge[0], $bEdge[1])
  file_write($logCount & " Loaded Trello!" & @CRLF, $log_file)
EndFunc

Func setupFiles()
  For $command In $setupCommands
    RunWait(@ComSpec & " /c " & $command)
  Next
  file_write($csv_header, $result_csv)
  file_write($logCount & " Files all setup!" & @CRLF, $log_file)
EndFunc

Func waitScreen($waitX, $waitY)
  file_write($logCount & " Waiting Screen for: " & $waitX & ", " & $waitY & @CRLF, $log_file)
  $old_screen = PixelGetColor($waitX , $waitY)
  $new_screen = $old_screen
  Sleep($s)
  While True
    If $old_screen = $new_screen Then
      $new_screen = PixelGetColor($waitX, $waitY)
      ToolTip("Waiting...")
      Sleep($s)
    Else
      ToolTip("")
      ExitLoop
    EndIf
  WEnd
  Sleep($s)
EndFunc

Func saveCardData($idx)
  $tf = 0.8
  MouseClick($MOUSE_CLICK_LEFT, $cardX, $cardY)
  waitScreen($cardX, $cardY)
  Global $gId = $idx
  repeatKey("{TAB}", 3)
  copyAllBox()
  $title = ClipGet()
  Sleep($m * $tf)

  repeatKey("{TAB}", 3)
  Send("{ENTER}")
  Sleep($m * $tf)
  copyAllBox()
  $desc = sanitDesc(ClipGet())

  $row = $idx  & "," & $title & "," & $desc
  file_write($row, $result_csv)
  Sleep($s * $tf)
  saveAllImages()
  Sleep($m * $tf)
  repeatKey("{ESC}", 3)
  file_write($logCount & " Saved Data: " & $row & @CRLF, $log_file)
EndFunc

Func saveAllImages()
  repeatKey("{TAB}", 5)
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
  $ext = StringSplit(ClipGet(), ".")
  Sleep($l)
  Global $imgName = $gId & "_" & $imgIdx & "." & $ext[2]
  Sleep($m)
  Send($imgName & "{ENTER}")
  Sleep($l)
  FileMove($chrome_save_dir & $imgName, $images_result_dir)
  FileDelete($chrome_save_dir & $imgName)
  Sleep($m)
  file_write($logCount & " Saved Image: " & $imgName & @CRLF, $log_file)
EndFunc

Func killChrome()
  Sleep($l) ; wait for changes to be saved online
  Send("{CTRLDOWN}w{CTRLUP}")
  file_write($logCount & " Killed Chrome" & @CRLF, $log_file)
EndFunc

Func moveCardX($xPos, $yPos, $width)
  $fixOffset = 20
  MouseMove($xPos, $yPos, 1)
  MouseDown("left")
  MouseMove($xPos+$width, $yPos-$fixOffset,1)
  MouseUp("left")
EndFunc

Func copyAllBox()
  Send("{CTRLDOWN}a{CTRLUP}" & "{CTRLDOWN}c{CTRLUP}")
  Sleep($s)
EndFunc

Func sanitDesc($str)
  $str = StringReplace($str, @CRLF, "\n")
  $str = StringReplace($str, @LF, "\n")
  $str = StringReplace($str, ',', "0x2C")
  Sleep($s)
  Return $str
EndFunc