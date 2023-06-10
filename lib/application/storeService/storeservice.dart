import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:zeencamp/domain/dmstore/allstore.dart';
import 'package:zeencamp/domain/dmstore/detailshopdm.dart';

import '../../domain/dmstore/storecheck.dart';

class StoresService {
  var ipLogin = "13.214.128.220:17003";
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
        storePicture : jsonData.containsKey('storePicture')&&jsonData['storePicture'] != null//ตรวจสอบว่ามีkeyชื่อ storePictureละรูปภาพเป็น null
      ? jsonData['storePicture']
      : "",
        menuStores: List<Store>.from(
            jsonData['menuStores'].map((x) => Store.fromJson(x))),
      );
      return storeData;
    } else {
      throw Exception(
          'เกิดข้อผิดพลาดในการร้องขอข้อมูล: ${response.statusCode}');
    }
  }

  Future<Check> apiSettostore(token, idshop) async {
    final response = await http
        .put(Uri.parse('http://$ipLogin/api/v1/stores/set-to-store'), headers: {
      'content-type': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return Check.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'เกิดข้อผิดพลาดในการร้องขอข้อมูล: ${response.statusCode}');
    }
  }

  Future<Check> setStoreimage(String token, String picture) async {
    var uri = Uri.parse('http://$ipLogin/api/v1/stores/upload-picture-stores');

    var request = http.MultipartRequest('POST', uri);
    request.headers['content-type'] = 'multipart/form-data';
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    request.files
        .add(await http.MultipartFile.fromPath('file', picture));
  
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var decodedJson = jsonDecode(responseBody);
      return Check.fromJson(decodedJson);
    } else {
      throw Exception(
          'เกิดข้อผิดพลาดในการร้องขอข้อมูล: ${response.statusCode}');
    }
  }
}
