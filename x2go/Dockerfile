FROM ubuntu:18.04 as sysbase

# Set the locale
RUN apt update \
	&& apt upgrade -y \
	&& apt install -y locales \
	&& locale-gen de_DE.UTF-8
ENV LANG de_DE.UTF-8
ENV LANGUAGE de_DE:de
ENV LC_ALL de_DE.UTF-8
RUN update-locale LANG=de_DE.utf8
ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update && apt-get upgrade -y \
	&& apt-get install -y \
	software-properties-common \
	&& apt-get update \
	&& apt-get install -y \
	x2goserver x2goserver-xsession
	
RUN apt-get update && apt-get upgrade -y \
	&& apt-get install -y \
	tmux \
	aptitude \
	nano \
	mc \
	dnsutils \
	net-tools \
	iputils-ping \
	less \
	telnet \
	sudo \
	htop \
	supervisor \
	xfce4 \
	xfce4-goodies \
	xfce4-terminal \
	xfwm4-themes \
	shiki-colors-xfwm-theme \
	firefox \
	firefox-locale-de \
	firefox-locale-en \
	chromium-browser \
	remmina \
	freerdp2-x11 \
	fonts-hack-ttf

RUN unlink /etc/localtime \
	&& ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

RUN mv /usr/bin/chromium-browser /usr/bin/chromium-browser.original
ADD chromium-browser /usr/bin/chromium-browser
RUN chmod +x /usr/bin/chromium-browser

VOLUME [ "/home" ]
EXPOSE 3389/tcp

RUN mkdir -p /var/log/supervisor
RUN mkdir -p /etc/supervisor/conf.d/
COPY supervisord.conf /root/supervisord.conf
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/root/supervisord.conf"]


FROM sysbase
ADD createuser.sh /root/createuser.sh
RUN chmod +x /root/createuser.sh
ADD init.sh /root/init.sh
RUN chmod +x /root/init.sh

