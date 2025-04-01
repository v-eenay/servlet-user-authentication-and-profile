# User Profile and Authentication System

## About This Project

This project is designed as an educational resource for students to learn modern web application development using Java and Jakarta EE technologies. It serves as a comprehensive example of implementing a secure user management system with proper authentication, authorization, and profile management features.

### Author

Vinay Koirala
- Personal Email: koiralavinay@gmail.com
- Professional Email: binaya.koirala@iic.edu.np
- Position: Lecturer at Itahari International College

## Educational Objectives

This project is designed to help students learn:
1. Jakarta Servlet API fundamentals
2. JSP and JSTL for dynamic web pages
3. Session management and security
4. Database integration with JDBC
5. Object-Oriented Programming principles
6. MVC (Model-View-Controller) architecture
7. Frontend development with HTML, CSS, and JavaScript
8. Version control with Git
9. Build automation with Maven

## Project Structure

```
user-profile-and-authentication/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── controller/       # Servlet controllers
│   │   │   │   ├── DeleteAccountServlet.java
│   │   │   │   ├── LoginServlet.java
│   │   │   │   ├── LogoutServlet.java
│   │   │   │   ├── RegisterServlet.java
│   │   │   │   ├── ResetPasswordServlet.java
│   │   │   │   ├── UpdateProfileServlet.java
│   │   │   │   └── UserProfileServlet.java
│   │   │   └── model/           # Data models
│   │   │       ├── User.java    # User entity
│   │   │       └── UserDAO.java # Data Access Object
│   │   ├── resources/           # Application resources
│   │   └── webapp/              # Web resources
│   │       ├── WEB-INF/         # Web configuration
│   │       │   └── view/        # JSP pages
│   │       │       ├── deleteaccount.jsp
│   │       │       ├── editprofile.jsp
│   │       │       ├── login.jsp
│   │       │       ├── register.jsp
│   │       │       ├── resetpassword.jsp
│   │       │       └── userprofile.jsp
│   │       ├── assets/          # Static resources
│   │       │   └── css/         # CSS files
│   │       │       └── style.css
│   │       └── index.jsp        # Main page
│   └── test/                    # Test classes
├── .gitignore
├── pom.xml                      # Maven configuration
├── mvnw                         # Maven wrapper
└── README.md                    # This file
```

## Key Features

### Authentication System
1. **Login System**
   - Secure password handling
   - Session management
   - Protection against common attacks

2. **Registration System**
   - User registration with validation
   - Email verification
   - Password strength requirements

3. **Profile Management**
   - View and update personal information
   - Profile picture upload
   - Contact information management

4. **Security Features**
   - Password hashing
   - CSRF protection
   - XSS prevention
   - Session timeout

### User Interface
1. **Responsive Design**
   - Mobile-friendly layout
   - Modern CSS styling
   - Clean and intuitive interface

2. **User Experience**
   - Clear feedback messages
   - Form validation
   - Loading indicators
   - Error handling

## Step-by-Step Learning Guide

### Part 1: Project Setup
1. **Understanding the Project Structure**
   - Study the directory structure
   - Learn about each component's purpose

2. **Setting Up Development Environment**
   - Install JDK 23
   - Set up Maven
   - Configure IDE (IntelliJ IDEA recommended)

### Part 2: Core Java Concepts
1. **Object-Oriented Programming**
   - Study the User class
   - Learn about encapsulation
   - Understand class relationships

2. **Database Integration**
   - Examine UserDAO implementation
   - Learn about JDBC
   - Study database operations

### Part 3: Web Development
1. **Servlet Fundamentals**
   - Study each servlet's implementation
   - Learn about request handling
   - Understand session management

2. **JSP and JSTL**
   - Analyze JSP pages
   - Learn about JSTL tags
   - Study form handling

### Part 4: Security Features
1. **Authentication**
   - Study LoginServlet
   - Learn about session management
   - Understand security best practices

2. **Password Management**
   - Examine password handling
   - Learn about password security
   - Study ResetPasswordServlet

### Part 5: Advanced Topics
1. **File Upload**
   - Study profile picture upload
   - Learn about file handling
   - Understand multipart form data

2. **Error Handling**
   - Study exception handling
   - Learn about error pages
   - Understand logging

## Getting Started

### Prerequisites
- JDK 23 or later
- Maven 3.6 or later
- Jakarta EE compatible application server (e.g., Tomcat 10+, Jetty, etc.)
- MySQL Database Server

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/v-eenay/servlet-user-authentication-and-profile.git
   cd servlet-user-authentication
   ```

2. Build the project:
   ```bash
   ./mvnw clean package
   ```

3. Start your MySQL server and create a database named `user_profile_db`

4. Deploy the generated WAR file to your application server

### Running the Application

1. Start your application server
2. Deploy the WAR file from the `target` directory
3. Access the application at `http://localhost:8080/user-profile-and-authentication/`

## Learning Resources

### Recommended Study Order

1. **Core Java**
   - Study the User class
   - Learn about Java Collections
   - Understand Java I/O

2. **Database**
   - Study SQL basics
   - Learn about JDBC
   - Understand database design

3. **Web Technologies**
   - Learn HTML5 and CSS3
   - Study JavaScript basics
   - Understand HTTP protocol

4. **Java Web**
   - Study Servlet API
   - Learn JSP and JSTL
   - Understand session management

### Additional Resources

- [Jakarta Servlet API Documentation](https://jakarta.ee/specifications/servlet/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Maven Documentation](https://maven.apache.org/guides/)
- [Java Tutorials](https://docs.oracle.com/javase/tutorial/)

## Contributing

Students are encouraged to:
1. Fork the repository
2. Create new features
3. Fix bugs
4. Improve documentation
5. Submit pull requests

## License

This project is intended for educational purposes only. All code is provided for learning and reference purposes.

## Support

For any questions or assistance, please contact:
- Vinay Koirala
- Email: koiralavinay@gmail.com
- Professional: binaya.koirala@iic.edu.np

## Acknowledgments

Special thanks to:
- Itahari International College for providing resources
- All students who have contributed to this project
- The Jakarta EE community for their excellent documentation and support
