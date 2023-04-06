ARG PHP_VERSION=8.0.28

FROM php:${PHP_VERSION}-alpine

ARG PSALM_VERSION=5.9

# In this layer we will
# - update apk
# - install curl
# - install composer
# - remove curl as no longer is need
RUN apk update  && apk add --no-cache curl &&\
    curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer &&\
    apk --purge del curl
    
# In this layer we will install psalm. We separate this action to a different layer
# so wen we will need to change psalme version only this layer will be build
# speeding up the build time

RUN composer require --dev vimeo/psalm==${PSALM_VERSION}