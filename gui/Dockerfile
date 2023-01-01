FROM node:14
LABEL maintaner "Kouji Takao, Seiya Aozasa"

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN set -eux && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    less \
    lv \
    vim

COPY scratch-vm/package.json scratch-vm/package-lock.json /app/gui/scratch-vm/
RUN cd /app/gui/scratch-vm && npm install
COPY scratch-vm /app/gui/scratch-vm
RUN cd /app/gui/scratch-vm && npm link

COPY smalruby3-gui/package.json smalruby3-gui/package-lock.json /app/gui/smalruby3-gui/
RUN cd /app/gui/smalruby3-gui && npm install
COPY smalruby3-gui /app/gui/smalruby3-gui
RUN cd /app/gui/smalruby3-gui && npm link scratch-vm

WORKDIR /app/gui/smalruby3-gui

EXPOSE 8601

CMD ["npm","start"]
