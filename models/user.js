var mongoose = require('mongoose')
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt')
const saltRounds =10;

var userSchema = new Schema({
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
    }
})

userSchema.pre('save', function(next){
    var user = this;
    if(this.isModified('password') || this.isNew){
        bcrypt.genSalt(saltRounds, function (err, salt){
            if(err){
                return next(err)
            }
            bcrypt.hash(user.password, salt, function(err,hash){
                if(err){
                    return next(err)
                }
                user.password=hash;
                next()
            })
        })
    }
    else {
        return next()
    }
})

userSchema.methods.comparePassword = function (passw, cb) {
    bcrypt.compare(passw,this.password, function(err,isMatch){
        if(err){
            return cb(err)
        }
        cb(null, isMatch)
    })
}

module.exports = mongoose.model('User',userSchema)