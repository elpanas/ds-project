FROM node:16
ENV MONGO_HOST="192.168.0.3" \
MONGO_PORT1=40001 \
MONGO_PORT2=40002 \
MONGO_PORT3=40003 \
MONGO_DB="beachudb" \
MONGO_DB_TEST="beachudbtest" \
WEB_SERVICE_PORT=3000
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
#RUN chown -R node /usr/src/app
#USER node
CMD ["node", "server.js"]
