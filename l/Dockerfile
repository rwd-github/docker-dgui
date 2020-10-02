FROM rwd1/dgui:latest

RUN apt-get update && apt-get upgrade -y -q \
	&& apt-get install -y -q \
	openssh-server \
	git git-gui \
	git-cola \
	keepassxc \
	evince \
	vlc \
	geany \
	geany-plugins \
	actiona \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 22/tcp
