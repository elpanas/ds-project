const { Bath } = require('../models/bath');

// ADD A BATH
async function createBath(bath_data) {
    const bath = new Bath(bath_data);
    return await bath.save();
}

// SEARCH FOR BATHS USING CITY AND REGION INFOS
async function getBathDispLoc(city, prov) {
    return await Bath
        .find({
            av_umbrellas: { $gt: 0 }, // av_umbrellas > 0
            city: city,
            province: prov
        })        
        .sort({ av_umbrellas: 1, name: 1 }) // asc 
        .limit(20)
        .lean();
}

// SEARCH FOR BATHS USING COORDINATES
async function getBathDispCoord(lat, long) {
    return await Bath.find(
        {
            location: { 
                $near: { 
                    $geometry: { type: "Point", coordinates: [long,lat] },                  
                    $maxDistance: 3000
                }                              
            },
            av_umbrellas: { $gt: 0 }
        })
    .limit(20)
    .sort({ av_umbrellas: 1, name: 1 })
    .lean();
}

// RETURN A MANAGER'S BATHS LIST
async function getBathGest(uid) {  
    return await Bath
        .find({ uid: uid })      
        .sort({ nome: 1 })
        .lean();
}

// UPDATE BATH INFO
async function updateBath(bid, bath_data) {
    return await Bath
    .findByIdAndUpdate(
        bid,
        bath_data,
        { new: true }
    )
    .lean();
}

// UPDATE NUMBER OF AVAILABLE UMBRELLAS
async function updateUmbrellas(bid, available) {
    return await Bath
    .findByIdAndUpdate(
        bid,
        { av_umbrellas: available },
        { new: true }
    )
    .lean();
}

// DELETE A BATH
async function removeBath(bid) {
    return await Bath.findByIdAndDelete(bid).lean();
}

module.exports.createBath = createBath;
module.exports.getBathDispLoc = getBathDispLoc;
module.exports.getBathDispCoord = getBathDispCoord;
module.exports.getBathGest = getBathGest;
module.exports.updateBath = updateBath;
module.exports.updateUmbrellas = updateUmbrellas;
module.exports.removeBath = removeBath;
