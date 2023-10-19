HotKeySet("{F10}", "Quit")
Func Quit()
  Exit
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
    Sleep($s)
  WEnd
EndFunc

Func repeatKey($key, $num)
  For $i = 1 To $num
    Send($key)
  Next
  Sleep($s)
EndFunc