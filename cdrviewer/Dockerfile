FROM node:5.0.0-wheezy

RUN cd /tmp && \
	git clone https://github.com/antirek/viola-cdr.git

WORKDIR /tmp/viola-cdr

RUN npm install

RUN npm install bower -g

RUN bower install --allow-root

RUN mkdir -p /tmp/viola-cdr/public/js/build

RUN npm run build

ADD after_start.sh /after_start.sh

RUN chmod +x /after_start.sh

CMD ["/after_start.sh"]

