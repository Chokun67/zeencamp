class Tranfer {
  final int code;
  final String message;
  final String state;
  final String payee;
  final String date;
  final int point ;
  final int balance ;

  const Tranfer(
      {required this.code,
      required this.message,
      required this.state,
      required this.payee,
      required this.date,
      required this.point,
      required this.balance});

  factory Tranfer.fromJson(Map<String, dynamic> json) {
    return Tranfer(
        code: json['code'],
        message: json['message'],
        state: json['state'],
        payee: json['payee'],
        date: json['date'],
        point: json['point'],
        balance: json['balance']);
  }
}
