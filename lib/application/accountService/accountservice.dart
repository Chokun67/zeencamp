import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../../domain/dmaccount/customer.dart';
import '../../domain/dmaccount/personal.dart';
import '../../domain/dmaccount/register.dart' show Register;
import '../../domain/dmstore/storecheck.dart';

class AccountService {
  var ipAddress = "18.140.244.160";
  var port = "17003";

  Future<Customer?> apiLogin(String login, String pswd) async {
    var response = await http.post(
        Uri.parse('http://$ipAddress:$port/api/v1/member/login'),
        headers: <String, String>{'content-type': 'application/json'},
        body:
            jsonEncode(<String, String>{'username': login, 'password': pswd}));
  
    if (response.statusCode == 200) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<Register?> apiRegister(String login, String username, String pswd,
      String date, String gender) async {
    var url = Uri.parse('http://$ipAddress:$port/api/v1/member/register');
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode({
      "name": username,
      "username": login,
      "password": pswd,
      "birthday": date,
      "sex": gender
    });

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return Register.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 409) {
      return null;
    } else {
      return null;
    }
  }

  Future<Personal?> apigetpersonal(String token) async {
    var response = await http.get(
      Uri.parse('http://$ipAddress:$port/api/v1/member/get-personal-data'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    var decodeutf8 = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      return Personal.fromJson(jsonDecode(decodeutf8));
    } else {
      return null;
    }
  }

  Future<Check> deleteAccount(String token) async {
    var response = await http.delete(
      Uri.parse('http://$ipAddress:$port/api/v1/member/delete-account'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Check.fromJson(jsonDecode(response.body));
    }
    if (response.statusCode == 404) {
      return Check(code: 404, message: "สำเร็จมั้ง");
    } else {
      throw Exception(
          'เกิดข้อผิดพลาดในการร้องขอข้อมูล: ${response.statusCode}');
    }
  }

  Future<Check> forgotpassword(String token, String username, String birthday,
      String newpassword) async {
    var response = await http.put(
        Uri.parse('http://$ipAddress:$port/api/v1/member/delete-account'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'username': username,
          'birthday': birthday,
          'newPassword': newpassword
        }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Check.fromJson(jsonDecode(response.body));
    }
    if (response.statusCode == 404) {
      return Check(code: 404, message: "unsuccessful");
    } else {
      throw Exception(
          'เกิดข้อผิดพลาดในการร้องขอข้อมูล: ${response.statusCode}');
    }
  }
}
