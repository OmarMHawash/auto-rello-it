Local $board_url = "trello.com/b/HZLiKp4p/kanban-template"
$file_name = "\data.csv"

$file_header = '"id", "Title", "Description", "Comments"'
$save_directory = "C:\Users\omarm\OneDrive\Pictures\saved prictures\"
$images_directory = @WorkingDir & "\images"

$s = 50
$m = 100
$l = 200
$xl = 1000

$cardX = 165
$cardY = 265
$list_width = 300


; Commands
$start_chrome = "start chrome"
$delete_file = "del "& @WorkingDir & $file_name
$create_file = "type nul > " & @WorkingDir & $file_name

Local Const $sFile = @WorkingDir & $file_name
Local $iFileExists = FileExists($sFile)

Global $s_FilePath = @WorkingDir & $file_name
Global $s_EndChars = @CRLF

Global $hFile = FileOpen($s_FilePath, 1)
FileSetPos($hFile, -StringLen($s_EndChars), 1)
