# ============== download stage ==================
FROM alpine as downloader

WORKDIR /download

ENV VSVERSION 1.12.14

RUN wget "https://cdn.vintagestory.at/gamefiles/stable/vs_server_${VSVERSION}.tar.gz"
RUN tar xzf "vs_server_${VSVERSION}.tar.gz"
RUN rm "vs_server_${VSVERSION}.tar.gz"

# ============== runtime stage ==================
FROM mono:latest as runtime

WORKDIR /game

ENV VSDATAPATH vs

COPY --from=downloader "./download/" "/game"
COPY "./serverconfig.json" "/gamedata/${VSDATAPATH}/serverconfig.json"


# CMD [ "mono" , "VintagestoryServer.exe", "--dataPath", "/gamedata/${VSDATAPATH}" ]
CMD mono VintagestoryServer.exe --dataPath "/gamedata/${VSDATAPATH}"

#  Expose ports
EXPOSE 42420/tcp