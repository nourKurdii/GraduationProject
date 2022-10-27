var mongoose = require('mongoose')
var Schema = mongoose.Schema;

var doctorSchema = new Schema({
    name:{
        type : String,
    },
    image:{
        type : String,
    },
    title:{
        type : String,
    },
    
})
module.exports = mongoose.model('Doctor',doctorSchema)