FROM phusion/baseimage:0.11
WORKDIR /home

RUN add-apt-repository ppa:ubuntu-toolchain-r/ppa

RUN apt-get -qq update && apt-get -qq -y --no-install-recommends install \
  build-essential \
  python3.7 \
  python3.7-dev \
  python3-setuptools \
  git \
  abiword \
  imagemagick

RUN curl https://bootstrap.pypa.io/get-pip.py | python3.7

RUN pip3 install --upgrade pip \
  && pip3 install twitch-python scrapy beautifulsoup4 twitterscraper urllib3

RUN git clone https://github.com/rochester-rcl/dhsi-multimedia-examples.git web_api_tools\
  && cd /home/web_api_tools/dhsi_multimedia \
  && python3 setup.py sdist && pip3 install -e .

RUN git clone https://github.com/minwook-shin/pytube.git pytube \
  && cd /home/pytube \
  && python3 setup.py sdist && pip3 install -e .

WORKDIR /home

CMD ["/bin/bash"]
