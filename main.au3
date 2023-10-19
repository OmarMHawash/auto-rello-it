#include <AutoItConstants.au3>
#include "./scripts/constants.au3"
#include "./scripts/functions.au3"
#include "./scripts/helpers.au3"

Func main()
  setupFiles()
  file_write($logCount & " Starting script..." & @CRLF, $log_file)
  initTrello()
  For $i = 1 To 2
    saveCardData($i)
    Sleep($m)
    moveCardX($cardX, $cardY, $list_width)
    file_write($logCount & " Saved Card: " & $i & @CRLF, $log_file)
  Next

  killChrome()
  file_write($logCount & " Script Finised!" & @CRLF, $log_file)
EndFunc

; colorTipMouse()
main()
