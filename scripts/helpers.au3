HotKeySet("{F10}", "Quit")
Func Quit()
  Exit
EndFunc

Func myFileWrite($record, $target)
  if $target = $log_file Then
    $log_id += 1
  EndIf
  If $iFileExists Then
    FileWriteLine(@WorkingDir & $target, $record)
  EndIf
EndFunc

Func killWindow()
  ToolTip("Waiting for changes to save...")
  Sleep($l) ; wait for changes to be saved online
  Send("{CTRLDOWN}w{CTRLUP}")
  myFileWrite($log_id & " Killed Active Window" & @CRLF, $log_file)
EndFunc

Func debug($message)
  ToolTip($message)
  Sleep($xl * 25)
EndFunc

Func colorTipMouse()
  While True
    $pos = MouseGetPos()
    $color = PixelGetColor($pos[0], $pos[1])
    ToolTip("X: " & $pos[0] & " Y: " & $pos[1] & " Color: " & $color)
    Sleep($l)
  WEnd
EndFunc

Func repeatKey($key, $num)
  For $i = 1 To $num
    Send($key)
    Sleep($s/2)
  Next
EndFunc


# defined to work horizontal from left to right with height offset fix
Func dragDrop($xPos, $yPos, $width)
  $fixOffset = 20
  MouseMove($xPos, $yPos, 1)
  MouseDown("left")
  MouseMove($xPos+$width, $yPos-$fixOffset,2)
  MouseUp("left")
EndFunc

Func isWinWarn()
  $winBoxColor = 5332075
  Local $winBoxCords = [940,430]
  if PixelGetColor($winBoxCords[0], $winBoxCords[1]) = $winBoxColor Then
    myFileWrite($log_id & "Script broke while saving "& @CRLF, $log_file)
    debug("Warning: " & "Window box detected")
    Exit
    return True
  EndIf
  return False
EndFunc