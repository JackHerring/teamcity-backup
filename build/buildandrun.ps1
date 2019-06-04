param (
	[string]$server = "",
	[string]$username = "",
	[string]$password = ""
)

dotnet restore D:\\teamcity-backup\\src\\TeamCityBackup.sln
dotnet build D:\\teamcity-backup\\src\\TeamCityBackup.sln -c Release
D:\\teamcity-backup\\src\\TeamCityBackup\\bin\\Release\\TeamCityBackup.exe /server=$server /username=$username /password=$password /includebuildlogs=false