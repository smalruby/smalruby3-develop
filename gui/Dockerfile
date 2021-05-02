FROM node:10
LABEL maintaner "Kouji Takao, Seiya Aozasa"

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

COPY scratch-vm/package.json scratch-vm/package-lock.json /app/gui/scratch-vm/
COPY smalruby3-gui/package.json smalruby3-gui/package-lock.json /app/gui/smalruby3-gui/

RUN set -eux && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    less \
    lv \
    vim

RUN cd /app/gui/scratch-vm && npm install && npm link

RUN cd /app/gui/smalruby3-gui && npm install && npm link scratch-vm

COPY scratch-vm /app/gui/scratch-vm
COPY smalruby3-gui /app/gui/smalruby3-gui

WORKDIR /app/gui/smalruby3-gui

EXPOSE 8601

CMD ["npm","start"]
