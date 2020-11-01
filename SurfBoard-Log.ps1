Import-Module .\SURFboard-CableModem

$modem = "192.168.100.1"

$log = [ordered]@{}
$log.'Date Time' = Get-SurfBoardBootTime -ComputerName $modem
$log += Get-SurfBoard -ComputerName $modem

$log | ConvertTo-Json -Depth 100 -Compress | Out-File -Append .\SurfBoard-Log.json