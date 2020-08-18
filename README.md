# Run this image
To run this image you can use `docker run -pd 42420:42420 --name VintageStoryServer devidian/vintagestory`, but you may want to use a customized version for your needs so see `./build-custom-example/README.md`

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

WORKDIR /game

# update with your own serverconfig
COPY "./serverconfig.json" "/gamedata/${VSDATAPATH}/serverconfig.json"

# CMD [ "mono" , "VintagestoryServer.exe", "--dataPath", "/gamedata/${VSDATAPATH}" ]
CMD mono VintagestoryServer.exe --dataPath "/gamedata/${VSDATAPATH}"

```

## docker-compose.yml

```yml
version: '3.1'

services: 
  vsserver:
    build: .
    container_name: vsserver
    restart: always
    volumes: 
      - gamedata:/gamedata
    ports:
      - 42420:42420
    environment:
      VSDATAPATH: vs-custom
volumes:
  gamedata:
```

# using unstable versions
to use unstable versions just replace tag `latest` with `unstable` in `Dockerfile`