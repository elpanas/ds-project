const mongoose = require('mongoose');
const redisMongoose = require('redis_mongoose');
const {
  db: { uri, options },
  redis: { redisUri },
} = require('../config/config');

redisMongoose.init(mongoose, redisUri);

mongoose.connect(uri, options);
// .then(() => console.log('Connected to MongoDB...'));
// .catch((err) => console.error('Could not connect to MongoDB...', err));
