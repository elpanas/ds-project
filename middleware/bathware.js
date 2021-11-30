const { clearCache } = require('redis_mongoose');
const Objectid = require('mongoose').Types.ObjectId;
const { Bath } = require('../models/bath');
const {
  redis: { time },
} = require('../config/config');

const cacheOptions = { ttl: time };
const sortUmbrellaOptions = { av_umbrellas: 1, name: 1 };

module.exports = {
  // ADD A BATH
  createBath: async (bathData) => {
    try {
      clearCache();
      return await Bath.create(bathData);
    } catch (e) {
      return false;
    }
  },

  // SEARCH FOR BATHS USING COORDINATES
  getBathDispCoord: async (lat, long) =>
    Bath.find({
      location: {
        $near: {
          $geometry: { type: 'Point', coordinates: [long, lat] },
          $maxDistance: 3000, // meters
        },
      },
      av_umbrellas: { $gt: 0 },
    })
      .limit(20)
      .sort(sortUmbrellaOptions)
      .lean()
      .cache(cacheOptions),

  // GET SINGLE BATH
  getBath: async (bid) => {
    if (Objectid.isValid(bid)) {
      return Bath.find({ _id: bid }).lean().cache(cacheOptions);
    }
    return false;
  },

  // RETURN A MANAGER'S BATHS LIST
  getBathGest: async (uid) =>
    Bath.find({ uid }).sort({ name: 1 }).lean().cache(cacheOptions),

  // UPDATE BATH INFO
  updateBath: async (bid, bathData) => {
    if (Objectid.isValid(bid)) {
      clearCache();
      return Bath.findByIdAndUpdate(bid, bathData, {
        new: true,
      }).lean();
    }
    return false;
  },

  // UPDATE NUMBER OF AVAILABLE UMBRELLAS
  updateUmbrellas: async (bid, available) => {
    if (Objectid.isValid(bid)) {
      clearCache();
      return Bath.findByIdAndUpdate(
        bid,
        { av_umbrellas: available },
        { new: true }
      ).lean();
    }
    return false;
  },

  // DELETE A BATH
  removeBath: async (bid) => {
    if (Objectid.isValid(bid)) {
      clearCache();
      return Bath.findByIdAndDelete(bid).lean();
    }
    return false;
  },
};
