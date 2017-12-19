FROM ubuntu:trusty
RUN rm -f /etc/resolv.conf && echo '8.8.8.8' > /etc/resolv.conf
RUN apt-get update

RUN apt-get install -y software-properties-common && \
  add-apt-repository -y ppa:ubuntu-toolchain-r/test && apt-get update && \
  apt-get install -y g++-7

# Upgrade git (and other deps needed)
RUN add-apt-repository -y ppa:git-core/ppa && apt-get update && \
  apt-get install -y git curl vim libtool automake autoconf make

# Export newest gcc
ENV CC=gcc-7 CXX=g++-7

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
