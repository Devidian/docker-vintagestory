# ============== download stage ==================
FROM alpine as downloader

WORKDIR /download

ARG vs_type=stable
ARG vs_os=linux-x64
ARG vs_version=1.18.8

RUN wget "https://cdn.vintagestory.at/gamefiles/${vs_type}/vs_server_${vs_os}_${vs_version}.tar.gz"
RUN tar xzf "vs_server_${vs_os}_${vs_version}.tar.gz"
RUN rm "vs_server_${vs_os}_${vs_version}.tar.gz"

# ============== runtime stage ==================
FROM mcr.microsoft.com/dotnet/sdk:7.0 as runtime
WORKDIR /game
# Defaults
ENV VS_DATA_PATH=/gamedata/vs

COPY --from=downloader "./download/" "/game"

#  Expose ports
EXPOSE 42420/tcp

# Execution command
CMD [ "dotnet", "VintagestoryServer.dll", "--dataPath", "${VS_DATA_PATH}" ]
