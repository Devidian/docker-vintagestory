# ============== runtime stage ==================
FROM devidian/vintagestory:latest as runtime

WORKDIR /game

ENV VSDATAPATH vs-custom

# update with your own serverconfig
COPY "./serverconfig.json" "/gamedata/${VSDATAPATH}/serverconfig.json"


# CMD [ "mono" , "VintagestoryServer.exe", "--dataPath", "/gamedata/${VSDATAPATH}" ]
CMD mono VintagestoryServer.exe --dataPath "/gamedata/${VSDATAPATH}"

#  Expose ports
EXPOSE 42420/tcp