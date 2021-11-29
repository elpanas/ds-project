const mongoose = require('mongoose');
const redisMongoose = require('redis_mongoose');
const { MongoMemoryServer } = require('mongodb-memory-server');
const { RedisMemoryServer } = require('redis-memory-server');

const redisServer = new RedisMemoryServer();
const mongoServer = new MongoMemoryServer();

(async () => {
  const redisHost = await redisServer.getIp();
  const redisPort = await redisServer.getPort();
  redisMongoose.init(mongoose, `redis://${redisHost}:${redisPort}`);
  await mongoServer.start();
  await mongoose.connect(mongoServer.getUri(), { dbName: 'beachudbtest' });
})();

module.exports.redisServer = redisServer;
