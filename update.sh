#!/bin/bash

ls | egrep -v "README.md|update.sh" | xargs rm -rf 
git clone https://github.com/docker-library/php.git

for i in `find php -name "Dockerfile" | grep -v alpine`; do

	DIR=`dirname $i | sed 's|php/||g'`
    TAG=`echo $DIR | sed 's|/|-|g'`
    TAG="php:${TAG}"
	FILE="${DIR}/Dockerfile"
    
	mkdir -p ${DIR}

	echo "FROM ${TAG}" > $FILE
	echo '' >> $FILE
	echo 'MAINTAINER docker@mikeditum.co.uk' >> $FILE
	echo '' >> $FILE
    echo 'RUN apt-get update && \' >> $FILE
    echo '    apt-get install -y libmagickwand-dev libldap2-dev && \' >> $FILE
    echo '    apt-get clean' >> $FILE
    echo '' >> $FILE
    echo 'RUN pecl install imagick && \' >> $FILE
    echo '    docker-php-ext-enable imagick' >> $FILE
    echo '' >> $FILE
    echo 'RUN docker-php-ext-install -j$(nproc) mysqli && \' >> $FILE
    echo '    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \' >> $FILE
    echo '    docker-php-ext-install -j$(nproc) gd && \' >> $FILE
    echo '    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \' >> $FILE
    echo '    docker-php-ext-install ldap && \' >> $FILE
    echo '    docker-php-ext-install -j$(nproc) exif && \' >> $FILE
    echo '    docker-php-ext-install -j$(nproc) zip && \' >> $FILE
    echo '    docker-php-ext-install -j$(nproc) pcntl' >> $FILE
done

rm -rf php
