function Restore-Database {
    $serverName = 'localhost'
    $databaseName = 'AdventureWorksLT2014'

    $cmd = "RESTORE DATABASE [" + $databaseName + "] FROM  DISK = N'C:\_work\AdventureWorksLT2014.bak' WITH  FILE = 2,  MOVE N'AdventureWorksLT2008_Data' TO N'F:\data\AdventureWorksLT2012_Data.mdf',  MOVE N'AdventureWorksLT2008_Log' TO N'F:\log\AdventureWorksLT2012_log.ldf',  NOUNLOAD,  STATS = 5"
    Invoke-SqlCmd -ServerInstance $serverName -Database "master" -Query $cmd
}

Restore-Database
