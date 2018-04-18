FROM php:7.1.12-cli

ARG DEBIAN_FRONTEND=noninteractive
ARG HOST_UID
ARG USER

RUN apt-get update && apt-get install -y \
    apt-utils \
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
    wget \
    xvfb \
    libfontconfig

RUN docker-php-ext-install mbstring \
    zip \
    intl \
    pdo \
    pdo_mysql \
    bcmath \
    iconv \
    mcrypt \
    soap \
    sockets \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN yes | pecl install apcu-5.1.11 xdebug-2.5.5

# Setup of composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

RUN useradd -l --shell /bin/bash -u $HOST_UID -o -c "" -m $USER

RUN mkdir -p /.composer
ENV COMPOSER_HOME /.composer
RUN composer global require hirak/prestissimo
RUN chown -R $HOST_UID /.composer
RUN chmod 755 /.composer

RUN apt-get remove -y make g++ chrpath && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

CMD ["php"]
