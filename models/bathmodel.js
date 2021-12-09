const mongoose = require('mongoose');

const stringOpts = {
  type: String,
  required: true,
};
const numberOpts = {
  type: Number,
  default: 0,
};
const bathSchema = new mongoose.Schema({
  name: stringOpts,
  city: String,
  province: String,
  location: {
    type: {
      type: String,
      enum: ['Point'],
    },
    coordinates: [Number],
  },
  tot_umbrellas: numberOpts,
  av_umbrellas: numberOpts,
  uid: stringOpts,
  phone: String,
});

// bathSchema.index({ location: '2dsphere' });
bathSchema.index({ name: 1, city: 1, province: 1 }, { unique: true });

const Bath = mongoose.model('stabilimenti', bathSchema);

module.exports.Bath = Bath;
