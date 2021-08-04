import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices {
  Future<LoginApiResponse> apiCallLogin(Map<String, dynamic> param) async {
    var url = Uri.parse('https://reqres.in/api/login');
    //var url = Uri.parse('https://yogeshsalve.com/APL-API/login.php');
    var response = await http.post(url, body: param);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final data = jsonDecode(response.body);
    return LoginApiResponse(token: data["token"], error: data["error"]);
  }
}

class LoginApiResponse {
  final String? token;
  final String? error;

  LoginApiResponse({this.token, this.error});
}
