FROM debian:jessie
RUN rm -f /etc/resolv.conf && echo '8.8.8.8' > /etc/resolv.conf

RUN echo deb http://ftp.de.debian.org/debian buster main >> /etc/apt/sources.list

RUN apt-get update && \
  apt-get install -y software-properties-common g++-7

# Upgrade git (and other deps needed)
RUN apt-get update && \
  apt-get install -y git curl vim libtool automake autoconf make python

# Install Node.js
RUN curl -fs https://raw.githubusercontent.com/mafintosh/node-install/master/install | sh && \
  node-install 8.9.1 && \
  npm config set loglevel http && \
  npm config set progress false && \
  npm config set package-lock false && \
  npm config set save false && \
  mkdir -p ~/.config/configstore/ && \
  printf '{"optOut": true,"lastUpdateCheck": 0}' > ~/.config/configstore/update-notifier-npm.json

COPY build.sh /root/build.sh
