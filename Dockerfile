# ============== download stage ==================
FROM alpine as downloader

WORKDIR /download

ENV VSTYPE unstable
ENV VSVERSION 1.13.0-rc.3

RUN wget "https://cdn.vintagestory.at/gamefiles/${VSTYPE}/vs_server_${VSVERSION}.tar.gz"
RUN tar xzf "vs_server_${VSVERSION}.tar.gz"
RUN rm "vs_server_${VSVERSION}.tar.gz"

# ============== runtime stage ==================
FROM mono:latest as runtime

WORKDIR /game

ENV VSDATAPATH vs

COPY --from=downloader "./download/" "/game"
COPY "./serverconfig.json" "/gamedata/${VSDATAPATH}/serverconfig.json"


#  Expose ports
EXPOSE 42420/tcp

# CMD [ "mono" , "VintagestoryServer.exe", "--dataPath", "/gamedata/${VSDATAPATH}" ]
CMD mono VintagestoryServer.exe --dataPath "/gamedata/${VSDATAPATH}"
