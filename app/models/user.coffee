mongoose = require 'mongoose'
bcrypt = require 'bcrypt-nodejs'
Promise = require 'bluebird'

{Schema} = mongoose

userSchema = new Schema
  username: String
  password: String
  createdAt:
    type: Date
    default: Date.now

userSchema.pre 'save', true, (next, done) ->
  userSchema.methods.hashPassword.call this
    .then ->
      next()
      done()

userSchema.methods.comparePassword = (attemptedPassword, callback) ->
  bcrypt.compare attemptedPassword, this.password, (err, isMatch) ->
    callback isMatch

userSchema.methods.hashPassword = ->
  cipher = Promise.promisify bcrypt.hash
  return cipher this.password, null, null
    .bind this
    .then (hash) ->
      this.password = hash

User = mongoose.model 'User', userSchema
  
module.exports = User
