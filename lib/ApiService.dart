import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices {
  Future<LoginApiResponse> apiCallLogin(Map<String, dynamic> param) async {
    // var url = Uri.parse('https://yogeshsalve.com/API/users/login.php');
    var url = Uri.parse('http://114.143.151.6:901/login');
    var response = await http.post(url, body: param);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var cookie = response.headers["set-cookie"];

    var data = jsonDecode(response.body);
    // print(data);
    return LoginApiResponse(
        token: data["token"],
        error: data["login_status"],
        cookie: cookie,
        status: data["status"].toString());
  }
}

class LoginApiResponse {
  final String? token;
  final int? error;
  final String? status;
  final String? cookie;

  LoginApiResponse({this.token, this.error, this.status, this.cookie});
}
