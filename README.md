# Run this image
To run this image you can use `docker run -pd 42420:42420 --name VintageStoryServer devidian/vintagestory`, but you may want to use a customized version for your needs so see following instructions.

# Custom build
You can either copy files from `https://github.com/Devidian/docker-vintagestory/tree/master/build-custom-example` or follow these steps:

- create a `serverconfig.json` with your settings
- create a `Dockerfile` file with contents found below
- create a `docker-compose.yml` file with contents found below (adjust port/path if you need)
- run `docker-compose up -d` to start
- run `docker-compose up -d --build` to rebuild and restart
- run `docker-compose down` to stop

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

CMD mono VintagestoryServer.exe --dataPath ${vs_data_path}

```

## docker-compose.yml

```yml
version: '3.1'

services: 
  vsserver:
    build:
      context: .
      args: 
        vs_data_path: /gamedata/vs-mods/
    container_name: vsserver
    restart: always
    volumes: 
      - gamedata:/gamedata
    ports:
      - 42420:42420
      
volumes:
  gamedata:
```

# using unstable versions
to use unstable versions just replace tag `latest` with `unstable` in `Dockerfile`