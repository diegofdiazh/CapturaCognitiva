import 'dart:convert';
import 'package:capturacognitivajaveriana/app/data/services/database.dart';

class AuthService extends Database {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final Uri uri = Uri.https(baseUrl, "api/Account/Login");
    try {
      var response = await httpClient.post(
        uri,
        headers: headers,
        body: jsonEncode({"Email": email, "Contraseña": password}),
      );
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        //
        print("Logged: $data");
        return data;
      } else {
        print('erro -post ${data["message"]}');
        return data;
      }
    } catch (_) {
      print("Error, problemas de conexión con el server");
      return null;
    }
  }

  Future<Map<String, dynamic>> resetPassword(String email) async {
    final Uri uri = Uri.https(baseUrl, "api/Account/RecoveryPassword");
    try {
      var response = await httpClient.post(
        uri,
        headers: headers,
        body: jsonEncode({"Email": email}),
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        //
        print("Reset: $data");
        return data;
      } else {
        print('erro -post ${data["message"]}');
        return data;
      }
    } catch (_) {
      print("Error, problemas de conexión con el server");
      return null;
    }
  }
}
