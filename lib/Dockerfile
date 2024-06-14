FROM ruby:2.3.8-slim-jessie

LABEL maintaner "Kouji Takao"

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN rm -f /etc/apt/sources.list \
  && echo "deb http://archive.debian.org/debian/ jessie main" | tee -a /etc/apt/sources.list \
  && echo "deb http://archive.debian.org/debian-security/ jessie/updates main" | tee -a /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y --force-yes --no-install-recommends \
  build-essential \
  git \
  curl \
  less \
  lv \
  vim

RUN apt-get install -y --force-yes --no-install-recommends \
  libsdl1.2-dev \
  libsdl-image1.2-dev \
  libsdl-mixer1.2-dev \
  timidity \
  libsdl-ttf2.0-dev \
  libsdl-sge-dev \
  fonts-horai-umefont \
  fonts-ipafont

RUN apt-get install -y --force-yes --no-install-recommends \
  xauth \
  xvfb \
  x11vnc \
  xterm \
  novnc \
  websockify

RUN mkdir -p /root/.vnc/ && \
  x11vnc -storepasswd smalruby /root/.vnc/passwd

RUN gem install bundler:1.17.3

COPY dxruby_sdl/Gemfile dxruby_sdl/dxruby_sdl.gemspec /app/lib/dxruby_sdl/
COPY dxruby_sdl/lib/dxruby_sdl/version.rb /app/lib/dxruby_sdl/lib/dxruby_sdl/
RUN cd /app/lib/dxruby_sdl && bundle install

COPY smalruby3/Gemfile smalruby3/smalruby3.gemspec /app/lib/smalruby3/
COPY smalruby3/lib/smalruby3/version.rb /app/lib/smalruby3/lib/smalruby3/
RUN cd /app/lib/smalruby3 && bundle install

COPY entrypoint.sh /app/lib/

WORKDIR /app/lib/smalruby3

CMD /app/lib/entrypoint.sh
