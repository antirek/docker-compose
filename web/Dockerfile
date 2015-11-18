FROM node:5.0.0-wheezy

RUN cd /tmp && \
	git clone https://github.com/antirek/viola-configurator.git

WORKDIR /tmp/viola-configurator

RUN npm install mongoose

RUN npm install

RUN npm install bower -g

RUN bower install --allow-root

RUN npm install gulp -g

RUN gulp

