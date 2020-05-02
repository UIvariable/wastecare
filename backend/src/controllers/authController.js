// const { Router } = require('express');
// const router = Router();

const express = require('express');
// a router from the express instance
const router = express.Router();

const User = require('../models/userModel');
const verifyToken = require('./verifyToken');

const jwt = require('jsonwebtoken');
const config = require('../config');

const productController = require('../controllers/productController');

router.post('/signup', async (req, res) => {
    try {
        const {username, email, password} = req.body;
        const user = new User({
            username,
            email,
            password
        });
        user.password = await user.encryptPassword(password);
        await user.save().then(doc => {
            if (!doc || doc.length === 0) {
                return res.status(500).send("There was a problem signing in.");
            }
        }).catch (err => {
            res.status(500).send('There was a problem signing in.');
        });

        const token = jwt.sign({id: user.id}, config.secret, {
            expiresIn: '24h'
        });

        res.status(200).json({ auth: true, token });
    } catch (e) {
        console.log(e);
        res.status(500).send('There was a problem signing in.');
    }
});

router.route('/products')
.get(productController.index)
.post(productController.add)

router.route('/products/:id')
.get(productController.view)
.put(productController.update)
.delete(productController.delete)

router.post("/signin", async(req, res) => {
    try {
        const user = await User.findOne({email: req.body.email })
        if (!user) {
            return res.status(404).send("The email doesn't exist.");
        }

        const validPassword = await user.validatePassword(req.body.password, user.password);
        if (!validPassword) {
            return res.status(404).send({auth: false, token: null});
        }

        const token =  jwt.sign({id: user._id}, config.secret, {
            expiresIn: '24h'
        });

        res.status(200).json({auth: true, token});
    }  catch (e) {
        console.log(e);
        res.status(500).send('There was a problem signing in.');
    }
});

router.get('/dashboard', (req,res) => {
    res.json('dashboard');
})

router.get('/logout', function(req, res) {
    res.status(200).send({auth: false, token: null});
});

// import the router in the index.js file
module.exports = router;