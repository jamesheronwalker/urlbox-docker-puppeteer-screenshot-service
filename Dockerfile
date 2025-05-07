FROM node:22
EXPOSE 3000
WORKDIR /app
VOLUME /captures

ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV XDG_CACHE_HOME=/tmp/.chromium
ENV XDG_CONFIG_HOME=/tmp/.chromium

RUN apt-get update &&\
	apt-get install -y \
		chromium \
		libasound2 \
		libatk-bridge2.0 \
		libatk1.0 \
		libcups2 \
		libdbus-1-3 \
		libgbm1 \
		libjpeg62-turbo \
		libnss3 \
		libpng16-16 \
		libxcomposite1 \
		libxdamage1 \
		libxkbcommon0 \
		libxrandr2

COPY package.json .
COPY package-lock.json .
RUN npm ci

COPY main.js .

USER 1001
CMD ["main.js"]
