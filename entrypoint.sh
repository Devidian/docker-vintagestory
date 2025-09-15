#!/bin/sh

exec dotnet VintagestoryServer.dll --dataPath $VS_DATA_PATH "$@"
