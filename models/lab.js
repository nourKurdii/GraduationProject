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
    name: {
        type: String,
    },
    phone: {
        type: String,
    },
    longitude: {
        type: float,
    },
    latitude: {
        type: float,
    },
    homeVisit: {
        type: Boolean,
    },
    test: {
        type: Array,
    },
    rating: {
        type: float,
    }

})