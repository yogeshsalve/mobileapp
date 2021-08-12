import 'package:http/http.dart' as http;

import 'dart:convert';

Future loginUser(String email, String password) async {
  Uri url = Uri.parse('https://yogeshsalve.com/API/login.php');
  var map = new Map<String, dynamic>();
  map['email'] = email;
  map['password'] = password;
  // final json = {'email': email, 'password': password};
  final response = await http.post(
    url,
    headers: {"Accept": "Application/json"},
    body: map,
  );
  var convertedDatatoJson = jsonDecode(response.body);
  // return convertedDatatoJson;
  return convertedDatatoJson;
}
