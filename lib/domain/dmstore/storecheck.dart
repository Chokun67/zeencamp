class Check {
  final bool status;
  final String message;

  Check({
    required this.status,
    required this.message,
  });

  factory Check.fromJson(Map<String, dynamic> json) {
    return Check(
      status: json['status'],
      message: json['message'],
    );
  }
}