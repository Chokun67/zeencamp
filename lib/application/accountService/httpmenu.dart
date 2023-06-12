import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:zeencamp/application/accountService/accountservice.dart';
import 'dart:async';
import 'dart:convert';

import 'package:zeencamp/domain/dmaccount/userdm.dart';

class AccountDetail {
  var ipAddress = AccountService().ipAddress;
  var port = AccountService().port;

  Future<UserModel> apigetpoint(String token) async {
    var response = await http.get(
      Uri.parse('http://$ipAddress:$port/api/v1/member/get-point'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var decodeutf8 = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(decodeutf8);
      return UserModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch user data');
    }
  }
}
