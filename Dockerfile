# ============== download stage ==================
FROM alpine as downloader

WORKDIR /download

ARG vs_type=stable
ARG vs_version=1.18.6

RUN wget "https://cdn.vintagestory.at/gamefiles/${vs_type}/vs_server_${vs_version}.tar.gz"
RUN tar xzf "vs_server_${vs_version}.tar.gz"
RUN rm "vs_server_${vs_version}.tar.gz"

# ============== runtime stage ==================
FROM mono:latest as runtime

COPY --from=downloader "./download/" "/game"

# Defaults
ENV VS_DATA_PATH=/gamedata/vs

#  Expose ports
EXPOSE 42420/tcp

WORKDIR /game
# Execution command
CMD mono VintagestoryServer.exe --dataPath ${VS_DATA_PATH}
