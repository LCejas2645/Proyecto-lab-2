var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const bodyParser = require('body-parser');

const { sequelize } = require('./models');  // Ajusta la ruta según tu estructura de carpetas


var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var pacientes = require("./routes/paciente");
var examenes = require("./routes/examen");

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use("/pacientes",pacientes);
app.use("/examenes",examenes);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  res.status(404).render('error');
});



// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
  console.log("error:"+err);
});

// sequelize.sync({ alter: true })
//   .then(() => {
//     console.log('Base de datos sincronizada correctamente.');
//     // Inicia tu servidor aquí después de la sincronización
//     app.listen(3000, () => {
//       console.log('Servidor escuchando en el puerto 3000');
//     });
//   })
//   .catch(error => {
//     console.error('Error al sincronizar la base de datos:', error);
//   });

module.exports = app;
