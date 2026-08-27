fetch("http://localhost:3000/students")
    .then(response => response.json())
    .then(students => {
        const cseStudents = students.filter(
            student => student.branch === "CSE"
        );

        console.log("CSE Students:", cseStudents);
    })
    .catch(error => console.error("Error:", error));