import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../domain/point.dart' show Point;

Future<Map<String, dynamic>> apigetpoint(String token) async {
  return {"point": 25};
  // var response =
  //     await http.get(Uri.parse('http://10.32.55.145:5000/api/v1/user/point?token=$token'));
  // return jsonDecode(response.body) as Map<String, dynamic>;
}
