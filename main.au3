#include <AutoItConstants.au3>
#include <GUIConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>
#include <FileConstants.au3>
#include "./constants.au3"
#include "./functions.au3"

RunWait(@ComSpec & " /c " & $delete_file)
RunWait(@ComSpec & " /c " & $create_file)
file_write($file_header)

; initTrello("warm_up") ; good for warming-up ;)
initTrello("work")

For $i = 1 To 4
  clickWaitScreen($card1X, $cardY, $card1X, $cardY)
  saveCardData()
  Sleep($xl)
  moveCardX($card1X, $cardY, $list_width)
Next

killChrome()

; TODO: fix for cards without images
