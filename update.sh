#!/usr/bin/env bash
set -e
cd "$(realpath "$(dirname "$0")")"

echo "Looking for most recent terraria server..."

suburl=$(curl -s "https://terraria.org/terms" | hxnormalize -x | hxselect -c 'a[href*=terraria-server]::attr(href)')
v=$(grep -P -o "(?<=terraria-server-)[0-9]+" <<< $suburl)

echo "Found version $(sed -e "s/./.&/2g" <<< "$v")"

curl "https://terraria.org/$suburl" > "terraria_server.zip"
unzip -o terraria_server.zip "$v"/Linux/'*'
mkdir server
mv "$v/Linux/"* server
rm -r "$v"
rm "terraria_server.zip"
chmod +x "server/TerrariaServer.bin.x86_64"