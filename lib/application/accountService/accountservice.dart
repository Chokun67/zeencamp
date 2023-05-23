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
    if (response.statusCode == 200) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      // print(response.statusCode);
      return null;
    }
  }

  Future<Register?> apiRegister(String login, String username, String pswd,
      String date, String gender) async {
    // print("email" + login);
    // print("user" + username);
    // print(pswd);
    // print(date);
    // print(gender);

    var url = Uri.parse('http://18.141.143.217:17003/api/v1/member/register');
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode({
      "name": username.toString(),
      "username": login.toString(),
      "password": pswd.toString(),
      "birthday": "1",
      "sex": gender
    });

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return Register.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
