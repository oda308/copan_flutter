class User {
  final String email;
  final String accessToken;

  static User? instance;

  factory User({required String email, required String accessToken}) {
    instance ??= User._internal(email: email, accessToken: accessToken);
    return instance!;
  }

  User._internal({required this.email, required this.accessToken});
}
