FROM phusion/baseimage:0.11
WORKDIR /home

RUN add-apt-repository ppa:ubuntu-toolchain-r/ppa

RUN apt-get -qq update && apt-get -qq -y --no-install-recommends install \
  build-essential \
  ghostscript \
  libgs-dev \
  python3.7 \
  python3.7-dev \
  python3-setuptools \
  ffmpeg \
  sox \
  libsox-fmt-mp3 \
  git \
  imagemagick

RUN curl https://bootstrap.pypa.io/get-pip.py | python3.7 \
  && pip3 install --upgrade pip \
  && pip3 install twitch-python scrapy beautifulsoup4 twitter-scraper shub internetarchive scipy \
  && git clone https://github.com/rochester-rcl/dhsi-multimedia-examples.git web_api_tools\
  && cd /home/web_api_tools/dhsi_multimedia \
  && python3 setup.py sdist && pip3 install -e . \
  && cd /home \
  && git clone https://github.com/minwook-shin/pytube.git pytube \
  && cd /home/pytube \
  && python3 setup.py sdist && pip3 install -e . 

# Copied from https://stackoverflow.com/questions/53377176/change-imagemagick-policy-on-a-dockerfile
ARG imagemagic_config=/etc/ImageMagick-6/policy.xml

RUN /bin/bash -c "if [[ -f $imagemagic_config ]] ; then sed -i 's/<policy domain=\"coder\" rights=\"none\" pattern=\"PDF\" \/>/<policy domain=\"coder\" rights=\"read|write\" pattern=\"PDF\" \/>/g' $imagemagic_config ; else echo did not see file $imagemagic_config ; fi"

WORKDIR /home

CMD ["/bin/bash"]
