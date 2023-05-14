// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';
// import '../domain/customer.dart' show Customer;

// Future<Customer> apiLogin(String login, String pswd) async {
//   return Customer(code: 200, accessToken: "123");
//   var response = await http.post(
//       Uri.parse('http://10.32.55.145:5000/api/v1/user/sign_in'),
//       headers: <String, String>{'content-type': 'application/json'},
//       body: jsonEncode(
//           <String, String>{'username': login, 'password': pswd}));

//   return Customer.fromJson(jsonDecode(response.body));
// }
