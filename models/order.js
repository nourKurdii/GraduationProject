var mongoose = require('mongoose')
var Schema = mongoose.Schema;
var orderSchema = new Schema({
    status:{
        type:String,
    },
    patientEmail: {
        type: String,
        require: true
    },
    labEmail: {
        type: String,
        require: true,
        ref: 'Lab'
    },
    test:{
        type:String,
        require: true
    },
    time:{
        type:String,
        require: true
    },
    date:{
        type:String,
        require:true
    },
    latitude:{
        type:String,
        require:true
    },
    longitude:{
        type:String,
        require:true
    },
    rating:{
        type:Number,
    },
    durationTime:{
        type:Number,
    }
})
module.exports = mongoose.model('Order', orderSchema)