class LoginModel {
  String identifier;
  String password;

  LoginModel({required this.identifier, required this.password});
}

class UserModel {
  final String loginId;
  final String username;
  final String email;

  UserModel(
      {required this.loginId, required this.username, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        loginId: json['LoginID'],
        username: json['FirstName'],
        email: json['EmailAddress']);
  }
}
