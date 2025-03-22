FROM mcr.microsoft.com/dotnet/sdk:7.0 AS runtime

ARG vs_type=stable
ARG vs_os=linux-x64
ARG vs_version=1.20.6

WORKDIR /game

ADD "https://cdn.vintagestory.at/gamefiles/${vs_type}/vs_server_${vs_os}_${vs_version}.tar.gz" vs_server.tar.gz

RUN set -eux; \
    tar -xvzf vs_server.tar.gz; \
    rm vs_server.tar.gz

ENV VS_DATA_PATH=/gamedata/vs

EXPOSE 42420/tcp

CMD dotnet VintagestoryServer.dll --dataPath $VS_DATA_PATH
