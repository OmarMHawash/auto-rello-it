#include <AutoItConstants.au3>
#include "./scripts/constants.au3"
#include "./scripts/functions.au3"
#include "./scripts/helpers.au3"

Func main()
  setupFiles()
  myFileWrite($log_id & " Starting script..." & @CRLF, $log_file)
  initTrello()
  For $i = 1 To 29
    saveCardData($i)
    Sleep($m)
    dragDrop($card_x, $card_y, $list_width)
    myFileWrite($log_id & " Saved Card: " & $i & @CRLF, $log_file)
  Next

  killWindow()
  myFileWrite($log_id & " Script Finised!" & @CRLF, $log_file)
EndFunc

; colorTipMouse()
main()
