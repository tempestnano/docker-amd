FROM alpine:latest

ENV TITLE="Automated Music Downloader (AMD)"
ENV TITLESHORT="AMD"
ENV VERSION="1.1.3"
ENV MBRAINZMIRROR="https://musicbrainz.org"
ENV XDG_CONFIG_HOME="/config/deemix/xdg"
ENV DOWNLOADMODE="wanted"

RUN apk add --no-cache \
    bash \
    ca-certificates \
    curl \
    ip6tables \
    iptables \
    jq \
	mp3val \
	flac \
	eyed3 \
    opus-tools \
	python3 \
    ffmpeg && \

    echo "************ install python packages ************" && \
	python3 -m pip install --no-cache-dir -U \
		yq \
		mutagen \
		r128gain \
		deemix && \
	echo "************ setup dl client config directory ************" && \
	echo "************ make directory ************" && \
	mkdir -p "${XDG_CONFIG_HOME}/deemix"

    # copy local files
COPY root/ /

WORKDIR /config

# ports and volumes
VOLUME /config
