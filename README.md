# TeamCity Backup

[![Build status](https://ci.appveyor.com/api/projects/status/f6gu28t5jagxj3pv/branch/master?svg=true)](https://ci.appveyor.com/project/FantasticFiasco/teamcity-backup/branch/master)

## The Elevator Pitch

If you are using [TeamCity](https://www.jetbrains.com/teamcity/), are you sure that you continously are backing up all your projects and their settins? If not, perhaps I can help you.

What if I told you that you could run the backup process as any other project within TeamCity. By dogfooding the backup to TeamCity, all information is kept within the same system. The history of the backups is right there, within the same system you are backing up.

Pretty smart huh?

## Usage

I've created a small console application that is capable of telling TeamCity to perform a backup by means of using the official [REST API](https://confluence.jetbrains.com/display/TCD8/REST+API#RESTAPI-DataBackup).

Lets first take a look at the options you have for performing a backup using the console application.

```dos
C:\>TeamCityBackup.exe /?
TeamCity Backup  version 1.0.3.0
Copyright © FantasticFiasco 2014

Usage:
   TeamCityBackup /server=url /username=value /password=value /filename=file
     [/backupdir=dir] [/maxbackupcount=value] [/addtimestamp=true|false]
     [/includeconfigs=true|false] [/includedatabase=true|false]
     [/includebuildlogs=true|false] [/includepersonalchanges=true|false]

Options:
   /?, /h, /help                Displays this help text.
   /addtimestamp                Whether backup file name should be suffixed
                                with a timestamp. Default value is true.
   /backupdir                   The directory where backups are
                                stored. Specify this property if you
                                wish to make sure that the number of
                                backups doesn't exceed maxbackupcount.
   /filename, /f                The prefix of the backup file name.
   /includebuildlogs            Whether to include build
                                logs. Default value is true.
   /includeconfigs              Whether to include configuration.
                                Default value is true.
   /includedatabase             Whether to include database.
                                Default value is true.
   /includepersonalchanges      Whether to include personal
                                changes. Default value is true.
   /maxbackupcount              The maximum number of backups stored at the
                                backup directory. The default value is 10.
   /password, /p                The password of the TeamCity administrator.
   /server, /s                  The address of the TeamCity server.
   /username, /u                The username of the TeamCity administrator.

```

As you can see there is support for a lot of configuration, but fear not, only four parameters are mandatory.

Here is a simple example of a command that would perform a backup of TeamCity server located on *www.myteamcityserver.com* using the credentials of the user *teamcity_user*. The backup files would be prefixed with *TeamCity_Backup* and stored in a subdirectory of the TeamCity data path, called *backup*.

```dos
C:\>TeamCityBackup.exe /username=teamcity_user /password=password /server=www.myteamcityserver.com /filename=TeamCity_Backup /backupdir=%env.TEAMCITY_DATA_PATH%\backup
```