
/**
 * Module dependencies.
 */
require('coffee-script/register');

var express = require('express');
var routes = require('./routes');
var viewer = require('./routes/viewer')
var http = require('http');
var path = require('path');
var command = require('commander');

command
  .option('-d, --dir [image-dir]', 'Specific image directory')
  .parse(process.argv);

var app = express();

directory = command.dir ? path.resolve(command.dir) : __dirname;

// all environments
app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');
app.set('image-dir', directory )
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);
app.use(express.static(path.join(__dirname, 'public')));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

app.get('/', routes.list(app.get('image-dir')));
app.get('/view', viewer.viewer(app.get('image-dir')));
app.get('/image', viewer.image(app.get('image-dir')));

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
