FROM node:20-bookworm-slim
LABEL maintaner "Kouji Takao, Seiya Aozasa"

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN \
  set -eux \
  && apt update \
  && apt install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    git \
    curl \
    less \
    lv \
    vim

RUN \
  set -eux \
  && apt update \
  && apt install -y gnupg \
  && curl -fSsL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg \
  && sh -c 'echo deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main > /etc/apt/sources.list.d/google-chrome.list' \
  && apt update \
  && apt install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
    --no-install-recommends

RUN \
  apt update \
  && apt install -y unzip graphviz \
  && CHROME_VERSION=$(google-chrome-stable --version | cut -d " " -f3) \
  && echo "Chrome_Version: ${CHROME_VERSION}" \
  && curl -sS -o /root/chromedriver_linux64.zip https://storage.googleapis.com/chrome-for-testing-public/$CHROME_VERSION/linux64/chromedriver-linux64.zip \
  && unzip ~/chromedriver_linux64.zip -d ~/ \
  && rm ~/chromedriver_linux64.zip \
  && chown root:root ~/chromedriver-linux64/chromedriver \
  && chmod 755 ~/chromedriver-linux64/chromedriver \
  && mv ~/chromedriver-linux64/chromedriver /usr/bin/chromedriver

# chromedriverをnpmでインストールするときに適切なバージョンをインストールする
ENV DETECT_CHROMEDRIVER_VERSION true
ENV NODE_OPTIONS --max-old-space-size=4000

EXPOSE 8601

# node_modulesをvolumeとしてマウントするが、scratch-vmのnpm linkは保持されないため、このタイミングで作成しておく
RUN mkdir -p /usr/local/lib/node_modules/ && ln -sf ../../../../app/gui/scratch-vm /usr/local/lib/node_modules/scratch-vm

COPY entrypoint.sh /app/gui/entrypoint.sh
RUN chmod +x /app/gui/entrypoint.sh
ENTRYPOINT ["/app/gui/entrypoint.sh"]
CMD npm start
