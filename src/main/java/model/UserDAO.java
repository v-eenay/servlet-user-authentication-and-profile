package model;

import java.sql.*;

public class UserDAO {
    //Instance variables for database connection
    private static final String URL = "jdbc:mysql://localhost:3306/user_authentication";
    private static final String USER = "root";
    private static final String PASS = "";

    static{
        //Calling the driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
    //Method for database connection
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
    //Method for storing user into database
    // Method to Add User to Database
    public static int addUser(User user) {
        String query = "INSERT INTO users (username, email, password, fullName, dateOfBirth, gender, phone, address, profilePicture) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword()); // Ensure password is hashed before inserting
            ps.setString(4, user.getFullName());
            ps.setDate(5, new java.sql.Date(user.getDateOfBirth().getTime())); // Convert Date to SQL Date
            ps.setString(6, user.getGender());
            ps.setString(7, user.getPhone());
            ps.setString(8, user.getAddress());

            // Handling Profile Picture (if not null)
            if (user.getProfilePicture() != null) {
                ps.setBytes(9, user.getProfilePicture()); // Store image as BLOB
            } else {
                ps.setNull(9, Types.BLOB); // If no image, set NULL
            }

            // Execute Update
            int affectedRows = ps.executeUpdate();

            // Retrieve Auto-Generated User ID (Optional)
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // Return the new user ID
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return -1; // Return -1 if insertion fails
    }

    // Method to authenticate user
    public static User getUserByEmailOrUsername(String emailOrUsername, String password) {
        String query = "SELECT * FROM users WHERE (email = ? OR username = ?) AND password = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, emailOrUsername);
            ps.setString(2, emailOrUsername);
            ps.setString(3, password); // Ensure password is hashed before comparison

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("fullName"),
                        rs.getDate("dateOfBirth"),
                        rs.getString("gender"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getBytes("profilePicture") // Binary image data
                );
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return null; // Return null if authentication fails
    }
    // Method to update user details
    public static boolean updateUser(User user) {
        String query = "UPDATE users SET password = ?, fullName = ?, dateOfBirth = ?, gender = ?, phone = ?, address = ?, profilePicture = ? WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, user.getPassword()); // Ensure password is hashed before storing
            ps.setString(2, user.getFullName());
            ps.setDate(3, new java.sql.Date(user.getDateOfBirth().getTime())); // Convert Date to SQL Date
            ps.setString(4, user.getGender());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAddress());

            // Handling Profile Picture
            if (user.getProfilePicture() != null) {
                ps.setBytes(7, user.getProfilePicture()); // Update image
            } else {
                ps.setNull(7, Types.BLOB); // If no new image, set NULL
            }

            ps.setInt(8, user.getId()); // WHERE condition (ensures ID remains unchanged)

            // Execute update and check if successful
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0; // Returns true if update was successful

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return false; // Return false if update fails
    }
    // Method to delete user by username/email and password
    public static boolean deleteUser(String emailOrUsername, String password) {
        String queryCheck = "SELECT id, password FROM users WHERE (email = ? OR username = ?)";
        String queryDelete = "DELETE FROM users WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement psCheck = conn.prepareStatement(queryCheck);
             PreparedStatement psDelete = conn.prepareStatement(queryDelete)) {

            // Step 1: Check if the username/email and password match
            psCheck.setString(1, emailOrUsername);
            psCheck.setString(2, emailOrUsername);
            ResultSet rs = psCheck.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("id");
                String storedPassword = rs.getString("password"); // Get stored password

                if (!storedPassword.equals(password)) { // Compare passwords
                    System.out.println("Incorrect password. User deletion failed.");
                    return false;
                }

                // Step 2: If password matches, delete the user
                psDelete.setInt(1, userId);
                int affectedRows = psDelete.executeUpdate();
                return affectedRows > 0; // Returns true if deletion was successful
            } else {
                System.out.println("User not found with that username/email.");
                return false;
            }

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return false; // Return false if deletion fails
    }
}
