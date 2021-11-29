const mongoose = require('mongoose');
const bathSchema = new mongoose.Schema({
    name: {
        type: String, required: true
    },
    city: String,
    province: String,
    location: {
        type: {
            type: String,
            enum: ['Point']          
        },
        coordinates: [Number]
    },
    tot_umbrellas: {
        type: Number, default: 0
    },
    av_umbrellas: {
        type: Number, default: 0
    },
    uid: {
        type: String, required: true
    },
    phone: String
}).index(
    { name: 1, city: 1, province: 1 },
    { location: '2dsphere' },
    { unique: true });

const Bath = mongoose.model('stabilimenti', bathSchema);

exports.Bath = Bath;