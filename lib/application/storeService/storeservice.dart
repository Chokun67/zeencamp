import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:zeencamp/domain/dmstore/allstore.dart';
import 'package:zeencamp/domain/dmstore/detailshopdm.dart';

class StoresService {
  var ipLogin = "13.214.174.255:17003";
  Future<List<Allstore>> getStores(token) async {
    final response = await http.get(
      Uri.parse('http://$ipLogin/api/v1/stores/get-all-stores'),
      headers: {
        'content-type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      List<Allstore> stores =
          jsonList.map((json) => Allstore.fromJson(json)).toList();
      return stores;
    } else {
      throw Exception('Failed to fetch stores');
    }
  }

  Future<Customer> fetchStoreData(token, idshop) async {
    final response = await http.get(
        Uri.parse('http://$ipLogin/api/v1/stores/get-detail-store?id=$idshop'),
        headers: {
          'content-type': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });

    if (response.statusCode == 200) {
      var decodeutf8 = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> jsonData = jsonDecode(decodeutf8);
      final storeData = Customer(
        storePicture: jsonData['storePicture'],
        menuStores: List<Store>.from(
            jsonData['menuStores'].map((x) => Store.fromJson(x))),
      );
      return storeData;
    } else {
      throw Exception(
          'เกิดข้อผิดพลาดในการร้องขอข้อมูล: ${response.statusCode}');
    }
  }
}
