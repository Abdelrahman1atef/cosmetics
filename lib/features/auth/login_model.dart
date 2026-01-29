class LoginReqModel {
  late final String countryCode;
  late final String phoneNumber;
  late final String password;

  LoginReqModel({required this.countryCode, required this.phoneNumber, required this.password});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['countryCode'] = countryCode;
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    return data;
  }
}

class LoginResModel {
  late final String token;
  late final User user;

  LoginResModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = User.fromJson(json['user']);
  }
}

class User {
  late final int id;
  late final String username;
  late final String email;
  late final String phoneNumber;
  late final String countryCode;
  late final String role;
  late final String profilePhotoUrl;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.countryCode,
    required this.role,
    required this.profilePhotoUrl,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    countryCode = json['countryCode'];
    role = json['role'];
    profilePhotoUrl = json['profilePhotoUrl'].toString();
  }
}
