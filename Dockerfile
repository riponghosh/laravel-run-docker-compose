#FROM ubuntu

#RUN apt-get update

#RUN apt-get install -y apache2 && apt-get clean
#ENV DEBIAN_FRONTEND=noninteractive
#RUN apt-get install -y php
#RUN apt-get install -y composer
#RUN apt-get install -y php-mysql



#WORKDIR /var/www/html

#ADD . /var/www/html
#EXPOSE 8000
#ENV DB_DATABASE laravel
#CMD ["./run.sh"]



FROM php:7.2-apache

RUN apt-get update && \
    apt-get install -y --no-install-recommends 
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Configure Apache & clean
RUN a2enmod rewrite  
# ======= composer =======
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Set locales
#RUN locale-gen en_US.UTF-8 en_GB.UTF-8 de_DE.UTF-8 es_ES.UTF-8 fr_FR.UTF-8 it_IT.UTF-8 km_KH sv_SE.UTF-8 fi_FI.UTF-8


WORKDIR /app
ADD . /app

CMD ["./run.sh"]