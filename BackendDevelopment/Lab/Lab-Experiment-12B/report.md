# Lab Experiment 12B – Cookies and Sessions

**Name:** Anusmita Jha

**SAP ID:** 590015944

**Course:** B.Tech CSE

**Subject:** Backend Development

## 1. Experiment Title

Cookies and Session Management using Express.js

## 2. Objective

The objective of this experiment is to understand cookies and sessions in Express.js and learn how to store, retrieve, and delete cookies and how to create, maintain, and destroy user sessions.

## 3. Introduction

In this experiment, I worked with Express.js to understand cookie handling and session management.

The experiment demonstrates how cookies can be created, retrieved, and deleted using `cookie-parser`. It also demonstrates how sessions can be created, used to store information, and destroyed using `express-session`.

A login and logout system was also implemented using sessions and cookies.

## 4. Tasks Performed

### Task 1 – Cookie Handling

In this task, I created a simple Express.js application to demonstrate cookie handling.

The following routes were implemented:

- `/set-cookie` – creates a cookie named `username`.
- `/get-cookie` – retrieves the stored username cookie.
- `/delete-cookie` – deletes the username cookie.

The application uses `cookie-parser` to read cookies from incoming requests.

### Task 2 – Session Handling

In this task, I created an Express.js application to demonstrate session management.

The session stores the number of times a user visits the page.

The following routes were implemented:

- `/` – creates and updates the session visit count.
- `/destroy` – destroys the current session.

The application uses `express-session` for session management.

### Task 3 – Login, Session and Cookie Management

In this task, I created a simple login and logout application using Express.js.

The application provides:

- A login form for entering a username.
- A login route that stores the username in the session.
- A sample `theme` cookie created after login.
- A welcome message for logged-in users.
- A logout route that destroys the session.

The following routes were implemented:

- `/` – displays the login form or welcome message.
- `/login` – processes the login request and creates the session and cookie.
- `/logout` – destroys the session and redirects the user to the login page.

## 5. Technologies Used

- Node.js
- Express.js
- JavaScript
- cookie-parser
- express-session
- HTML
- HTTP Cookies
- Sessions

## 6. Concepts Learned

Through this experiment, I learned:

- How to create cookies using Express.js.
- How to retrieve cookies using `cookie-parser`.
- How to delete cookies.
- How to create sessions using `express-session`.
- How to store information inside a session.
- How to maintain session data between requests.
- How to destroy a session.
- How to use sessions for login functionality.
- How to use cookies along with sessions.
- How to implement a basic login and logout system.

## 7. What I Learned

This experiment helped me understand how cookies and sessions are used in backend applications.

I learned that cookies can store small pieces of information on the client side and can be created, retrieved, and deleted using Express.js and `cookie-parser`.

I also learned how sessions can be used to maintain user-specific information between multiple requests. The login and logout application helped me understand how sessions can be used to maintain a user's logged-in state.

## 8. Screenshots

### Task 1 – Cookie Handling

#### Set Cookie

[![Cookie Set](Screenshots/cookie-set.png)](Screenshots/cookie-set.png)

#### Get Cookie

[![Cookie Get](Screenshots/cookie-get.png)](Screenshots/cookie-get.png)

#### Delete Cookie

[![Cookie Delete](Screenshots/cookie-delete.png)](Screenshots/cookie-delete.png)

### Task 2 – Session Handling

#### First Visit

[![Session First Visit](Screenshots/session-first.png)](Screenshots/session-first.png)

#### Session Visit Count

[![Session Visit Count](Screenshots/session-visit.png)](Screenshots/session-visit.png)

#### Destroy Session

[![Session Destroy](Screenshots/session-destroy.png)](Screenshots/session-destroy.png)

### Task 3 – Login, Session and Cookie Management

#### Login Page

[![Login Page](Screenshots/login.png)](Screenshots/login.png)

#### Logged In

[![Logged In](Screenshots/logged-in.png)](Screenshots/logged-in.png)

#### Logout

[![Logout](Screenshots/logout.png)](Screenshots/logout.png)

## 9. Conclusion

This experiment provided practical experience with cookies and sessions using Express.js.

I learned how to create, retrieve, and delete cookies, as well as how to create, maintain, and destroy sessions. I also learned how sessions and cookies can be used together to implement a basic login and logout system.

Overall, the experiment helped me understand how Express.js can manage user-specific information and maintain state between client and server requests.