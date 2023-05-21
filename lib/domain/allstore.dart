class Allstore {
  // final String id;
  // final String name;


  // const Allstore({required this.id, required this.name});

  // factory Allstore.fromJson(List<Map<String, dynamic>> json) {
  //   return Allstore(
  //       id: json['id'],
  //       name: json['name'],
  //   );
  // }
  final String id;
  final String name;

  Allstore({
    required this.id,
    required this.name,
  });

  factory Allstore.fromJson(Map<String, dynamic> json) {
    return Allstore(
      id: json['id'],
      name: json['name'],
    );
  }
}