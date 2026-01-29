class RegisterRequestModel {
  final String username;
  final String countryCode;
  final String phoneNumber;
  final String email;
  final String password;

  RegisterRequestModel({
    required this.username,
    required this.countryCode,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "countryCode": countryCode,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": password,
    };
  }
}

class RegisterResponseModel {
  final String message;

  RegisterResponseModel({required this.message});

  static RegisterResponseModel fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(message: json["message"]);
  }
}