FROM python:3.6

ENV PYTHONUNBUFFERED=1 \
    VIRTUAL_ENV=/usr/local \
    PIP_INSTALL_OPTIONS="--src /usr/local/src"

RUN echo 'alias l="ls -lsah"' > ~/.bashrc \
 && mkdir -p /app /req

WORKDIR /app

RUN echo "Install base Debian dependencies..." \
 && apt-get -y update \
 && apt-get -y upgrade \
 && apt-get -y install apt-transport-https lsb-release vim git curl sudo \
 && pip install --upgrade pip wheel setuptools

RUN echo "Install NodeJS and YARN..." \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
 && apt-get install -y nodejs yarn

