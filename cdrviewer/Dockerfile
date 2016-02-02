FROM node:5.0.0-wheezy

RUN cd /tmp && \
    git clone https://github.com/antirek/violacdr.git

WORKDIR /tmp/violacdr

RUN npm install && \
    npm install bower -g && \
    bower install --allow-root && \
    mkdir -p /tmp/violacdr/public/js/build && \
    npm run build

RUN apt-get update && \
    apt-get install -y mysql-client-5.5

CMD node /tmp/violacdr/app.js