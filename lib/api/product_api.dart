import 'dart:convert';
import 'package:fzc_global_app/models/product_model.dart';
import "package:http/http.dart" as http;

Future<List<ProductModel>> getProducts() async {
  final response = await http.get(Uri.parse("https://dummyjson.com/products"));

  if (response.statusCode == 200) {
    List jsonRepsonse = json.decode(
        "[\r\n  {\"itemcode\":1,\"title\":\"Product 1\",\"price\":10.0,\"qty\":1,\"totalAmount\":10.0},\r\n  {\"itemcode\":2,\"title\":\"Product 2\",\"price\":20.0,\"qty\":2,\"totalAmount\":40.0},\r\n  {\"itemcode\":3,\"title\":\"Product 3\",\"price\":30.0,\"qty\":3,\"totalAmount\":90.0},\r\n  {\"itemcode\":4,\"title\":\"Product 4\",\"price\":40.0,\"qty\":4,\"totalAmount\":160.0},\r\n  {\"itemcode\":5,\"title\":\"Product 5\",\"price\":50.0,\"qty\":5,\"totalAmount\":250.0},\r\n  {\"itemcode\":6,\"title\":\"Product 6\",\"price\":60.0,\"qty\":6,\"totalAmount\":360.0},\r\n  {\"itemcode\":7,\"title\":\"Product 7\",\"price\":70.0,\"qty\":7,\"totalAmount\":490.0},\r\n  {\"itemcode\":8,\"title\":\"Product 8\",\"price\":80.0,\"qty\":8,\"totalAmount\":640.0},\r\n  {\"itemcode\":9,\"title\":\"Product 9\",\"price\":90.0,\"qty\":9,\"totalAmount\":810.0},\r\n  {\"itemcode\":10,\"title\":\"Product 10\",\"price\":100.0,\"qty\":10,\"totalAmount\":1000.0},\r\n  {\"itemcode\":11,\"title\":\"Product 11\",\"price\":110.0,\"qty\":11,\"totalAmount\":1210.0},\r\n  {\"itemcode\":12,\"title\":\"Product 12\",\"price\":120.0,\"qty\":12,\"totalAmount\":1440.0},\r\n  {\"itemcode\":13,\"title\":\"Product 13\",\"price\":130.0,\"qty\":13,\"totalAmount\":1690.0},\r\n  {\"itemcode\":14,\"title\":\"Product 14\",\"price\":140.0,\"qty\":14,\"totalAmount\":1960.0},\r\n  {\"itemcode\":15,\"title\":\"Product 15\",\"price\":150.0,\"qty\":15,\"totalAmount\":2250.0}\r\n]\r\n");
    return jsonRepsonse.map((item) => ProductModel.fromJson(item)).toList();
  } else {
    throw Exception("Failed to load products!");
  }
}
