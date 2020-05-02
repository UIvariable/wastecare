const { Schema, model } = require('mongoose');
//const mongoose = require('mongoose');

const bcrypt = require('bcryptjs');

//const userSchema = new mongoose.Schema({
const userSchema = new Schema({
    userName: String,
    email: {
        type: String,
        required: true,
        unique: true,
    },
    password: String
});

userSchema.methods.encryptPassword = async(password) => {
    const salt = await bcrypt.genSalt(10);
    return bcrypt.hash(password, salt);
}

userSchema.methods.validatePassword = function(password) {
    return bcrypt.compare(password, this.password);
}

module.exports = model('User', userSchema);
//module.exports = mongoose.model('User', userSchema);