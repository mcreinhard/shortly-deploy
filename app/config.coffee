mongoose = require 'mongoose'
{Schema} = mongoose

mongoose.connect 'mongodb://localhost/shortly'

db = mongoose.connection
db.on 'error', console.error.bind console, 'connection error:'

schemas = {}

schemas.urlSchema = new Schema
  url: String
  baseUrl: String
  code: String
  title: String
  visits: Number

schemas.userSchema = new Schema
  username: String
  password: String

module.exports = schemas
