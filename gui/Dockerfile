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
    vim \
    chromium \
    chromium-driver \
    libgl1-mesa-dri \
    libglapi-mesa \
    libosmesa6 \
    fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1

# Link chromium to google-chrome just in case
RUN ln -s /usr/bin/chromium /usr/bin/google-chrome

ENV NODE_OPTIONS --max-old-space-size=4000

EXPOSE 8601

COPY entrypoint.sh /app/gui/entrypoint.sh
RUN chmod +x /app/gui/entrypoint.sh
ENTRYPOINT ["/app/gui/entrypoint.sh"]
CMD npm start