const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const db = require('./db'); // db.js igomba kuba ifite connection

const app = express();
const port = 3001;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// ------------------ CRUD FOR CLASS ------------------

// Create Class
app.post('/class', (req, res) => {
  const { classCode, className } = req.body;
  const sql = 'INSERT INTO Class (classCode, className) VALUES (?, ?)';
  db.query(sql, [classCode, className], (err, result) => {
    if (err) return res.status(500).send(err);
    res.json({ message: 'Class created', result });
  });
});

// Get all Classes
app.get('/class', (req, res) => {
  db.query('SELECT * FROM Class', (err, results) => {
    if (err) return res.status(500).send(err);
    res.json(results);
  });
});

// Update Class
app.put('/class/:classCode', (req, res) => {
  const { classCode } = req.params;
  const { className } = req.body;
  const sql = 'UPDATE Class SET className=? WHERE classCode=?';
  db.query(sql, [className, classCode], (err, result) => {
    if (err) return res.status(500).send(err);
    res.json({ message: 'Class updated', result });
  });
});

// Delete Class
app.delete('/class/:classCode', (req, res) => {
  const { classCode } = req.params;
  const sql = 'DELETE FROM Class WHERE classCode=?';
  db.query(sql, [classCode], (err, result) => {
    if (err) return res.status(500).send(err);
    res.json({ message: 'Class deleted', result });
  });
});

// ------------------ CRUD FOR STUDENT ------------------

// Create Student
app.post('/student', (req, res) => {
  const { firstName, lastName, gender, dateOfBirth, classCode } = req.body;

  // Validation: First and last name must not contain numbers
  const nameRegex = /^[A-Za-z\s]+$/;
  if (!nameRegex.test(firstName) || !nameRegex.test(lastName)) {
    return res.status(400).json({ message: "FirstName and LastName cannot contain numbers" });
  }

  const sql = 'INSERT INTO Student (firstName, lastName, gender, dateOfBirth, classCode) VALUES (?, ?, ?, ?, ?)';
  db.query(sql, [firstName, lastName, gender, dateOfBirth, classCode], (err, result) => {
    if (err) return res.status(500).send(err);
    res.json({ message: 'Student created', result });
  });
});

// Get all Students
app.get('/student', (req, res) => {
  db.query('SELECT * FROM Student', (err, results) => {
    if (err) return res.status(500).send(err);
    res.json(results);
  });
});

// Update Student
app.put('/student/:studentID', (req, res) => {
  const { studentID } = req.params;
  const { firstName, lastName, gender, dateOfBirth, classCode } = req.body;

  const nameRegex = /^[A-Za-z\s]+$/;
  if (!nameRegex.test(firstName) || !nameRegex.test(lastName)) {
    return res.status(400).json({ message: "FirstName and LastName cannot contain numbers" });
  }

  const sql = 'UPDATE Student SET firstName=?, lastName=?, gender=?, dateOfBirth=?, classCode=? WHERE studentID=?';
  db.query(sql, [firstName, lastName, gender, dateOfBirth, classCode, studentID], (err, result) => {
    if (err) return res.status(500).send(err);
    res.json({ message: 'Student updated', result });
  });
});

// Delete Student
app.delete('/student/:studentID', (req, res) => {
  const { studentID } = req.params;
  const sql = 'DELETE FROM Student WHERE studentID=?';
  db.query(sql, [studentID], (err, result) => {
    if (err) return res.status(500).send(err);
    res.json({ message: 'Student deleted', result });
  });
});

// ------------------ CRUD FOR RESULT ------------------

// Create Result
app.post('/result', (req, res) => {
  const { studentID, mathsMark, scienceMark, englishMark, kinyarwandaMark, socialMark, term } = req.body;

  const totalMark = Number(mathsMark) + Number(scienceMark) + Number(englishMark) + Number(kinyarwandaMark) + Number(socialMark);
  const percentage = (totalMark / 500) * 100;

  let grade = "";
  if (percentage >= 90) grade = "A";
  else if (percentage >= 80) grade = "B";
  else if (percentage >= 70) grade = "C";
  else if (percentage >= 60) grade = "D";
  else grade = "F";

  const sql = `INSERT INTO Result (studentID, mathsMark, scienceMark, englishMark, kinyarwandaMark, socialMark, term, totalMark, percentage, grade) 
               VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;
  db.query(sql, [studentID, mathsMark, scienceMark, englishMark, kinyarwandaMark, socialMark, term, totalMark, percentage, grade], (err, result) => {
    if (err) return res.status(500).send(err);
    res.json({ message: 'Result created', result });
  });
});

// Get all Results (join with Student for names)
app.get('/result', (req, res) => {
  const sql = `SELECT r.*, s.firstName, s.lastName, s.classCode 
               FROM Result r 
               JOIN Student s ON r.studentID = s.studentID`;
  db.query(sql, (err, results) => {
    if (err) return res.status(500).send(err);
    res.json(results);
  });
});

// Update Result
app.put('/result/:resultID', (req, res) => {
  const { resultID } = req.params;
  const { mathsMark, scienceMark, englishMark, kinyarwandaMark, socialMark, term } = req.body;

  const totalMark = Number(mathsMark) + Number(scienceMark) + Number(englishMark) + Number(kinyarwandaMark) + Number(socialMark);
  const percentage = (totalMark / 500) * 100;

  let grade = "";
  if (percentage >= 90) grade = "A";
  else if (percentage >= 80) grade = "B";
  else if (percentage >= 70) grade = "C";
  else if (percentage >= 60) grade = "D";
  else grade = "F";

  const sql = `UPDATE Result SET mathsMark=?, scienceMark=?, englishMark=?, kinyarwandaMark=?, socialMark=?, term=?, totalMark=?, percentage=?, grade=? WHERE resultID=?`;
  db.query(sql, [mathsMark, scienceMark, englishMark, kinyarwandaMark, socialMark, term, totalMark, percentage, grade, resultID], (err, result) => {
    if (err) return res.status(500).send(err);
    res.json({ message: 'Result updated', result });
  });
});

// Delete Result
app.delete('/result/:resultID', (req, res) => {
  const { resultID } = req.params;
  const sql = 'DELETE FROM Result WHERE resultID=?';
  db.query(sql, [resultID], (err, result) => {
    if (err) return res.status(500).send(err);
    res.json({ message: 'Result deleted', result });
  });
});

// ------------------ Start Server ------------------
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});