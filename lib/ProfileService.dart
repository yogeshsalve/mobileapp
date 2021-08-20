import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileServices {
  Future<LoginApiResponse> apiCallLogin(Map<String, dynamic> param) async {
    var url = Uri.parse('https://yogeshsalve.com/API/users/fetchusers.php');
    var response = await http.post(url, body: param);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = jsonDecode(response.body);
    // print(data);
    return LoginApiResponse(
        id: data["id"],
        username: data["username"],
        email: data["email"],
        company: data["companyname"],
        address: data["address"],
        contactno: data["contactno"],
        status: data["error"].toString());
  }
}

class LoginApiResponse {
  final String? id;
  final String? username;
  final String? email;
  final String? company;
  final String? address;
  final String? status;
  final String? contactno;

  LoginApiResponse(
      {this.id,
      this.username,
      this.email,
      this.company,
      this.address,
      this.contactno,
      this.status});
}
