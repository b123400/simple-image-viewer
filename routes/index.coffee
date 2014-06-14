
###
 * GET home page.
###
fs = require 'fs'
path = require 'path'
async = require 'async'

exports.list = (baseDir)->
  (req, res)->
    directory = req.query.dir || baseDir;
    files = fs.readdir directory, (error, items)->
      return res.render 'index', {error} if error

      folders = []
      files = []

      async.parallel items.map((item)->
        (callback)->
          return callback() if item.charAt(0) is "."
          fullPath = path.join directory, item
          fs.lstat fullPath, (err, stat)->
            return callback err if err
            if stat.isDirectory()
              folders.push fullPath
            else if stat.isFile() and path.extname(item) in ['.jpg', '.jpeg', '.png', '.gif']
              files.push fullPath

            callback()
        )
      , (err)->
        res.render 'index', {folders, files}