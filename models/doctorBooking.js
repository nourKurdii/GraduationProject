var mongoose = require('mongoose')
var Schema = mongoose.Schema;
var bookingSchema = new Schema({
    status:{
        type:String,
    },
    patientEmail: {
        type: String,
        require: true
    },
    doctorEmail: {
        type: String,
        require: true,
        ref: 'Doctor'
    },
    time:{
        type:String,
        require: true
    },
    date:{
        type:String,
        require:true
    },
    
})
module.exports = mongoose.model('doctorBooking', bookingSchema)