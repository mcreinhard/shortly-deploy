mongoose = require 'mongoose'
schemas = require '../config'
crypto = require 'crypto'

{urlSchema} = schemas

Link = mongoose.model 'Link', urlSchema

###urlSchema.pre 'init', (next) ->
  shasum = crypto.createHash 'sha1'
  console.log this###

module.exports = Link
