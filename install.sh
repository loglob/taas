dir="/srv/terraria"

set -e

if [ $# -gt 0 ]
then
	dir=$(realpath "$1")
fi

mkdir -p "$dir"
git clone --depth 1 "https://github.com/loglob/taas" "$dir"
cp -r * "$dir"
"$dir/update.sh"

echo "[Unit]
	Description=Terraria server
	After=network-online.target
	Wants=network-online.target
[Service]
	Type=simple
	ExecStart=$dir/start.sh
	ExecStop=$dir/stop.sh
[Install]
	WantedBy=multi-user.target
" > "$dir/terraria.service"

read -p "Do you want to install the service now? " serv
case $serv in
	[Yy]* )
		ipath="/etc/systemd/system/terraria.service"
		sudo ln -sf "$(realpath "$dir/terraria.service")" "$ipath"
		systemctl daemon-reload
		echo "link to service file placed in $ipath"

		read -p "Do you want to automatically start the server on system startup? " autoinstall
		case $autoinstall in
			[Yy]* )
				systemctl enable terraria
			;;
			*)
				echo "To enable manually, run 'systemctl enable terraria'"
			;;
		esac
	;;
	*)
		echo "To install manually, copy or link '$dir/terraria.service' to a systemd service directory."
	;;
esac