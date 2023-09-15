#include <AutoItConstants.au3>
#include "./scripts/constants.au3"
#include "./scripts/functions.au3"

RunWait(@ComSpec & " /c " & $delete_file)
RunWait(@ComSpec & " /c " & $create_file)
file_write($csv_header)

initTrello()

For $i = 1 To 4
  waitScreen($cardX, $cardY, "click")
  saveCardData($i)
  Sleep($l)
  moveCardX($cardX, $cardY, $list_width)
Next

killChrome()
