FROM ubuntu:focal

RUN apt-get update \
	&& apt-get --no-install-recommends install -y wget tzdata gnupg gettext-base \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ENV	TZ=Europe/Vilnius
RUN	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN	wget -q -O - http://nimblestreamer.com/gpg.key | apt-key add -
RUN	echo "deb http://nimblestreamer.com/ubuntu focal/" >> /etc/apt/sources.list

RUN	apt-get update \
	&& apt-get install nimble nimble-srt -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN chown -R nimble /etc/nimble

USER nimble

RUN ln -s /dev/stderr /var/log/nimble/nimble.log

EXPOSE 1935 8081

CMD	envsubst '$$TOKEN,$$NODE_NAME' < /etc/nimble-dist/nimble.conf > /etc/nimble/nimble.conf && \
	cp /etc/nimble-dist/rules.conf /etc/nimble/rules.conf && \
	/usr/bin/nimble --conf-dir=/etc/nimble --log-dir=/var/log/nimble