// user_auth.dart

class User {
  final String username;
  final String firstName;
  final String lastName;
  final String password;
  final String email; // Optional: Add more attributes as needed

  User({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.email,
  });
}

class Users {
  // Simulated in-memory user database
  final List<User> _users = [
    User(
      username: 'admin',
      firstName: 'Jonathan',
      lastName: 'Kent',
      password: 'admin123',
      email: 'admin@example.com',
    ),
    User(
      username: 'test',
      firstName: 'mytestuser',
      lastName: 'oneRingtoRuleThemAll',
      password: 'test',
      email: 'john@example.com',
    ),
  ];

  // Singleton pattern for managing a single instance of Users
  static final Users _instance = Users._internal();

  factory Users() {
    return _instance;
  }

  Users._internal();

  // Method to retrieve all users (optional for debugging)
  List<User> getAllUsers() => _users;

  // Authenticate a user by username and password
  Future<bool> authenticate(String username, String password) async {
    // Simulate API delay
    await Future.delayed(Duration(seconds: 1));
    return _users
        .any((user) => user.username == username && user.password == password);
  }

  // Optionally: Add a method to register a new user
  Future<bool> registerUser(User newUser) async {
    // Ensure no duplicate usernames exist
    if (_users.any((user) => user.username == newUser.username)) {
      return false; // Registration failed
    }
    // Simulate API delay
    await Future.delayed(Duration(seconds: 1));

    _users.add(newUser);
    return true; // Registration successful
  }
}

// Global helper function to authenticate a user
Future<bool> authenticateUser(String username, String password) async {
  final users = Users(); // Access the Users singleton
  return await users.authenticate(username, password);
}

// Global helper function to create a new user
Future<bool> registerNewUser(
  String username,
  String firstName,
  String lastName,
  String password,
  String email,
) async {
  final users = Users(); // Access the Users singleton
  return await users.registerUser(
    User(
      username: username,
      firstName: firstName,
      lastName: lastName,
      password: password,
      email: email,
    ),
  );
}
