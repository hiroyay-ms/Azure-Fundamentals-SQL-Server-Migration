# Disable Internet Explorer Enhanced Security Configuration
function Disable-InternetExplorerESC {
    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0 -Force
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0 -Force
    Stop-Process -Name Explorer -Force
    Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green
}

# Disable IE ESC
Disable-InternetExplorerESC

# Enable TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Download and Extract
mkdir C:\_work
Invoke-WebRequest 'https://raw.githubusercontent.com/hiroyay-ms/Azure-Fundamentals-SQL-Server-Migration/main/backup/AdventureWorksLT2014.bak' -OutFile 'C:\_work\AdventureWorksLT2014.bak'

# Restore Database
function Restore-Database {
    $serverName = 'localhost'
    $databaseName = 'AdventureWorksLT2014'

    $cmd = "RESTORE DATABASE [" + $databaseName + "] FROM  DISK = N'C:\_work\AdventureWorksLT2014.bak' WITH  FILE = 2,  MOVE N'AdventureWorksLT2008_Data' TO N'F:\data\AdventureWorksLT2012_Data.mdf',  MOVE N'AdventureWorksLT2008_Log' TO N'F:\log\AdventureWorksLT2012_log.ldf',  NOUNLOAD,  STATS = 5"
    Invoke-SqlCmd -ServerInstance $serverName -Database "master" -Query $cmd
}

Restore-Database