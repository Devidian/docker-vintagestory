# ============== runtime stage ==================
FROM devidian/vintagestory:latest as runtime

ARG vs_data_path=/gamedata/vs

# update with your own serverconfig
COPY serverconfig.json ${vs_data_path}/serverconfig.json
# copy mods
COPY Mods ${vs_data_path}/Mods/
# copy default player data
COPY Playerdata ${vs_data_path}/Playerdata/

WORKDIR /game

CMD mono VintagestoryServer.exe --dataPath ${vs_data_path}
