# ============== download stage ==================
FROM alpine:latest AS downloader

WORKDIR /download

ARG vs_type=stable
ARG vs_os=linux-x64
ARG vs_version=1.21.4

RUN apk update
RUN apk add wget tar

RUN wget "https://cdn.vintagestory.at/gamefiles/${vs_type}/vs_server_${vs_os}_${vs_version}.tar.gz" && \
  tar -xvzf "vs_server_${vs_os}_${vs_version}.tar.gz" && \
  rm "vs_server_${vs_os}_${vs_version}.tar.gz"

# ============== runtime stage ==================
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS runtime
WORKDIR /game
# Defaults
ENV VS_DATA_PATH=/gamedata/vs
COPY --from=downloader "./download/" "/game"
COPY entrypoint.sh "/game"

#  Expose ports
EXPOSE 42420

CMD ["/game/entrypoint.sh"]
