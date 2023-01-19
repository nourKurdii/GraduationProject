const express = require('express')
const actions = require('../methods/actions')
const router = express.Router()

//respond with "hello world" when a GET request is made to the homepage
router.get('/',(req,res)=> {
    res.send('Hello World')
})

//router.post('/adduser', actions.addNew)

router.post('/authenticate',actions.authenticate)

//router.get('/getinfo', actions.getinfo)

router.post('/signUp',actions.signUp)
router.get('/getLabInfo', actions.getLabInfo)
router.get('/getDoctorInfo', actions.getDoctorInfo)
router.get('/getUserInfo/:email',actions.getUserInfo)
router.put('/updateUserinfo/:email',actions.updateUserinfo)
router.get('/getReports/:patientEmail',actions.getReports)
router.get('/getSpeceficReport/:id',actions.getSpeceficReport)
router.put('/changePassword/:email',actions.changePassword)
router.get('/getBookings/:patientEmail',actions.getBookings)
router.get('/getHomeVisits/:patientEmail',actions.getHomeVisits)
router.put('/cancelOrder/:id',actions.cancelOrder)
router.get('/getSpeceficLab/:id',actions.getSpeceficLab)
router.get('/getTestCat/:testName',actions.getTestCat)
router.get('/getTestInfo/:testName',actions.getTestInfo)
router.get('/getTestBool/:testName',actions.getTestBool)
router.post('/addLabOrder',actions.addLabOrder)
router.post('/addHomeOrder',actions.addHomeOrder)
router.put('/rateOrder/:_id',actions.rateOrder) 
router.get('/getLabRate/:labEmail', actions.getLabRate)
router.put('/changeLabRate/:email',actions.changeLabRate)
router.get('/topThreeLabs',actions.topThreeLabs)
router.get('/getSpeceficDoc/:id',actions.getSpeceficDoc)
router.post('/addDoctorBooking',actions.addDoctorBooking)
//-----------------------------------------------------------------
router.post('/addDoctor',actions.addNewDoctor)
router.post('/authenticateD', actions.authenticateD)
router.get('/getdoctorname/:email', actions.getDoctorname) 
router.get('/getDoctorOrders/:doctor',actions.getDoctorOrders)
router.put('/rejectDoctorOrder/:id',actions.rejectDoctorOrder)
router.put('/acceptrequest/:id',actions.acceptrequest)




module.exports = router