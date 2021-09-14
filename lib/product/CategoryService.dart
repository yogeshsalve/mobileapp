import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryServices {
  Future<ProductcategoryResponse> apiCallproductcategory(
      Map<String, dynamic> param) async {
    var url = Uri.parse('http://114.143.151.6:901/products-by-category');
    var response = await http.post(url, body: param);

    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    return jsonDecode(response.body);

    // print(data1);
    // return ProductcategoryResponse(
    //   desc: data1["data"]["desc"],
    //   itemno: data1.data["itemno"],
    //   stockcolour: data1.data["stock-colour"],
    //   unit: data1.data["unit"],
    //   status: data1.status,
    // );
  }
}

class ProductcategoryResponse {
  final String? desc;
  final String? itemno;
  final String? stockcolour;
  final String? unit;
  final int? status;

  ProductcategoryResponse({
    this.desc,
    this.itemno,
    this.stockcolour,
    this.unit,
    this.status,
  });
}
