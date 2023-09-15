#include <AutoItConstants.au3>
#include "./constants.au3"
#include "./functions.au3"

RunWait(@ComSpec & " /c " & $delete_file)
RunWait(@ComSpec & " /c " & $create_file)
file_write($file_header)

initTrello()

For $i = 1 To 4
  waitScreen($cardX, $cardY, "click")
  saveCardData($i)
  Sleep($xl)
  moveCardX($cardX, $cardY, $list_width)
Next

killChrome()
