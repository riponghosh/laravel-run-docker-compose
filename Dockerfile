FROM ubuntu

RUN apt-get update

RUN apt-get install -y apache2 && apt-get clean
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y php
RUN apt-get install -y composer
RUN apt-get install -y php-mysql



WORKDIR /var/www/html

ADD . /var/www/html
EXPOSE 8000
#CMD apachectl -D FOREGROUND
ENV DB_DATABASE laravel
CMD ["./run.sh"]
#ENTRYPOINT ["./run.sh"]
#CMD php artisan serve --host=0.0.0.0