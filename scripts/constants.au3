; must reset to your own values
Local $board_url = "https://trello.com/b/HZLiKp4p/kanban-template"
$chrome_save_dir = "C:\Users\omarm\Downloads\"

; optional
$result_csv = "\data\data.csv"
$log_file = "\data\log.txt"
$csv_header = 'id,Title,Description,Comments'
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
$trello_white = 16777215
Local $bEdge[2] = [954, 1016]

; Commands
$start_chrome = "start chrome"
$delete_csv = "del "& @WorkingDir & $result_csv
$delet_log = "del "& @WorkingDir & $log_file
$delete_images = "del /s/q "& $images_result_dir
$create_csv = "type nul > " & @WorkingDir & $result_csv
$creat_log = "type nul > " & @WorkingDir & "\data\log.txt"
Local $setupCommands[5] = [$delete_csv, $delet_log, $create_csv, $delete_images, $creat_log] 
Local $logCount = 0
Local Const $sFile = @WorkingDir & $result_csv
Local $iFileExists = FileExists($sFile)

Global $s_FilePath = @WorkingDir & $result_csv
Global $s_EndChars = @CRLF

Global $hFile = FileOpen($s_FilePath, 1)
FileSetPos($hFile, -StringLen($s_EndChars), 1)
