var mongoose = require('mongoose')
var Schema = mongoose.Schema;

var testSchema = new Schema({
    name: {
        type: String,
        require: true
    },
    price: {
        type: String,
        require: true
    },
    description: {
        type: String,
    },
    homeVisit: {
        type: Boolean,
    },
    category: {
        type: String,
        require: true
    },

})