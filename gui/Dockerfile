FROM node:20-bookworm-slim
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

RUN set -eux \
    && apt update \
    && apt install -y gnupg \
    && curl -sSL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt update \
    && apt install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# chromedriverをnpmでインストールするときに適切なバージョンをインストールする
ENV DETECT_CHROMEDRIVER_VERSION true
ENV NODE_OPTIONS --max-old-space-size=4000

WORKDIR /app/gui/smalruby3-gui

EXPOSE 8601
