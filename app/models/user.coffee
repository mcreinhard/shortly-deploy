mongoose = require 'mongoose'
schemas = require '../config'
bcrypt = require 'bcrypt-nodejs'

{userSchema} = schemas

User = mongoose.model 'User', userSchema

module.exports = User
