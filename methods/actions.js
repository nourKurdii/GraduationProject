var User = require('../models/user')
var jwt = require('jwt-simple')
var config = require('../config/dbconfig')
var Lab = require('../models/lab')
var Doctor = require('../models/doctor')

var functions = {

    signUp: function (req, res) {
        if ((!req.body.email) || (!req.body.password)) {
            res.json({ success: false, msg: 'enter all fields' })
        }
        else {
            User.findOne({ email: req.body.email }, (err, user) => {
                if (err) {
                    console.log(err)
                    res.json(err)
                }
                else {
                    if (user == null) {
                        const user = User({
                            email: req.body.email,
                            password: req.body.password,
                            name: req.body.name,
                            phone: req.body.phone,
                            image: req.body.image,

                        })
                        user.save().then((err) => {
                            if (err) {
                                console.log(err)
                                res.json(err)
                            } else {
                                console.log(user)
                                res.json(user)
                            }
                        })
                    } else {
                        res.json({
                            message: 'email not available'
                        })
                    }
                }
            })
        }

    },
    authenticate: function (req, res) {
        User.findOne({
            email: req.body.email
        }, function (err, user) {
            if (err) throw err
            if (!user) {
                res.status(403).send({ success: false, msg: 'auth failed user not found' })
            }
            else {
                user.comparePassword(req.body.password, function (err, isMatching) {
                    if (isMatching && !err) {
                        var token = jwt.encode(user, config.secret)
                        return res.json({ success: true,msg: 'log in succesfully', token: token })
                    }
                    else {
                      return res.status(403).send({ success: false, msg: 'authentication failed, wrong password' })
                    }
                })
            }
        }
        )
    },
    getUserInfo: function (req, res) {
        console.log(req.body.email)

        User.findOne({ email: req.params.email }, (error, data) => {
            if (error) {
                console.log(req.params.email);
                throw error;
            }
            //console.log(email)
            console.log(data)
            return res.json({name: data.name, email: data.email, password: data.password, phone: data.phone, image:data.image});
        })
    },

    getLabInfo: function (req, res) {

        Lab.find({}, (error, data) => {
            if (error) throw error;
            //console.log(data)
            return res.json(data);
        })

    },

    getDoctorInfo: function (req, res) {
        Doctor.find({}, (error, data) => {
            if (error) throw error;
           // console.log(data)
            return res.json(data);
        })
    },
    updateUserinfo:function (req , res) {
        
            User.findOne({
                email: req.params.email
            }, function (err, user) {
                if (err) {
                    console.log(err); 
                    throw err; 
                }
                else {
                    user.comparePassword(req.body.password, function (err, isMatching) {
                        if (isMatching && !err) {
                            //var token = jwt.encode(user, config.secret)                        
                                    User.findOneAndUpdate(
                                        { email: req.params.email }, { 
                                            name: req.body.name,  phone: req.body.phone},
                                         (error, data) => {
                                            if (error) {
                                                console.log(error);
                                            } else {
                                                console.log(data);
                                            }
                                        } 
                                    )                                  
                                    return res.json({ success: true, msg: "succesfully updated" });
                                
                        }
                        else {
                            //console.log(data);
                            return res.status(403).send({ success: false, msg: 'wrong password' })
                        }
                    }
                    )
                }
                
            }
            )
           
    },   
}

module.exports = functions