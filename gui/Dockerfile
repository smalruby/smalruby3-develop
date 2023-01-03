FROM node:14-slim
LABEL maintaner "Kouji Takao, Seiya Aozasa"

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN set -eux \
  && apt update \
  && apt install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    git \
    curl \
    less \
    lv \
    vim \
  && rm -rf /var/lib/apt/lists/*

COPY scratch-vm/package.json scratch-vm/package-lock.json /app/gui/scratch-vm/
COPY smalruby3-gui/package.json smalruby3-gui/package-lock.json /app/gui/smalruby3-gui/

RUN cd /app/gui/scratch-vm && npm install && npm link
RUN cd /app/gui/smalruby3-gui && npm install && npm link scratch-vm

WORKDIR /app/gui/smalruby3-gui

EXPOSE 8601

CMD ["npm","start"]
