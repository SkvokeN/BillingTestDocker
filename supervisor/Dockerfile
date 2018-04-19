FROM php:7.1.12-cli

ARG HOST_UID
ARG USER

RUN apt-get update && apt-get install -y apt-utils

RUN apt-get update && apt-get install -y \
    libicu-dev \
    apt-transport-https \
    zip \
    libpng-dev \
    libmcrypt-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    git \
    libxml++2.6-dev \
    tidy \
    libv8-3.14.5 \
    wget \
    xvfb \
    libfontconfig \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mbstring \
    zip \
    intl \
    pdo \
    pdo_mysql \
    bcmath \
    iconv \
    mcrypt \
    soap \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Install Supervisor.
RUN \
  apt-get update && \
  apt-get install -y supervisor && \
  rm -rf /var/lib/apt/lists/* && \
  sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf

RUN update-rc.d supervisor defaults
RUN apt-get update | apt-get upgrade -y
RUN apt-get install libpam-cracklib -y
RUN ln -s /lib/x86_64-linux-gnu/security/pam_cracklib.so /lib/security


RUN useradd -l --shell /bin/bash -u $HOST_UID -o -c "" -m $USER

WORKDIR /app

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
