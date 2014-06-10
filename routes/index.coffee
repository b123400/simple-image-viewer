
###
 * GET home page.
###
fs = require 'fs'
path = require 'path'

exports.list = (baseDir)->
  (req, res)->
    directory = req.query.dir || baseDir;
    files = fs.readdir directory, (error, items)->
      return res.render 'index', {error} if error

      folders = []
      files = []
      items.forEach (i)->
        return if i.charAt(0) is "."
        if path.extname directory+'/'+i
          files.push i
        else
          folders.push directory+'/'+i
      res.render 'index', {folders, files}