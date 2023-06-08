import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../../domain/customer.dart';
import '../../domain/personal.dart';
import '../../domain/register.dart' show Register;

class AccountService {
  var ipLogin = "13.214.130.86:17003";

  Future<Customer?> apiLogin(String login, String pswd) async {
    var response = await http.post(
        Uri.parse('http://$ipLogin/api/v1/member/login'),
        headers: <String, String>{'content-type': 'application/json'},
        body:
            jsonEncode(<String, String>{'username': login, 'password': pswd}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<Register?> apiRegister(String login, String username, String pswd,
      String date, String gender) async {

    print(date);

    var url = Uri.parse('http://$ipLogin/api/v1/member/register');
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode({
      "name": username,
      "username": login,
      "password": pswd,
      "birthday": date,
      "sex": gender
    });

    var response = await http.post(url, headers: headers, body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Register.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<Personal> apigetpersonal(String login, String username, String pswd,
      String date, String gender) async {
    var url = Uri.parse('http://$ipLogin/api/v1/member/get-personal-data');
    var headers = {'Content-Type': 'application/json'};


    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Personal.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch user data');
    }
  }
}
