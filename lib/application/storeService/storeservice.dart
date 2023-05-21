import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:zeencamp/domain/allstore.dart';
import 'package:zeencamp/domain/detailshopdm.dart';

class StoresService {

  var ipLogin = "10.32.69.1:5000";
  Future<List<Allstore>> getStores(token) async {

    final response = await http.get(
      Uri.parse('http://$ipLogin/api/v1/stores/get-all-stores'),
      headers: {
        'content-type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    // print(response.body);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      List<Allstore> stores =
          jsonList.map((json) => Allstore.fromJson(json)).toList();
      return stores;
    } else {
      throw Exception('Failed to fetch stores');
    }
  }


   Future<Customer> fetchStoreData(token,idshop) async {
    final response = await http.get(
        Uri.parse(
            'http://$ipLogin/api/v1/stores/get-detail-store?id=$idshop'),
        headers: {
        'content-type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
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
