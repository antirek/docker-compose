FROM node:5.0.0-wheezy

RUN cd /tmp && \
	git clone https://github.com/antirek/viola-cdr.git

WORKDIR /tmp/viola-cdr

RUN npm install && \
	npm install bower -g && \
	bower install --allow-root && \
	mkdir -p /tmp/viola-cdr/public/js/build && \
	npm run build

RUN apt-get update && \
	apt-get install -y mysql-client-5.5

RUN echo "4"

ADD after_start.sh /after_start.sh


RUN chmod +x /after_start.sh

CMD ["/after_start.sh"]