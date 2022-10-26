var mongoose = require('mongoose')
var Schema = mongoose.Schema;

var labSchema = new Schema({
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