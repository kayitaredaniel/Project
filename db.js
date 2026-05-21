const mysql = require("mysql");

// Create the connection pool
const db = mysql.createPool({
  host: "localhost",      
  user: "root",          
  password: "",          
  database: "SSRMS",      
  waitForConnections: true,
  connectionLimit: 10,   
  queueLimit: 0
});

// Test connection
db.getConnection((err, connection) => {
  if (err) {
    console.error("Database connection failed:", err.message);
  } else {
    console.log("Database connected successfully!");
    connection.release();
  }
});

module.exports = db;