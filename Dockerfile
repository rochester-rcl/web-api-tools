FROM python:3.9-alpine3.13
WORKDIR /home

RUN apk add --no-cache --virtual \
  libssl-dev \
  libressl-dev \
  openssl-dev \
  build-base \
  libffi-dev \
  linux-headers \
  rust \
  cargo \
  gcc \
  musl-dev \
  libc-dev \ 
  libxslt-dev \
  jpeg-dev \
  git \
  bash \
  && pip install twitch-python scrapy beautifulsoup4 twitter-scraper pytumblr praw \
  && git clone https://github.com/rochester-rcl/dhsi-multimedia-examples.git web_api_tools\
  && cd /home/web_api_tools/dhsi_multimedia \
  && python3 setup.py sdist && pip3 install -e . \
  && cd /home \ 
  && git clone https://github.com/JosephLai241/URS.git \
  && cd URS \
  && pip install -r requirements.txt

WORKDIR /home

CMD ["/bin/sh"]
