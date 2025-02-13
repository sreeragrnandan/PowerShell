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

# Start Zookeeper and Kafka
function startKafka {
    ckf

    Start-Process -FilePath .\bin\windows\zookeeper-server-start.bat -ArgumentList .\config\zookeeper.properties -NoNewWindow -Wait
    if ($LASTEXITCODE -ne 0) {
        Write-Output "Zookeeper failed to start"
        return
    }

    try {
        Remove-Item -Recurse -Force .\kafkaconfigkafka-test-logs\
    } catch {
        # Ignore any errors from this command
    }

    Start-Process -FilePath .\bin\windows\kafka-server-start.bat -ArgumentList .\config\server.properties -NoNewWindow -Wait
    if ($LASTEXITCODE -ne 0) {
        Write-Output "Kafka failed to start"
    }
}
