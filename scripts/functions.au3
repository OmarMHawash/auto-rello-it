Func initTrello()
  $tf = 0.8
  myFileWrite($log_id & " Starting Trello..." & @CRLF, $log_file)
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
  waitScreen($b_edge[0], $b_edge[1])
  waitScreen($b_edge[0], $b_edge[1])
  waitScreen($b_edge[0], $b_edge[1])
  myFileWrite($log_id & " Loaded Trello!" & @CRLF, $log_file)
EndFunc

Func setupFiles()
  For $command In $setup_cmds
    RunWait(@ComSpec & " /c " & $command)
  Next
  myFileWrite($csv_header, $result_csv)
  myFileWrite($log_id & " Files all setup!" & @CRLF, $log_file)
EndFunc

Func waitScreen($x, $y, $limit = 0)
  myFileWrite($log_id & " Waiting Screen for: " & $x & ", " & $y & @CRLF, $log_file)
  $old_screen = PixelGetColor($x , $y)
  $new_screen = $old_screen
  $timer = 0
  ; Sleep($m) ; wait for any animation to finish
  While True
    If $old_screen = $new_screen Then
      $new_screen = PixelGetColor($x, $y)
      ToolTip("Waiting...")
      Sleep($s)
    Else
      ToolTip("")
      ExitLoop
    EndIf
    If $limit Then
      $timer += $s
        myFileWrite($log_id & " Waiting max_wait_time ++ !"& $timer & @CRLF, $log_file)
      If $timer >= $max_wait_time Then
        ExitLoop
        myFileWrite($log_id & "-- Exited from Timer --" & @CRLF, $log_file)
      EndIf
    EndIf
  WEnd
  Sleep($m)
EndFunc

Func saveCardData($idx)
  $tf = 0.8
  MouseClick($MOUSE_CLICK_LEFT, $card_x, $card_y, 1)
  Sleep($l)
  Global $cardID = $idx
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
  myFileWrite($row, $result_csv)
  saveAllImages()
  repeatKey("{ESC}", 3)
  myFileWrite($log_id & " Saved Data: " & $row & @CRLF, $log_file)
EndFunc

Func saveAllImages()
  repeatKey("{TAB}", 5)
  Send("{ENTER}")
  $max_wait_time = 100
  saveImage()
EndFunc

Func saveImage()
  $imgIdx = 1
  waitScreen($card_img[0],$card_img[1],1)
  Sleep($s)
  MouseClick($MOUSE_CLICK_RIGHT, 470, 200, 1)
  MouseClick($MOUSE_CLICK_LEFT, 500, 236, 1)
  waitScreen($card_img[0],$card_img[1])
  copyAllBox() 
  $ext = StringSplit(ClipGet(), ".")
  Global $imgName = $img_prefix & $cardID & "_" & $imgIdx & "." & $ext[2]
  Send($imgName & "{ENTER}")
  Sleep($file_save_delay) ; wait for image to save
  FileMove($chrome_save_dir & $imgName, $images_result_dir)
  FileDelete($chrome_save_dir & $imgName)
  Sleep($m)
  myFileWrite($log_id & " Saved Image: " & $imgName & @CRLF, $log_file)
  isWinWarn()
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