mongoose = require 'mongoose'
crypto = require 'crypto'

{Schema} = mongoose

urlSchema = new Schema
  url: String
  base_url: String
  code: String
  title: String
  visits:
    type: Number
    default: 0
  createdAt:
    type: Date
    default: Date.now

urlSchema.pre 'save', (next) ->
  shasum = crypto.createHash 'sha1'
  shasum.update this.url
  this.code = (shasum.digest 'hex')[0...5]
  next()

Link = mongoose.model 'Link', urlSchema

module.exports = Link
