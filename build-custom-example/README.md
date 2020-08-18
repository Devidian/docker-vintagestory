# Create custom docker image
You can use this `Dockerfile` to create your own serverconfig using `devidian/vintagestory` as base. Just edit serverconfig.json and run `docker build -t YOUR_IMAGE_NAME`. You may also add / override additional files like mods.

## Run custom docker image
to run the image you can either use `docker run -pd 42420:42420 --name VintageStoryServer YOUR_IMAGE_NAME` or use the composer file as follows.

```bash
cd run;

#start
docker-compose up -d
#rebuild / update
docker-compose up -d --build
#stop
docker-compose down
```