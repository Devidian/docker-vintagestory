# About this image

This image can be used to run a dedicated server for [Vintage Story](https://www.vintagestory.at/)

## Run this image with docker run

To run this image you can use `docker run -pd 42420:42420 --name VintageStoryServer devidian/vintagestory:latest`, but you may want to use a customized version for your needs so see following instructions.

## Run this image with docker compose

To run this image with docker compose you can start using the following file:

```yaml
services: 
  vsserver:
    image: devidian/vintagestory:unstable
    container_name: vsserver
    restart: unless-stopped
    volumes: 
    # • your world will be in /appdata/vintagestory/vs by default (/gamedata/vs on the container)
    # • if you run multiple servers just change the left part 
    # • you could also use docker volumes instead of host path
      - /appdata/vintagestory:/gamedata
    ports:
      - 42420:42420
```

### Using stable versions

To use stable versions just replace tag `unlatest` with `stable`. See [docker-compose.yml]( docker-compose.yml ) for all versions.

### Updating container

To update to the latest version call `docker compose pull` first, this will download the newest latest base image. Then execute `docker compose up -d`.

### Copy/Override files

If you use a host volume, you can just edit files there. First stop the container, then make your changes and start the container again.

## Troubleshooting / Help / Issues

If you encounter any Problems or want some help feeel free to contact me on Discord (`Devidian#1334`) on my Discord Server (<https://discord.gg/8h3yhUT>) or write an issue at GitHub (<https://github.com/Devidian/docker-vintagestory>)
