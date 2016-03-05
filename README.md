# TeamCity Backup

![Logo](design/Logo_300x300.png)

[![Build status](https://ci.appveyor.com/api/projects/status/f6gu28t5jagxj3pv/branch/master?svg=true)](https://ci.appveyor.com/project/FantasticFiasco/teamcity-backup/branch/master)

## The elevator pitch

If you are using [TeamCity from JetBrains](https://www.jetbrains.com/teamcity/), are you sure that you continuously are backing up all your projects and their settings?

If not, perhaps I can help you?

What if I told you that you can run the backup process as any other project within TeamCity. By dogfooding the backup to TeamCity, all information is kept within the same system, and the backup history is as clearly visualized as your continuous deliveries.

Pretty smart huh?

## Configuration

I've created a small console application that is capable of triggering TeamCity to perform a backup by means of using the [official REST API](https://confluence.jetbrains.com/display/TCD8/REST+API#RESTAPI-DataBackup).

Lets take a look at the options you have for performing a backup.

```dos
C:\>TeamCityBackup.exe /?
TeamCity Backup  version 1.0.3.0
Copyright © FantasticFiasco 2014-2016

Usage:
   TeamCityBackup /server=url /username=value /password=value
     [/filename=file] [/addtimestamp=true|false]
     [/includeconfigs=true|false] [/includedatabase=true|false]
     [/includebuildlogs=true|false] [/includepersonalchanges=true|false]

Options:
   /?, /h, /help                Displays this help text.
   /addtimestamp                Whether backup file name should be suffixed
                                with a timestamp. Default value is true.
   /filename, /f                The prefix of the backup file name.
                                The default value is 'TeamCity_Backup'.
   /includebuildlogs            Whether to include build
                                logs. Default value is true.
   /includeconfigs              Whether to include configuration.
                                Default value is true.
   /includedatabase             Whether to include database.
                                Default value is true.
   /includepersonalchanges      Whether to include personal
                                changes. Default value is true.
   /password, /p                The password of a TeamCity administrator.
   /server, /s                  The address of the TeamCity server.
   /username, /u                The username of a TeamCity administrator.
```

Out of these options only three are mandatory:

- __server__ - The address of the TeamCity server
- __username__ - The username of a TeamCity administrator
- __password__ - The password of a TeamCity administrator

## Basic example

This command would perform a backup of a TeamCity server located on *www.myteamcityserver.com* using the credentials of the TeamCity administrator *teamcity_user*.

```dos
C:\>TeamCityBackup.exe /server=www.myteamcityserver.com /username=teamcity_user /password=password
```

## Setting up a TeamCity project

The following steps describe how one would create a TeamCity project with the responsibility to backup the TeamCity server once every week. It assumes that you are willing to fork the GitHub repository. If you aren't, you can download the latest release, check it into your version control system and adapt the steps to your new scenario.

1. Fork this GitHub repository.
1. Create a new TeamCity project and name it `TeamCity Backup`.
1. Add a VCS root that points to your forked GitHub repository.
1. Add a scheduled trigger that is configured to occur once a week.
1. Add a *Visual Studio (sln)* build step with the following configuration:
  - Solution file path: `src/TeamCityBackup.sln`
  - Targets: `Rebuild`
  - Configuration: `Release`
1. Add a *Command Line* build step with the following configuration:
  - Command executable: `src/TeamCityBackup/bin/Release/TeamCityBackup.exe`
  - Command parameters: `/server=www.myteamcityserver.com /username=teamcity_user /password=password`

That's it! You now have a working backup solution that will backup your TeamCity server once a week.