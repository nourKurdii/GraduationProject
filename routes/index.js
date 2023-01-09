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

module.exports = router