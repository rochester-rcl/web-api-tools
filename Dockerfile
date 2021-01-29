FROM python:3.9-alpine3.12
WORKDIR /home

RUN apk add --no-cache --virtual \
  libressl-dev \
  libssl-dev \
  openssl-dev \
  libffi-dev \
  linux-headers \
  gcc \
  musl-dev \
  libc-dev \ 
  libxslt-dev \
  git \
  && pip install twitch-python scrapy beautifulsoup4 twitter-scraper pytumblr \
  && git clone https://github.com/rochester-rcl/dhsi-multimedia-examples.git web_api_tools\
  && cd /home/web_api_tools/dhsi_multimedia \
  && python3 setup.py sdist && pip3 install -e . \
  && apk del \
  libssl-dev \
  libressl \
  openssl-dev \
  libffi-dev \
  linux-headers \
  gcc \
  musl-dev \
  libc-dev \
  libxslt-dev \
  git

WORKDIR /home

CMD ["/bin/bash"]
