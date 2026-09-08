const express = require('express');
const app = express();
app.use(express.static('public'));
// Set EJS as the templating engine
app.set('view engine', 'ejs');

// Student data
const students = [
  { name: 'Aarav', course: 'B.Tech CSE' },
  { name: 'Riya', course: 'B.Tech IT' },
  { name: 'Kabir', course: 'BCA' }
];

// Home route
app.get('/', (req, res) => {
  res.render('home', { name: 'Aarav' });
});

// Student list route
app.get('/students', (req, res) => {
  res.render('students', { students });
});

app.listen(3000, () => {
  console.log('Server running on http://localhost:3000');
});