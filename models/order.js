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
    testName:{
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
        type:Number,
        require:true
    },
    longitude:{
        type:Number,
        require:true
    },
    rating:{
        type:Number,
    },
    homeVisit:{
        type:Boolean
    },
    TestResult:{
        type: Number,
    }
})
module.exports = mongoose.model('Order', orderSchema)