import 'dart:convert';
import 'package:fzc_global_app/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<void> loginUser(String identifier, String password) async {
  if (identifier.isNotEmpty && password.isNotEmpty) {
    const String url = "${APIConstants.baseUrl}/Login/LoginProcess";

    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode(
              <String, String>{'email': identifier, 'password': password}));

      print(response);
    } catch (e) {}
  }
}
