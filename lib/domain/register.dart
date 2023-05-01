class Register {
  final int code;
  final String accessToken;

  const Register({required this.code, required this.accessToken});

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
        code: json['code'],
        accessToken: json['accessToken']
    );
  }
}