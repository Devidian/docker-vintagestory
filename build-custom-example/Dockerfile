# ============== runtime stage ==================
FROM devidian/vintagestory:unstable as runtime

WORKDIR /game

ENV VSDATAPATH vs-custom

# update with your own serverconfig
COPY "./serverconfig.json" "/gamedata/${VSDATAPATH}/serverconfig.json"

#  Expose ports
EXPOSE 42420/tcp

# CMD [ "mono" , "VintagestoryServer.exe", "--dataPath", "/gamedata/${VSDATAPATH}" ]
CMD mono VintagestoryServer.exe --dataPath "/gamedata/${VSDATAPATH}"
