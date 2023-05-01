// import 'dart:io';

// import 'package:http/http.dart' as http;

// import './customer1.dart' show Customer;

// class HttpService {
    

//   Future<void> postHttp() async {
//     Uri url = Uri.parse('http://10.32.68.249:5000/api/v1/user/sing_in');
//     final response = await http.post(
//       url,
//       headers: {
//         HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
//       },
//       body: {'username': 'bootcamps', 'password': '12345678'},
//     );

//     // return Customer.fromJson(jsonDecode(response.body));
//   }
// }