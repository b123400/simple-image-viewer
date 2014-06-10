
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
      items.forEach (item)->
        return if item.charAt(0) is "."
        collection = if path.extname item then files else folders
        collection.push directory+'/'+item
      res.render 'index', {folders, files}