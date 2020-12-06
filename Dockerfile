# ============== download stage ==================
FROM alpine as downloader

WORKDIR /download

ARG vs_type=unstable
ARG vs_version=1.14.0-pre.1

RUN wget "https://cdn.vintagestory.at/gamefiles/${vs_type}/vs_server_${vs_version}.tar.gz"
RUN tar xzf "vs_server_${vs_version}.tar.gz"
RUN rm "vs_server_${vs_version}.tar.gz"

# ============== runtime stage ==================
FROM mono:latest as runtime

COPY --from=downloader "./download/" "/game"

# Defaults
ARG vs_data_path=/gamedata/vs

COPY "./serverconfig.json" "${vs_data_path}/serverconfig.json"

#  Expose ports
EXPOSE 42420/tcp

WORKDIR /game
# Execution command
CMD mono VintagestoryServer.exe --dataPath ${VS_DATA_PATH}
