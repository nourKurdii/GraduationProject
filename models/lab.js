var mongoose = require('mongoose')
var Schema = mongoose.Schema;

var labSchema = new Schema({
    name:{
        type : String,
    },
    image:{
        type : String,
    },
    location:{
        type : String,
    },
    email: {
        type: String,
        require: true
    },
    password: {
        type: String,
        require: true
    },
    phone: {
        type: String,
    },
    longitude: {
        type: Number,
    },
    latitude: {
        type: Number,
    },
    homeVisit: {
        type: Boolean,
    },
    test: {
        type: Array,
    },
    rating: {
        type: Number,
    },
    openTime:{
        type: String,
    },
    closeTime: {
        type: String
    },
    ownerName: {
        type: String
    },
    about:{
        type: String
    }

})
module.exports = mongoose.model('Lab',labSchema)