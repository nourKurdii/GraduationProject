var User = require('../models/user')
var jwt = require('jwt-simple')
var config = require('../config/dbconfig')
var lab = require('../models/lab')
var doctor = require('../models/doctor')

var functions = {
    /*addNew: function(req, res)
    {
        if((!req.body.name) || (!req.body.password)) {
            res.json({success: false, msg: 'enter all fields'})
        }
        else {
            var newUser = User({
                name: req.body.name,
                password: req.body.password
            });
            newUser.save(function(err, newUser){
                if(err) {
                    res.json({success: false, msg: 'failed to save'})
                }
                else {
                    res.json({success: true, msg: 'successfully saved'})
                }
            })
        }
    },*/
    signUp: function(req,res){
        if((!req.body.email) || (!req.body.password)) {
            res.json({success: false, msg: 'enter all fields'})
        }
        else{
            User.findOne({email:req.body.email},(err,user)=>{
                if(err){
                    console.log(err)
                    res.json(err)
                }
                else{
                    if(user==null){
                        const user=User({
                            email:req.body.email,
                            password:req.body.password
                        })
                        user.save().then((err)=>{
                            if(err){
                                console.log(err)
                                res.json(err)
                            }else{
                                console.log(user)
                                res.json(user)
                            }
                        })
                    }else{
                        res.json({
                            message:'email not available'
                        })
                    }
                }
            })
        }
        
    },
    authenticate: function (req,res) {
        User.findOne({
            email: req.body.email
        }, function(err, user){
            if(err) throw err
            if(!user){
                res.status(403).send({success: false, msg:'auth failed user not found'})
            }
            else {
                user.comparePassword(req.body.password, function(err,isMatching){
                    if(isMatching && !err){
                         var token = jwt.encode(user, config.secret) 
                         res.json({success:true, token: token})
                    }
                    else {
                        return res.status(403).send({success: false, msg:'authentication failed'})
                    }
                })
            }
        }
        )
    },
    /*getinfo: function(req , res) 
    {
        if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
            var token = req.headers.authorization.split(' ')[1]
            var decodedtoken = jwt.decode(token, config.secret)
            return res.json({success: true, msg: 'hello ' + decodedtoken.name})
        }
        else {
            return res.json({success: false, msg:'no headers'})
        }
    }*/
    getLabInfo: function(req,res){

    },

    getDoctorInfo: function(req,res){

    },
}

module.exports = functions