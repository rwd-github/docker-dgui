FROM rwd1/dgui-l:latest

RUN apt-get update && apt-get upgrade -y -q \
	&& apt-get install -y -q \
	subversion \
	evolution \
	libreoffice \
	libreoffice-l10n-de \
	hunspell-de-de \
	gimp \
	gimp-help-de \
	zenity \
	x2goclient \
	gnome-mahjongg \
	gnome-mines \
	apt-transport-https \
	unattended-upgrades \
	seahorse \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*
#	rapidsvn \

RUN sed -i 's/\/\/\t\(...distro_id\)/\1/g' /etc/apt/apt.conf.d/50unattended-upgrades

#COPY xl/supervisord.conf.part /root/supervisord.conf.part
#RUN cat /root/supervisord.conf.part >> /etc/supervisor/conf.d/supervisord.conf

# VS Code
ADD https://go.microsoft.com/fwlink/?LinkID=760868 /root/code.deb
RUN dpkg -i /root/code.deb

# Signal
RUN curl -s https://updates.signal.org/desktop/apt/keys.asc | apt-key add - \
	&& echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list \
	&& apt-get update && apt-get install -y signal-desktop
	
# Syncthing
RUN curl -s https://syncthing.net/release-key.txt | sudo apt-key add - \
	&& echo "deb https://apt.syncthing.net/ syncthing stable" | tee /etc/apt/sources.list.d/syncthing.list \
	&& apt-get update && apt-get install -y syncthing
