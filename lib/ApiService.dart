import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices {
  Future<LoginApiResponse> apiCallLogin(Map<String, dynamic> param) async {
    var url = Uri.parse('https://yogeshsalve.com/API/users/login.php');
    var response = await http.post(url, body: param);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(response.body);
    // print(data);
    return LoginApiResponse(
        token: data["token"],
        error: data["error"],
        status: data["status"].toString());
  }
}

class LoginApiResponse {
  final String? token;
  final String? error;
  final String? status;

  LoginApiResponse({this.token, this.error, this.status});
}
