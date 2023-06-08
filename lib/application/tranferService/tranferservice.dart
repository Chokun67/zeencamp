import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:zeencamp/domain/historydm.dart';
import 'package:zeencamp/domain/tranferdm.dart';
import 'dart:async';
import 'dart:convert';

import '../../domain/vldtranfer.dart';

class TranferService {
  var ipLogin = "13.214.130.86:17003";

  Future<Tranfer?> apiTranfer(String idTo, int pointTo, String token) async {
    // return const Customer(code: 200, accessToken: "123");
    var response = await http.put(
        Uri.parse('http://$ipLogin/api/v1/member/transfer-point'),
        headers: {
          'content-type': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{'payee': idTo, 'point': pointTo}));
    if (response.statusCode == 200) {
      return Tranfer.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<List<DepositModel>> getTranfer(token) async {
    final response = await http.get(
      Uri.parse('http://$ipLogin/api/v1/member/get-history-transfer'),
      headers: {
        'content-type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    // print(response.body);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      List<DepositModel> stores =
          jsonList.map((json) => DepositModel.fromJson(json)).toList();
      return stores;
    } else {
      throw Exception('Failed to fetch stores');
    }
  }


  Future<ValidateTranfer?> apiValidateTranfer(String idpayee, String token) async {
    var response = await http.get(
        Uri.parse('http://$ipLogin/api/v1/member/validate-transfer-point?id_payee=$idpayee'),
        headers: {
          'content-type': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },);
    if (response.statusCode == 200) {
      return ValidateTranfer.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
