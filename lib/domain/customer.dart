class Customer {
  final int code;
  final String accessToken;
  final bool isstore;
  final String idAccount;

  const Customer({required this.code, required this.accessToken,required this.isstore, required this.idAccount});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        code: json['code'],
        accessToken: json['accessToken'],
        isstore: json['store'],
        idAccount: json['idAccount']
    );
  }
}