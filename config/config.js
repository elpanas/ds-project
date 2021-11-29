require('dotenv').config();

const mongoHost = process.env.MONGO_HOST;
const mongoPort1 = process.env.MONGO_PORT1;
const mongoPort2 = process.env.MONGO_PORT2;
const mongoPort3 = process.env.MONGO_PORT3;
const mongoDb = process.env.MONGO_DB;

const config = {
  app: {
    port: process.env.WEB_SERVICE_PORT || 3000,
    auth: process.env.HASH_AUTH,
  },
  db: {
    uri: `mongodb://${mongoHost}:${mongoPort1},${mongoHost}:${mongoPort2},${mongoHost}:${mongoPort3}/${mongoDb}?replicaSet=beachu_set`,
    options: {
      useUnifiedTopology: true,
      autoIndex: false,
      autoCreate: true,
    },
  },
  redis: {
    redisUri: process.env.REDIS_URL,
    time: 120,
  },
  numCPUs: require('os').cpus().length,
};

module.exports = config;
