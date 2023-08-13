# ============== download stage ==================
FROM alpine as downloader

WORKDIR /download

ARG vs_type=stable
ARG vs_version=1.18.8
ARG vs_filename=vs_server_linux-x64_${vs_version}.tar.gz

RUN wget "https://cdn.vintagestory.at/gamefiles/${vs_type}/${vs_filename}"
#RUN wget "https://cdn.vintagestory.at/gamefiles/${vs_type}/vs_server_${vs_version}.tar.gz"
RUN tar xzf "${vs_filename}"
RUN rm "${vs_filename}"

# ============== runtime stage ==================
FROM mcr.microsoft.com/dotnet/runtime:7.0 as runtime

#RUN apt update
#RUN apt -y install procps screen

COPY --from=downloader "./download/" "/game"

# Defaults
ENV VS_DATA_PATH=/gamedata/vs

#  Expose ports
EXPOSE 42420/tcp

WORKDIR /game

#RUN ./server.sh setup

# Execution command
#CMD mono VintagestoryServer.exe --dataPath ${VS_DATA_PATH}
#CMD ./server.sh start
CMD dotnet VintagestoryServer.dll --dataPath ${VS_DATA_PATH}

