var mongoose = require('mongoose')
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt')
const saltRounds =10;

var doctorSchema = new Schema({
    name:{
        type : String,
    },
    
    title:{
        type : String,
    },
    phone:{
        type: String,
    },
    email:{
        type:String
    },
    password:{
        type:String
    },
    image: {
        type: String
    },
    unAvailableTime:{
        type: Array
    }
    
})
doctorSchema.pre('save', function(next){
    var doctor = this;
    if(this.isModified('password') || this.isNew){
        bcrypt.genSalt(saltRounds, function (err, salt){
            if(err){
                return next(err)
            }
            bcrypt.hash(doctor.password, salt, function(err,hash){
                if(err){
                    return next(err)
                }
                doctor.password=hash;
                next()
            })
        })
    }
    else {
        return next()
    }
})

doctorSchema.methods.comparePassword = function (passw, cb) {
    bcrypt.compare(passw,this.password, function(err,isMatch){
        if(err){
            return cb(err)
        }
        cb(null, isMatch)
    })
}
module.exports = mongoose.model('Doctor',doctorSchema)