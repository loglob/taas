#!/usr/bin/env bash
set -e
cd "$(realpath "$(dirname "$0")")"

if [ ! -e inpipe ]
then
	echo "Server isn't running!"
	exit 1
fi

# retrieve PID of running server
PID="$(systemctl show --property MainPID --value terraria)"
# setup a background process that waits for the server to exit
tail --pid=$PID -f /dev/null &

echo -e "\nexit\n" > inpipe

wait $!