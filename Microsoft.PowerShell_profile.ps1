function gr { go run .\cmd }
function docRed { docker run -p 6379:6379 redis }
function runkzk { .\bin\windows\zookeeper-server-start.bat .\config\zookeeper.properties }
function runks { .\bin\windows\kafka-server-start.bat .\config\server.properties }
function ckf { Set-Location 'C:\Kafka' }
function c { clear }
function kb { kubectl $args }
function grep { findStr $args }
Import-Module PSReadLine

#Shows menu of options on tab hit
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

#Autocompletion for Arrow keys
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadLineOption -ShowToolTips
Set-PSReadLineOption -PredictionSource History

#Set Color for Predictions
Set-PSReadLineOption -Colors @{InlinePrediction = 'DarkGray' }
