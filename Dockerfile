FROM php:7.3.6-fpm-alpine3.9

LABEL maintainer="Alley M. Carvalho <alleycarvalho@gmail.com>"

#####################################################################
# RUN Setup:
#####################################################################

RUN apk update && apk upgrade \
    # Install dependencies, softwares, etc.
    && apk add \
    bash \
    mysql-client \
    # PHP dependencies
    && docker-php-ext-install \
        pdo \
        pdo_mysql \
    # Remove cache
    && rm -rf /tmp/* /var/cache/apk/* \
    # Remove html
    && rm -rf /var/www/html

#####################################################################
# Final:
#####################################################################

# Set default work directory
WORKDIR /var/www

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN ln -s public html

EXPOSE 9000

ENTRYPOINT ["php-fpm"]
