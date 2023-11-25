const express =require('express');
const{register,Login} =require('../authentication/auth')
const router=express.Router();
router.post('/register',register);
router.post('/login_user',Login);

module.exports= router;