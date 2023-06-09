class Register {
  final int code;
  final String accessToken;
  final bool isstore;
  final String idAccount;
  // final String message;

  const Register(
      {required this.code,
      required this.accessToken,
      required this.isstore,
      required this.idAccount,
      });

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
        code: json['code'],
        accessToken: json['accessToken'],
        isstore: json['store'],
        idAccount: json['idAccount'],
        );
  }
}
