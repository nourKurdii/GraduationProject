var User = require('../models/user')
var jwt = require('jwt-simple')
var config = require('../config/dbconfig')
var Lab = require('../models/lab')
var Doctor = require('../models/doctor')

var functions = {
    
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
   
    getLabInfo: function(req,res){
        
        Lab.find({},(error,data)=>{
            if(error) throw error;
            console.log(data)
            return res.json( data);
        })  
              
    },

    getDoctorInfo: function(req,res){
        Doctor.find({},(error,data)=>{
            if(error) throw error;
            console.log(data)
            return res.json( data);
        })  
    },
}

module.exports = functions