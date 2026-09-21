use("student_management");

// Task 5: Create students collection and insert 3 documents

db.students.insertMany([
  {
    name: "Aarav",
    branch: "CSE",
    email: "aarav@upes.ac.in",
    enrollment_date: "2024-01-15"
  },
  {
    name: "Diya",
    branch: "ECE",
    email: "diya@upes.ac.in",
    enrollment_date: "2024-02-10"
  },
  {
    name: "Rohan",
    branch: "IT",
    email: "rohan@upes.ac.in",
    enrollment_date: "2024-03-20"
  }
]);

// Verify all students
db.students.find();

// Task 6: Query students in CSE branch

db.students.find({
  branch: "CSE"
});

// Query students enrolled after January 2024

db.students.find({
  enrollment_date: {
    $gt: "2024-01-31"
  }
});