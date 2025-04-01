# User Profile and Authentication System

A Jakarta Servlet-based web application for user authentication, registration, and profile management.

## Overview

This project implements a complete user management system with the following features:
- User registration with profile information
- Secure login and authentication
- User profile management (view, update, delete)
- Session management
- Responsive UI design

## Technologies Used

- **Backend**: Jakarta Servlet API 6.1.0
- **Frontend**: JSP, HTML, CSS
- **Build Tool**: Maven
- **Java Version**: 23
- **Testing**: JUnit 5.11.0

## Project Structure

```
user-profile-and-authentication/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── controller/       # Servlet controllers
│   │   │   │   ├── DeleteProfileServlet.java
│   │   │   │   ├── LoginServlet.java
│   │   │   │   ├── LogoutServlet.java
│   │   │   │   ├── MainServlet.java
│   │   │   │   ├── RegisterServlet.java
│   │   │   │   ├── UpdateProfileServlet.java
│   │   │   │   └── UserProfileServlet.java
│   │   │   └── model/           # Data models
│   │   │       ├── User.java    # User entity
│   │   │       └── UserDAO.java # Data Access Object
│   │   ├── resources/           # Application resources
│   │   └── webapp/              # Web resources
│   │       ├── WEB-INF/         # Web configuration
│   │       └── index.jsp        # Main page
│   └── test/                    # Test classes
├── .gitignore
├── pom.xml                      # Maven configuration
├── mvnw                         # Maven wrapper
└── README.md                    # This file
```

## Features

### User Management
- **Registration**: Create a new account with username, email, password, and profile information
- **Authentication**: Secure login with session management
- **Profile Management**: View and update personal information
- **Account Deletion**: Option to delete user account

### User Profile Data
The system stores comprehensive user information:
- Username
- Email
- Password (securely stored)
- Full Name
- Date of Birth
- Gender
- Phone Number
- Address
- Profile Picture

## Getting Started

### Prerequisites
- JDK 23 or later
- Maven 3.6 or later
- Jakarta EE compatible application server (e.g., Tomcat 10+, Jetty, etc.)

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/user-profile-and-authentication.git
   cd user-profile-and-authentication
   ```

2. Build the project:
   ```
   ./mvnw clean package
   ```
   
3. Deploy the generated WAR file to your application server.

### Running the Application

1. Start your application server
2. Deploy the WAR file from the `target` directory
3. Access the application at `http://localhost:8080/user-profile-and-authentication/`

## Development

### Building
```
./mvnw clean package
```

### Testing
```
./mvnw test
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request
