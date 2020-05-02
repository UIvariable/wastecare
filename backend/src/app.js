// Express is an npm package, a lightweight webserver

// referencing the express library
const express = require('express');

var bodyParser = require("body-parser"); // image tutorial
var multer = require("multer");

//create an application
const app = express();

// const morgan = require('morgan');
// const cors = require('cors');

// app.use(morgan('dev'));
// app.use(cors());
//app.use(require("./routes/users"));


app.use(express.json());
//app.use(express.urlencoded({extended: false}));
app.use(bodyParser.urlencoded({ extended: true, limit: "50mb" }));

app.use(require("./controllers/authController"));

app.use(multer({ dest: './uploads/',
  rename: function (fieldname, filename) {
    return filename;
  },
 }),function(err) {
  if(err)
     console.log(err);
} );

// //image tutorial

// app.post("/image", function(req, res){
//   var name = req.body.name;
//   var img = req.body.image;
//   realFile = Buffer.from(img.toString(),"base64");
//   fs.writeFile(name, realFile, function(err) {
//       if(err)
//          console.log(err);
//    });
//    res.send("OK");
//  }); 
 //image tutorial

module.exports = app;