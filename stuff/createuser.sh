#!/bin/bash
set -o errexit -o pipefail -o nounset

echo "===  createuser start"
for myuser in $(ls /home); do
	echo "---  add user ${myuser}"
	if [ ! $(id -u ${myuser} 2>/dev/null) ]; then
		pushd /home/${myuser} >/dev/null
		if [ -f .myuser ]; then
			. ./.myuser
			addgroup --gid ${gid} ${myuser}
			adduser --uid ${uid} --gid ${gid} \
				--disabled-password \
				--no-create-home --gecos "" ${myuser}

			usermod -p "${pass}" ${myuser}
			# add groups
			for gr in ${groups}; do
				usermod -a -G ${gr} ${myuser}
			done
			olduid=$(stat -c '%u' .myuser)
			oldgid=$(stat -c '%g' .myuser)
			chown -R ${uid}:${gid} .
			chown ${olduid}:${oldgid} .myuser
		else
			echo " no password found"
		fi

		popd >/dev/null
	else
		echo "  user already exists."
	fi
done
echo "===  createuser stop"

