# ============== runtime stage ==================
FROM devidian/vintagestory:latest as runtime

WORKDIR /game

# update with your own serverconfig
COPY "./serverconfig.json" "/gamedata/${VSDATAPATH}/serverconfig.json"

# CMD [ "mono" , "VintagestoryServer.exe", "--dataPath", "/gamedata/${VSDATAPATH}" ]
CMD mono VintagestoryServer.exe --dataPath "/gamedata/${VSDATAPATH}"
