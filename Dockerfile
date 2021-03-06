FROM node:8.15.1-alpine

# Install all build dependencies
# Add bash for debugging purposes
RUN apk update \
  && apk add --virtual build-dependencies \
  build-base \
  python \
  wget \
  git \
  && apk add \
  bash

WORKDIR /app
COPY package.json .

# Install all npm dependencies
# Cleanup
RUN npm install --silent --production \
  && apk del build-dependencies \
  && rm -rf /var/cache/apk/*

# Copy entire app over
COPY . /app

EXPOSE 8080

CMD ["npm", "start"]