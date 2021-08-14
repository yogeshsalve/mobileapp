import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileServices {
  Future<LoginApiResponse> apiCallLogin(Map<String, dynamic> param) async {
    var url = Uri.parse('http://yogeshsalve.com/API/users/fetchusers.php');
    var response = await http.post(url, body: param);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(response.body);
    // print(data);
    return LoginApiResponse(
        company: data["companyname"],
        address: data["address"],
        status: data["error"].toString());
  }
}

class LoginApiResponse {
  final String? company;
  final String? address;
  final String? status;

  LoginApiResponse({this.company, this.address, this.status});
}
