class Personal {
  final String name;
  final String username;
  final String birthday;
  final String sex;

  Personal({
    required this.name,
    required this.username,
    required this.birthday,
    required this.sex
  });

  factory Personal.fromJson(Map<String, dynamic> json) {
    return Personal(
      name: json['state'],
      username: json['username'],
      birthday: json['birthday'],
      sex: json['sex'],
    );
  }
}