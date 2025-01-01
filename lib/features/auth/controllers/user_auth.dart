// user_auth.dart

class User {
  final String username;
  final String firstName;
  final String lastName;
  final String password;
  final String email;

  User({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.email,
  });

  // Convert a User into a Map to insert into the database
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }

  // Create a User from a Map (database record)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      password: map['password'],
    );
  }
}

class Users {
  // Authenticate a user by username and password
  Future<bool> authenticate(String username, String password) async {
    // Simulate API delay
    await Future.delayed(Duration(seconds: 1));
    // see if there is any entry in the database and then the user object must be given the corresponding values.
    return true;
  }

  // Optionally: Add a method to register a new user
  Future<bool> registerUser(User newUser) async {
    // Ensure no duplicate usernames exist

    // Simulate API delay
    await Future.delayed(Duration(seconds: 1));
    // insert the user into the database and give the user object the correct values
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
