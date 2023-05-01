import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../domain/customer.dart' show Customer;

Future<Customer> apiLogin(String login, String pswd) async {
  var response = await http.post(
      Uri.parse('http://10.18.8.131:5000/api/v1/user/sign_in'),
      headers: <String, String>{'content-type': 'application/json'},
      body: jsonEncode(
          <String, String>{'username': login, 'password': pswd}));
  // if (response.statusCode == 200) {
  return Customer.fromJson(jsonDecode(response.body));
  // }
}
