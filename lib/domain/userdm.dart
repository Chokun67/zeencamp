class UserModel {
  final int code;
  final String name;
  final String id;
  final int point;

  UserModel({
    required this.code,
    required this.name,
    required this.id,
    required this.point,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      code: json['code'],
      name: json['name'],
      id: json['id'],
      point: json['point'],
    );
  }
}
