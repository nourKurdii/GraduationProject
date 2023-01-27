var mongoose = require('mongoose')
var User = require('../models/user')
var jwt = require('jwt-simple')
var config = require('../config/dbconfig')
var Lab = require('../models/lab')
var Doctor = require('../models/doctor')
var Order = require('../models/order')
var Test = require('../models/test')
var Booking = require('../models/doctorBooking')
var functions = {

    signUp: function (req, res) {
        if ((!req.body.email) || (!req.body.password)) {
            res.json({ success: false, msg: 'enter all fields' })
        }
        else {
            var newUser = User({
                email: req.body.email,
                phone: req.body.phone,
                password: req.body.password,
                name: req.body.name
            });
            newUser.save(function(err, newUser){
                if(err){
                    res.json({success:false, msg: 'unvalid email'})
                }
                else{
                    res.json({success: true, msg:'signed up successfully'})
                }
            })
            // User.findOne({ email: req.body.email }, (err, user) => {
            //     if (err) {
            //         console.log(err)
            //         res.json(err)
            //     }
            //     else {
            //         if (user == null) {
            //             const user = User({
            //                 email: req.body.email,
            //                 password: req.body.password,
            //                 name: req.body.name,
            //                 phone: req.body.phone,
            //                 image: "assets/images/avatar.png",

            //             })
            //             user.save().then((err) => {
            //                 if (err) {
            //                     console.log(err)
            //                     res.json(err)
            //                 } else {
            //                     console.log(user)
            //                    return res.json({msg:"signed up successfully"})
            //                 }
            //             })
            //         } else {
            //             return res.status(403).json({
                            
            //                 msg: "Unvalid Email" ,
            //               });
            //         }
            //     }
            // })
        }

    },
    authenticate: function (req, res) {
        User.findOne({
            email: req.body.email
        }, function (err, user) {
            if (err) throw err
            if (!user) {
                res.status(403).send({ success: false, msg: 'auth failed, user not found' });
            }

            else {
                user.comparePassword(req.body.password, function (err, isMatch) {
                    if (isMatch && !err) {
                        var token = jwt.encode(user, config.secret)
                        res.json({ success: true, token: token })
                    }
                    else {
                        return res.status(403).send({ success: false, msg: 'wrong password' })
                    }
                })
            }
        }
        )
    },
    changePassword: function (req , res) {
        
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
                                user.password=req.body.newPassword;
                                user.save().then((err) => {
                                    if (err) {
                                        console.log(err)
                                        //res.json(err)
                                    } else {
                                        console.log(user)
                                        res.json(user)
                                    }
                                })                                
                                return res.json({ success: true, msg: "succesfully updated" });
                            
                    }
                    else {
                        //console.log(data);
                        console.log(err)
                        return res.status(403).send({ success: false, msg: 'wrong password' })
                    }
                }
                )
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
    getReports: function(req,res){
        try{
        Order.aggregate([
            {
                $match: { 
                    patientEmail: req.params.patientEmail,
                    $or :[
                        {status: "finished"},
                        {status: "ratted"}
                        ]
                 }
            },
        
            {
                
            $lookup: {
                from: "labs",
                localField: "labEmail",
                foreignField: "email",
                as: "labInfo"
            }
        }
        ]).then((data) => {
            res.json(data);

        })
    }
            catch (error) {
                res.status(500).json({
                  status: false,
                  msg: "Error : " + error,
                });
              }
        

        /*.find(
            {
            patientEmail: req.params.patientEmail} ,(error,data)=>
            {
                if (error) 
                {

                    console.log(req.params.patientEmail);
                    throw error;
                }
                else 
                {
                    return res.json(data);
                }
                
            }

    
        //.populate('labID')                     
        )*/
    },  
    getSpeceficReport: function(req,res){
        try{
            let idToSearch = mongoose.Types.ObjectId(req.params.id)
            Order.aggregate([
                {
                    $match: { 
                        _id: idToSearch,
                     }
                },
            
                {
                    
                $lookup: {
                    from: "tests",
                    localField: "testName",
                    foreignField: "name",
                    as: "testInfo"
                }

            }
            ]).then((data) => {
                res.json(data);
    
            })
        }
                catch (error) {
                    res.status(500).json({
                      status: false,
                      msg: "Error : " + error,
                    });
                  }
    },
    getBookings: function(req,res){
        try{
            Order.aggregate([
                {
                    $match: { 
                        patientEmail: req.params.patientEmail,
                       homeVisit: false,
                      
                       $nor: [
                        {status: "finished"},
                        {status:"ratted"},
                        {status: "cancelled"}

                     ]    
                     },
                    
 
                },
            
                {
                    
                $lookup: {
                    from: "labs",
                    localField: "labEmail",
                    foreignField: "email",
                    as: "labInfo"
                }
            }
            ]).then((data) => {
                res.json(data);
    
            })
        }
                catch (error) {
                    res.status(500).json({
                      status: false,
                      msg: "Error : " + error,
                    });
                  }
            
    },  
    cancelOrder: function (req , res) {      
        Order.findOneAndUpdate(
            { _id:req.params.id }, { status:"cancelled" },
             (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    console.log(data);
                }
            }
        )
        console.log("Order Cancelled succesfully");
        return res.send({ success: true, msg: "Order cancelled" });
    },
    getHomeVisits: function (req,res){
        try{
            Order.aggregate([
                {
                    $match: { 
                        patientEmail: req.params.patientEmail,
                       // homeVisit: true,
                       homeVisit : true,
                       $nor: [
                        {status: "finished"},
                        {status:"ratted"},
                        {status: "cancelled"}

                     ]    
                     },
                    
 
                },
            
                {
                    
                $lookup: {
                    from: "labs",
                    localField: "labEmail",
                    foreignField: "email",
                    as: "labInfo"
                }
            }
            ]).then((data) => {
                res.json(data);
    
            })
        }
                catch (error) {
                    res.status(500).json({
                      status: false,
                      msg: "Error : " + error,
                    });
                  }
    },
    savelocation: function (req , res) {
        
        User.findOneAndUpdate(
            { email: req.body.email }, { latitude: req.body.latitude, longitude: req.body.longitude },
             (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    console.log(data);
                }
            }
        )
        console.log("you are in updated function");
        return res.send({ status: "updated" });
    },  
    getSpeceficLab: function(req,res){
        console.log(req.body.id)

        Lab.findOne({ _id: req.params.id }, (error, data) => {
            if (error) {
                console.log(req.params.id);
                throw error;
            }
            //console.log(email)
            console.log(data)
            return res.json(data);
        })
    },
    getSpeceficLabTests: function(req,res){       
    },
    getTestCat: function(req,res){
        Test.findOne({ name: req.params.testName }, (error, data) => {
            if (error) {
                console.log(req.params.testName);
                throw error;
            }
            //console.log(email)
            console.log(data.category)
            return res.json(data.category);
        })
    },
    getTestInfo: function(req,res){
        Test.findOne({ name: req.params.testName }, (error, data) => {
            if (error) {
                console.log(req.params.testName);
                throw error;
            }
            //console.log(email)
            console.log(data)
            return res.json(data);
        })
    },
    getTestBool: function(req,res){
        Test.findOne({ name: req.params.testName }, (error, data) => {
            if (error) {
                console.log(req.params.testName);
                throw error;
            }
            //console.log(email)
            console.log(data.homeVisit)
            return res.json(data.homeVisit);
        })
    },
    addLabOrder: function(req,res){
        console.log(req.body.patientEmail);
        console.log(req.body.labEmail);
        console.log(req.body.testName);
        console.log(req.body.time);
        console.log(req.body.date);
        console.log(req.body.latitude);
        console.log(req.body.longitude);

        if ((!req.body.patientEmail) ||(!req.body.labEmail) || (!req.body.testName)|| (!req.body.time)||
         (!req.body.date) || (!req.body.latitude) || (!req.body.longitude)) {
            res.json({ success: false, msg: 'Enter all fields' })
        }
        var neworder = Order({
            patientEmail: req.body.patientEmail,
            labEmail: req.body.labEmail,
            testName: req.body.testName,
            time: req.body.time,
            date:req.body.date,
            latitude: req.body.latitude,
            longitude:req.body.longitude,
            status:"pending",
            rating: 0,
            homeVisit: req.body.homeVisit,
            TestResult:0

        });
        neworder.save(function (err, neworder) {
            if (err) {
                res.send({ success: false, msg: 'Failed to save' })
            }
            else {
                res.send({ success: true, msg: 'Successfully saved' })
            }
        })
    },
    addHomeOrder: function(req,res){
        console.log(req.body.patientEmail);
        console.log(req.body.labEmail);
        console.log(req.body.testName);
        console.log(req.body.time);
        console.log(req.body.date);
        console.log(req.body.latitude);
        console.log(req.body.longitude);

        if ((!req.body.patientEmail) ||(!req.body.labEmail) || (!req.body.testName)|| (!req.body.time)||
         (!req.body.date) || (!req.body.latitude) || (!req.body.longitude)||(!req.body.location)) {
            res.json({ success: false, msg: 'Enter all fields' })
        }
        var neworder = Order({
            patientEmail: req.body.patientEmail,
            labEmail: req.body.labEmail,
            testName: req.body.testName,
            time: req.body.time,
            date:req.body.date,
            latitude: req.body.latitude,
            longitude:req.body.longitude,
            status:"pending",
            rating: 0,
            homeVisit: req.body.homeVisit,
            TestResult:0,
            location: req.body.location

        });
        neworder.save(function (err, neworder) {
            if (err) {
                res.send({ success: false, msg: 'Failed to save' })
            }
            else {
                res.send({ success: true, msg: 'Successfully saved' })
            }
        })
    },
    rateOrder: function (req , res) {
        
        Order.findOneAndUpdate(
            { _id: req.params._id }, {rating:req.body.rating,status:"ratted"},
             (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    console.log(data);
                }
            }
        )
        console.log("you are in updated function");
        return res.send({ status: "ratted" });
    },
    getLabRate:function (req , res) {
        Order.find({ labEmail:req.params.labEmail },(error,data)=>{
            return res.send(data);
        }).sort({labEmail:1});
        
    },
    changeLabRate: function (req , res) {
        Lab.findOneAndUpdate(
            { email:req.params.email }, { rating:req.body.rating },
             (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    console.log(data);
                }
            }
        )
        console.log("lab rate updated");
        return res.send({ status: "success" });
    },
    topThreeLabs:function(req,res){
        Lab.find( {rating: {$exists: true}},(error,data)=>{
            return res.json(data);}) .sort({rating : -1}).limit(3);
    },
    aunavailableForLab: function (req , res) {
        console.log("req.params._id");
        console.log(req.body.time)
         Lab.findOneAndUpdate({_id:req.params._id},{$push:{unavailableTime:req.body.time}},
             (error, data) => {
                if (error) {
                    console.log(error);
                } else { 
                    console.log(data); 
                }
            }
        )
        console.log("unavailableTime updated");
        return res.send({ status: "updated"}); 
    },
    getSpeceficDoc: function(req,res){
        console.log(req.body.id)

        Doctor.findOne({ _id: req.params.id }, (error, data) => {
            if (error) {
                console.log(req.params.id);
                throw error;
            }
            //console.log(email)
            console.log(data)
            return res.json(data);
        })
    },
    addDoctorBooking: function(req,res){
        console.log(req.body.patientEmail);
        console.log(req.body.doctorEmail);
        console.log(req.body.time);
        console.log(req.body.date);

        if ((!req.body.patientEmail) ||(!req.body.doctorEmail) || (!req.body.time)|| (!req.body.date)) {
            res.json({ success: false, msg: 'Enter all fields' })
        }
        var newBooking = Booking({
            patientEmail: req.body.patientEmail,
            doctorEmail: req.body.doctorEmail,
           
            time: req.body.time,
            date:req.body.date,
           
            status:"pending",
           

        });
        newBooking.save(function (err, newBooking) {
            if (err) {
                res.send({ success: false, msg: 'Failed to save' })
            }
            else {
                res.send({ success: true, msg: 'Successfully saved' })
            }
        })
    },
    //---------------------------------------------------
    addNewDoctor: function (req, res) {
        console.log(req.body.password);
        console.log(req.body.phone);
        console.log(req.body.name);
        console.log(req.body.title);
        console.log(req.body.email);


        if ((!req.body.name) || (!req.body.password)|| (!req.body.phone)|| (!req.body.title)|| (!req.body.email)) {
            res.json({ success: false, msg: 'Enter all fields' })
        }
        else {
            var newDoctor = Doctor({
                
                name: req.body.name,
                password: req.body.password,
                phone: req.body.phone,
                title: req.body.title,
                email: req.body.email,
                unavailableTime : []
            });
            newDoctor.save(function (err, newDoctor) {
                if (err) {
                   console.log(err)
                    res.json({ success: false, msg: "failed"})
                }
                else {
                    res.json({ success: true, msg: 'Successfully saved' })
                }
            })
        }
    },
    authenticateD: function (req, res) {

        Doctor.findOne({
            email: req.body.email
        }, function (err, doctor) {
            if (err) throw err
            if (!doctor) {
                
                res.status(403).send({ success: false, msg: 'Authentication Failed, User not found' })
            }

            else {
                doctor.comparePassword(req.body.password, function (err, isMatch) {
                    console.log(req.body.password)

                    if (isMatch && !err) {
                        var token = jwt.encode(doctor, config.secret)
                        res.json({ success: true, token: token })
                    }
                    else {
                        return res.status(403).send({ success: false, msg: 'Authentication failed, wrong password' })
                    }
                })
            }
        }
        )
    },
    getDoctorname:function (req , res) {
        console.log(req.params.email)
         Doctor.findOne({email: req.params.email},(error,data)=>{
             if (error) throw error ;
             console.log(data)
             return res.json({name: data.name })
 
         }) 
     },
     getDoctorOrders: function (req , res) {
        console.log(req.params.doctor);

        Booking.find({doctorEmail: req.params.doctor,  $nor: [
            {status: "finished"},
            {status:"ratted"},
            {status: "rejected"},
            {status: "accepted"}

         ]    },(error,data)=>{
            if (error) throw error;
            console.log(data)
            return res.json(data)
        })
    } ,
    rejectDoctorOrder: function (req , res) {      
        Booking.findOneAndUpdate(
            { _id:req.params.id }, { status:"rejected" },
             (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    console.log(data);
                }
            }
        )
        console.log("Order Cancelled succesfully");
        return res.send({ success: true, msg: "Order cancelled" });
    },
    acceptrequest: function (req , res) {
        
        Booking.findOneAndUpdate(
            { _id:req.params.id }, { status:"accepted" },
             (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    console.log(data);
                }
            }
        )
       
        return res.send({ status: "accepted" });
    }, 
      addtimefordoctor: function (req , res) {
        console.log("req.params.id");
        console.log(req.body.time)
         Doctor.findOneAndUpdate({email:req.params.email},{$push:{unAvailableTime:req.body.time}},
             (error, data) => {
                if (error) {
                    console.log(error);
                } else { 
                    console.log(data); 
                }
            }
        )
        console.log("unAvailableTime updated");
        return res.send({ status: "updated"   }); 
    },
    getDoctorBookings: function(req,res){
          Booking.find({doctorEmail: req.params.doctor},(error,data)=>{
            if (error) throw error;
            console.log(data)
            return res.json(data)
        })
    }


}


module.exports = functions
