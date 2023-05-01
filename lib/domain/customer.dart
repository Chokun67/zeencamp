class Customer {
  final int code;
  final String accessToken;

  const Customer({required this.code, required this.accessToken});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        code: json['code'],
        accessToken: json['accessToken']
    );
  }
}