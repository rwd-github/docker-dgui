FROM debian:testing as gui-textonly
#FROM dyne/devuan:ascii as gui-textonly

# Set the locale
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y locales tzdata
#	&& locale-gen de_DE.UTF-8 en_US.UTF-8
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
	&& localedef -i de_DE -c -f UTF-8 -A /usr/share/locale/locale.alias de_DE.UTF-8

ENV LANG de_DE.UTF-8
#ENV LANGUAGE de_DE:de
#ENV LC_ALL de_DE.UTF-8
#RUN update-locale LANG=de_DE.utf8

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y \
	&& apt-get install -y -q \
	tmux \
	aptitude \
	nano \
	mc \
	dnsutils \
	net-tools \
	iputils-ping \
	less \
	telnet \
	rsync \
	sudo \
	htop \
	supervisor \
	python3-pip \
	curl \
	par2 unrar-free libffi-dev libssl-dev \
	whois \
	ecryptfs-utils \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

RUN unlink /etc/localtime \
	&& ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

RUN mkdir -p /var/log/supervisor \
			/etc/supervisor/conf.d/


FROM gui-textonly as gui-base
RUN apt-get update && apt-get upgrade -y \
	&& apt-get install -y -q \
	xorgxrdp \
	xrdp \
	xfce4 \
	xfce4-goodies \
	xfce4-terminal \
	firefox-esr \
	firefox-esr-l10n-de \
	remmina \
	freerdp2-x11 \
	fonts-hack-ttf \
	xterm \
	clusterssh \
	doublecmd-qt \
	espeak \
	catfish \
	glogg \
	idle3 \
	chromium \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* \
	&& usermod -a -G ssl-cert xrdp

#	xfwm4-themes \
#	chromium-browser \


VOLUME [ "/home" ]
EXPOSE 3389/tcp


FROM gui-base
COPY stuff/ /stuff/
RUN chmod +x /stuff/*.sh

### Chromiumstuff
RUN chmod +x /stuff/chromium/mklink.sh && /stuff/chromium/mklink.sh

ENTRYPOINT [ "/usr/bin/supervisord", "-c", "/stuff/supervisord.conf" ]
