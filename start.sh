#!/usr/bin/env bash
cd "$(realpath "$(dirname "$0")")"

# use a named pipe to send the exit command
mkfifo inpipe
cat inpipe | ./server/TerrariaServer.bin.x86_64 -config ../terraria.conf
rm inpipe