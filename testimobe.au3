#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>

HotKeySet("{Esc}", "ExitScript")
Func ExitScript()
    Exit
EndFunc

$images_directory = "\images"
$ext = @WorkingDir & $images_directory
ToolTip($ext)
Sleep(500000)