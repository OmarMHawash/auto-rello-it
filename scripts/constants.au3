; must reset to your own values
Local $board_url = "https://trello.com/b/HZLiKp4p/kanban-template"
$chrome_save_dir = "C:\Users\omarm\OneDrive\Pictures\saved prictures\"

; optional
$result_csv = "\data\data.csv"
$csv_header = '"id", "Title", "Description", "Comments"'
$images_result_dir = @WorkingDir & "\data\images"

; delay variables
$s = 50
$m = 100
$l = 300
$xl = 1000

; trello specific
$cardX = 165
$cardY = 265
$list_width = 300

; Commands
$start_chrome = "start chrome"
$delete_file = "del "& @WorkingDir & $result_csv
$create_file = "type nul > " & @WorkingDir & $result_csv

Local Const $sFile = @WorkingDir & $result_csv
Local $iFileExists = FileExists($sFile)

Global $s_FilePath = @WorkingDir & $result_csv
Global $s_EndChars = @CRLF

Global $hFile = FileOpen($s_FilePath, 1)
FileSetPos($hFile, -StringLen($s_EndChars), 1)
