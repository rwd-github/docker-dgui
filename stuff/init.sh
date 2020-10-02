#!/bin/bash

mypath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

disable_some_daemons(){
	pushd /etc/rc5.d
	rm *supervisor
	rm *apport
	rm *lightdm
	rm *gdm3
	rm *avahi-daemon
	rm *plymouth
	rm *saned
	popd
}

disable_some_daemons || true

set -o errexit -o pipefail -o nounset

cd ${mypath}
if [ -f "createuser.sh" ]; then
	./createuser.sh
fi

rm /var/run/xrdp/*.pid || true

setChromium() {
	orig=chromium
	if [ -f /usr/bin/${orig} ]; then
		rm /usr/bin/${orig}
		cp /usr/bin/${orig}--no-sandbox /usr/bin/${orig}
	fi
}

setChromium

# Start all
run-parts -a start /etc/rc5.d


# User Autostart
for myuser in $(ls /home); do
	autostartdir=/home/${myuser}/autostart
	if [ -d "${autostartdir}" ]; then
		echo "---  autostart user ${myuser}"
		su -s /bin/bash -c "run-parts ${autostartdir}" ${myuser} &
	fi
done


# Stop script
stop_script() {
	run-parts -a stop /etc/rc5.d
    exit 0
}
# Wait for supervisor to stop script
trap stop_script SIGINT SIGTERM

setChromium

while true
do
    uptime
    sleep 600
done
