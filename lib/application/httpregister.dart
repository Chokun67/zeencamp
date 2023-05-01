import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../domain/register.dart' show Register;

Future<Register> apiRegister(String login, String pswd,String date,String gender) async {
  var response = await http.post(
      Uri.parse('http://10.18.8.131:5000/api/v1/user/sign_up'),
      headers: <String, String>{'content-type': 'application/json'},
      body: jsonEncode(<String, String>{'username': login, 'password': pswd,'birthday': date,'sex':gender}));
  // if (response.statusCode == 200) {
  return Register.fromJson(jsonDecode(response.body));
  // }
}