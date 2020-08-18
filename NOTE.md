# Contribution note
just some notes for myself in case i forgot how to upgrade the image

```sh
#build
docker build -t devidian/vintagestory .
#push
docker push devidian/vintagestory
#run
docker run -pd 42420:42420 --name VintageStoryServer devidian/vintagestory
# --------------------------------------
# --------- using composer -------------
#start
docker-compose up -d
#rebuild
docker-compose up -d --build
#stop
docker-compose down
```