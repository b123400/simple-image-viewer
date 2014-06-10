fs = require 'fs'

exports.viewer = (req, res)->
  return res.render 'view', {error:'no path'} if not req.query.path
  res.render 'view',
    path : req.query.path

exports.image = (baseDir)->
  (req, res)->
    path = req.query.path
    console.log path, baseDir
    if path.indexOf(baseDir) isnt 0
      return res.end()
    fs.createReadStream(path).pipe res