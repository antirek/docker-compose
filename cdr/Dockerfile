FROM ubuntu:14.04.3

MAINTAINER Sergey Dmitriev <serge.dmitriev@gmail.com>

RUN apt-get install -y mysql-server


ADD after_start.sh /after_start.sh

RUN chmod +x /after_start.sh

CMD ["/after_start.sh"]