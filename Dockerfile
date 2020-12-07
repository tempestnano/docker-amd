FROM ghcr.io/linuxserver/baseimage-alpine:3.12 AS python

RUN apk add build-base python3 python3-dev py3-pip && \
    echo "*********** install python packages ***********" && \
	pip install wheel && \
	pip wheel --wheel-dir=/root/wheels \
		yq \
		mutagen \
		r128gain \
		deemix 

FROM ghcr.io/linuxserver/baseimage-alpine:3.12

COPY --from=python /root/wheels /root/wheels

ENV TITLE="Automated Music Downloader (AMD)"
ENV TITLESHORT="AMD"
ENV VERSION="1.1.4"
ENV MBRAINZMIRROR="https://musicbrainz.org"
ENV XDG_CONFIG_HOME="/config/deemix/xdg"
ENV DOWNLOADMODE="wanted"

RUN apk add --no-cache \
    bash \
    ca-certificates \
    curl \
    jq \
	flac \
	eyed3 \
    opus-tools \
	python3 \
	py3-pip \
    ffmpeg && \
    echo "************ install python packages ************" && \
	pip install \
      --no-index \
      --find-links=/root/wheels \
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