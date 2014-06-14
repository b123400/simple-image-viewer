fs = require 'fs'
Path = require 'path'
async = require 'async'

exports.viewer = (req, res)->
  return res.render 'view', {error:'no path'} if not req.query.path

  dir = Path.dirname req.query.path
  filename = Path.basename req.query.path
  fs.readdir dir, (err, items)->

      files = []

      async.parallel items.map((item)->
        (callback)->
          return callback() if item.charAt(0) is "."
          fullPath = Path.join dir, item
          fs.lstat fullPath, (err, stat)->
            return callback err if err
            if stat.isFile() and Path.extname(item) in ['.jpg', '.jpeg', '.png', '.gif']
              files.push fullPath

            callback()
        )
      , (err)->
        index = files.indexOf req.query.path
        res.render 'view',
          path : req.query.path
          prev : files[ index-1 ]
          next : files[ index+1 ]

exports.image = (baseDir)->
  (req, res)->
    path = req.query.path
    if path.indexOf(baseDir) isnt 0
      return res.end()
    try
      fs.createReadStream(path).pipe res
    catch
      res.end()