import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:zeencamp/domain/userdm.dart';

Future<UserModel> apigetpoint(String token) async {
  var ip = "13.214.130.86:17003";
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
