const express = require('express');

const app = express();

// Serve static files from the public folder
app.use(express.static('public'));

// Set EJS as the templating engine
app.set('view engine', 'ejs');

// Student data
const students = [
  { name: 'Aarav', course: 'B.Tech CSE' },
  { name: 'Diya', course: 'B.Tech IT' },
  { name: 'Rohan', course: 'BCA' }
];

// Student list route
app.get('/students', (req, res) => {
  res.render('students', { students });
});

// Start server
app.listen(3000, () => {
  console.log('Server running on http://localhost:3000');
});