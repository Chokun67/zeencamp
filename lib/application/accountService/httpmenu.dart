import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:zeencamp/domain/dmaccount/userdm.dart';

class AccountDetail {

  var ip = "13.214.128.220";

  Future<UserModel> apigetpoint(String token) async {

    var response = await http.get(
      Uri.parse('http://$ip:17003/api/v1/member/get-point'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return UserModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch user data');
    }
  }
}
