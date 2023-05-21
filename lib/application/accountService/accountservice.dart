import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../../domain/customer.dart';
import '../../domain/register.dart' show Register;

class AccountService {
  var ipLogin = "18.141.143.217:17003";

  Future<Customer?> apiLogin(String login, String pswd) async {
    var response = await http.post(
        Uri.parse('http://$ipLogin/api/v1/member/login'),
        headers: <String, String>{'content-type': 'application/json'},
        body:
            jsonEncode(<String, String>{'username': login, 'password': pswd}));
    // print(response.body);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<Register?> apiRegister(String login, String username, String pswd,
      String date, String gender) async {
    print("email" + login);
    print("user" + username);
    print(pswd);
    print(date);
    print(gender);
    var response =
        await http.post(Uri.parse('http://$ipLogin/api/v1/member/register'),
            headers: <String, String>{'Content-Type': 'application/json'},
            body: jsonEncode(<String, String>{
              'name': login,
              'username': username,
              'password': pswd,
              'birthday': date,
              'sex': gender
            }));
    // print(response.body);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      return Register.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
