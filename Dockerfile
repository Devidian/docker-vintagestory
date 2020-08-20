# ============== download stage ==================
FROM alpine as downloader

WORKDIR /download

ARG vs_type=stable
ARG vs_version=1.13.0

RUN wget "https://cdn.vintagestory.at/gamefiles/${vs_type}/vs_server_${vs_version}.tar.gz"
RUN tar xzf "vs_server_${vs_version}.tar.gz"
RUN rm "vs_server_${vs_version}.tar.gz"

# ============== runtime stage ==================
FROM mono:latest as runtime

WORKDIR /game

ARG vs_data_path=/gamedata/vs

COPY --from=downloader "./download/" "/game"
COPY "./serverconfig.json" "${vs_data_path}/serverconfig.json"


#  Expose ports
EXPOSE 42420/tcp

# Execution command
CMD mono VintagestoryServer.exe --dataPath ${vs_data_path}
