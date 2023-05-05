# About this image

This image can be used to run a dedicated server for [Vintage Story](https://www.vintagestory.at/)

## Run this image with docker run

To run this image you can use `docker run -pd 42420:42420 --name VintageStoryServer devidian/vintagestory:latest`, but you may want to use a customized version for your needs so see following instructions.

## Run this image with docker compose

To run this image with docker compose you can start using the following file:

```yaml
version: '3.8'

services: 
  vsserver:
    image: devidian/vintagestory:latest
    container_name: vsserver
    restart: always
    volumes: 
    # • your world will be in /appdata/vintagestory/vs by default (/gamedata/vs on the container)
    # • if you run multiple servers just change the left part 
    # • you could also use docker volumes instead of host path
      - /appdata/vintagestory:/gamedata
    ports:
      - 42420:42420
```

## Custom build

You can either copy files from `https://github.com/Devidian/docker-vintagestory/tree/master/build-custom-example` or follow these steps:

- create a `serverconfig.json` with your settings
- create a `Dockerfile` file with contents found below
- create a `docker-compose.yml` file with contents found below (adjust port/path if you need)
- run `docker-compose up -d` to start
- run `docker-compose up -d --build` to rebuild and restart
- run `docker-compose down` to stop

We use `vs_data_path` as ARG because ENV did not get overridden in build phase and we use `VS_DATA_PATH` as ENV because ARG in CMD is empty.

## Dockerfile for custom-build

```docker
# ============== runtime stage ==================
FROM devidian/vintagestory:latest as runtime

ARG vs_data_path=/gamedata/vs

# update with your own serverconfig
COPY serverconfig.json ${vs_data_path}/serverconfig.json
# copy mods
#COPY Mods ${vs_data_path}/Mods/
# copy default player data
#COPY Playerdata ${vs_data_path}/Playerdata/

WORKDIR /game

CMD mono VintagestoryServer.exe --dataPath ${VS_DATA_PATH}

```

### docker-compose.yml

```yml
version: '3.8'

services: 
  vsserver:
    build:
      context: .
      args: 
        vs_data_path: /gamedata/vs-custom/
    container_name: vsserver
    restart: always
    volumes: 
      - gamedata:/gamedata
    ports:
      - 42420:42420
    environment:
      VS_DATA_PATH: /gamedata/vs-custom
volumes:
  gamedata:
```

### Using unstable versions

To use unstable versions just replace tag `latest` with `unstable` in `Dockerfile`

### Updating container

To update to the latest version call `docker pull devidian/vintagestory` first, this will download the newest latest base image. Then execute `docker-compose up -d --build` if you have not changed any other files it should not override them (did not for me)

### Copy/Override files

To copy and override files use `docker exec vsserver cp [local path] [docker-path]` where `docker-path` is starting with `/gamedata/vs-custom/..` for the example composer file. This is useful to update white/blacklists manually or update `serversettings.json`

## Troubleshooting / Help / Issues

If you encounter any Problems or want some help feeel free to contact me on Discord (`Devidian#1334`) on my Discord Server (<https://discord.gg/8h3yhUT>) or write an issue at GitHub (<https://github.com/Devidian/docker-vintagestory>)
