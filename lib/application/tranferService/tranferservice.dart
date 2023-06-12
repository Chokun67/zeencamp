import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:zeencamp/domain/dmstore/storecheck.dart';
import 'package:zeencamp/domain/dmtranfer/historydm.dart';
import 'package:zeencamp/domain/dmtranfer/tranferdm.dart';
import 'dart:async';
import 'dart:convert';
import '../../domain/dmtranfer/vldtranfer.dart';
import '../accountService/accountservice.dart';

class TranferService {
  var ipAddress = AccountService().ipAddress;
  var port = AccountService().port;

  Future<Tranfer?> apiTranfer(String idTo, int pointTo, String token) async {
    var response = await http.put(
        Uri.parse('http://$ipAddress:$port/api/v1/member/transfer-point'),
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
      Uri.parse('http://$ipAddress:$port/api/v1/member/get-history-transfer'),
      headers: {
        'content-type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      List<DepositModel> stores =
          jsonList.map((json) => DepositModel.fromJson(json)).toList();
      return stores;
    } else if (response.statusCode == 404) {
      List<DepositModel> stores = [];
      return stores;
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  Future<ValidateTranfer?> apiValidateTranfer(
      String idpayee, String token) async {
    var response = await http.get(
      Uri.parse(
          'http://$ipAddress:$port/api/v1/member/validate-transfer-point?id_payee=$idpayee'),
      headers: {
        'content-type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var decodeutf8 = utf8.decode(response.bodyBytes);
      return ValidateTranfer.fromJson(jsonDecode(decodeutf8));
    }
    return null;
  }

  Future<String?> getHashMenuQrCode(
      String token, String idmenu, int point) async {
    var response = await http.get(
      Uri.parse(
          'http://$ipAddress:$port/api/v1/stores/get-hash-menu-qrcode?id=$idmenu&point=$point'),
      headers: {
        'content-type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json['hash'] as String;
    } else {
      return response.statusCode.toString();
    }
  }

  Future<ValidateTranfer?> getReadHashTranfer(String token, String hash) async {
    var response = await http.get(
      Uri.parse(
          'http://$ipAddress:$port/api/v1/stores/read-hash-tranfer?hash=$hash'),
      headers: {
        'content-type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return ValidateTranfer?.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<Check> getTransferPointForMenu(String token, String hash) async {
    var response = await http.put(
        Uri.parse(
            'http://$ipAddress:$port/api/v1/stores/transfer-point-for-menu'),
        headers: {
          'content-type': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{'hash': hash}));
    if (response.statusCode == 200) {
      return Check.fromJson(jsonDecode(response.body));
    }
    return Check(code: response.statusCode, message: "error");
  }
}
