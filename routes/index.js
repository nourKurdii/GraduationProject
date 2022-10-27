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


module.exports = router