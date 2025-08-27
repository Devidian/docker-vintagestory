# About this image

This image can be used to run a dedicated server for [Vintage Story](https://www.vintagestory.at/)

## Run this image with docker run

To run this image you can use `docker run -pd 42420:42420 --name VintageStoryServer devidian/vintagestory:latest`, but you may want to use a customized version for your needs so see following instructions.

## Run this image with docker compose

To run this image with docker compose you can start using the following file:

```yaml
services:
  vsserver-stable:
    image: devidian/vintagestory:latest
    container_name: vsserver
    restart: unless-stopped
    volumes:
      # • your world will be in /appdata/vintagestory/vs by default (/gamedata/vs on the container)
      # • if you run multiple servers just change the left part
      # • you could also use docker volumes instead of host path
      - /appdata/vintagestory:/gamedata
    ports:
      - 42420:42420
    environment:
      VS_DATA_PATH: /gamedata
```

### Using unstable versions

To use unstable versions just replace tag `latest` with `unstable`. See [docker-compose.yml](docker-compose.yml) for all versions.

### Updating container

To update to the latest version call `docker compose pull` first, this will download the newest latest base image. Then execute `docker compose up -d`.

### Copy/Override files

If you use a host volume, you can just edit files there. First stop the container, then make your changes and start the container again.

### Running in TrueNAS

If you have any issues with the hoxst volume mount try this yml:

```yaml
services:
  vsserver-stable:
    image: devidian/vintagestory:latest
    container_name: vsserver
    restart: unless-stopped
    volumes:
      - vsdata:/gamedata
    ports:
      - 42420:42420
    environment:
      VS_DATA_PATH: /gamedata
volumes:
  vsdata:
```

After it spins up the container you might have to connect to your container shell, install nano and edit `/gamedata/vs/serverconfig.json` (see First run Info below)

If you have trouble to get admin state, just login, logout, edit `/gamedata/vs/Playerdata/playerdata.json` and change your role to admin.
Then change the file to readonly with `chmod -w [file]` and restart the container.

## Troubleshooting / Help / Issues

If you encounter any Problems or want some help feeel free to contact me on Discord (`Devidian#1334`) on my Discord Server (<https://discord.gg/8h3yhUT>) or write an issue at GitHub (<https://github.com/Devidian/docker-vintagestory>)

## First run Info

If you run the server the first time, you will notice that you cant connect to it, because you are not on the whitelist.
The whitelist defaults to true since 1.20.0 and you have some options:

### Disable whitelist

You can disable whitelist on startup by changing `"StartupCommands": null` to `"StartupCommands": "/whitelist off"`, then you can login, add yourself to the whitelist and turn it on again. Dont forget to remove the command if you want to enable whitelist afterwards. The command for adding Players to the whitelist is `/player [playername] whitelist on`

### Add yourself to the whitelist

Instead you could also add yourself to the whitelist by setting `"StartupCommands": "/whitelist add [playeruid]"` to login and then add other players this way by their uid. Dont ask me where to get your uid. I just know its in the `playerdata.json` as soon as you login.

Another manual solution is to add yourself to the whitelist file `playerswhitelisted.json` that looks like this:

```json
[
  {
    "PlayerUID": "<UID>",
    "PlayerName": "<NAME>",
    "UntilDate": "2075-01-11T16:59:54.4917519+00:00",
    "Reason": null,
    "IssuedByPlayerName": "Devidian"
  }
]
```

## Other useful commands on startup

Here a list of commands i usually execute on a new server. Most of them make the game a lot more casual friendly.

| Command                                    | Description                                                                         |
| ------------------------------------------ | ----------------------------------------------------------------------------------- |
| `/worldconfig toolDurability 2`            | Default is 1 and we feel that is to low for some tools.                             |
| `/worldconfig microblockChiseling all`     | Default ist stonewood but we like to chisel all                                     |
| `/worldConfig propickNodeSearchRadius 8`   | Second mode for prospecting, can be 0-12 Blocks                                     |
| `/worldconfig blockGravity sandgravelsoil` | We like earth falling down                                                          |
| `/worldconfig deathPunishment keep`        | The game feels to hardcore with the default value drop, especially at the beginning |
| `/worldconfig temporalStorms veryrare`     | We dont want to set them off but default is to often                                |
| `/worldconfig temporalRifts off`           | They suck on startup                                                                |

## Troubleshooting

If you encounter any problems or want to help feel free to contact me on Discord. If you want to log into your running container to debug use: `docker exec -it [containername] sh`
