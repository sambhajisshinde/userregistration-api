const cors = require("cors");
const bodyParser = require("body-parser");
const express = require("express");
const app = express();
const mysql = require("mysql");
const { addListener } = require("nodemon");

//ConnectionString
const db = mysql.createPool({
 host : "localhost",
 user : "root",
 password : "password",
 database : "registration_db",
 multipleStatements: true
});

//Start listening
app.listen('3001', () => {
    console.log('server started');
});

//Handle cors request.
app.use(cors());

//Convert to json format before pushing the data to db
app.use(express.json());

//Enabled the url encoding
app.use(bodyParser.urlencoded({extended:true}));

//Get OTP from db
app.get('/api/getOTP', (req, res) => {
    const mobilenumber = req.query.id;       
    //To aviod sql injection we pass ? as params
    const sqlExec = "set @otp = 0 ;call SPGetOTP (?, @otp); SELECT @otp as otp";    
    db.query(sqlExec, [mobilenumber], (err, result) => {                                 
        res.send(result[2]);
    });      
   });

//Check the user is already registered.
app.get('/api/validateUser', (req, res) => {
    const otp = req.query.otp;    
    //To aviod sql injection we pass ? as params
    const sqlExec = "select fnUserExists(?) as userexists;";    
    db.query(sqlExec, [otp], (err, result) => {                                         
        res.send(result);
    });      
   });   

//Post validated user data to db
app.post('/api/addUser', (req, res)=> {    
    
    const otp = req.body.otp;
    const fullname = req.body.fullname;
    const email = req.body.email;   
    const operationtype = req.body.operationtype;

    //To aviod sql injection we pass ? as params
    const sqlExec = "call SPCrudUserDetails(?, ?, ?, ?)";
    db.query(sqlExec,[otp, fullname, email, operationtype], (err, result) => {        
        res.send(result);        
     });
});