dotnet restore D:\\teamcity-backup\\src\\TeamCityBackup.sln
dotnet build D:\\teamcity-backup\\src\\TeamCityBackup.sln -c Release
D:\\teamcity-backup\\src\\TeamCityBackup\\bin\\Release\\TeamCityBackup.exe /server=http://teamcity.spawtz.com/ /username=autobackup /password=BackTheHellUp33 /includebuildlogs=false
