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



FROM php:7.3-apache

RUN apt-get update && \
    apt-get install -y \
    git \
    zip \
    unzip
RUN apt-get install -y --no-install-recommends 
RUN docker-php-ext-install pdo pdo_mysql mysqli


# Configure Apache & clean
RUN a2enmod rewrite  
# ======= composer =======
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


#set our application folder as an environment variable
ENV APP_HOME /var/www/html

#change uid and gid of apache to docker user uid/gid
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

#change the web_root to laravel /var/www/html/public folder
RUN sed -i -e "s/html/html\/public/g" /etc/apache2/sites-enabled/000-default.conf

# enable apache module rewrite
RUN a2enmod rewrite

#copy source files and run composer
COPY . $APP_HOME

#change ownership of our applications
RUN chown -R www-data:www-data $APP_HOME

# install all PHP dependencies
RUN composer install

# copy ./run.sh /tmp 
# RUN chmod +x /tmp/run.sh  
# ENTRYPOINT ["/tmp/run.sh"]
