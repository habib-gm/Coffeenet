import 'package:bcrypt/bcrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_data_provider_imports.dart';

class AuthDataProvider extends DataProvider {
  Dio dio;
  AuthDataProvider({required this.dio});

  saveDataLocally({
    required String token,
    required String name,
    required String email,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString(
        'password', BCrypt.hashpw(password, BCrypt.gensalt()));
  }

  Future<String> login(String username, String password) async {
    try {
      dio.options.headers = {};
      dio.options.headers['content-Type'] = 'application/json';
      final response = await dio.post('$baseUrl/api/token/',
          data: <String, String>{'username': username, 'password': password});
      if (response.statusCode != 200) {
        throw (Exception('Failed to login'));
      }
      var token = response.data['access'];
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $token';
      Response getUser = await dio.get(
        '$baseUrl/api/get-curr-user/',
      );
      if (getUser.statusCode != 200) {
        throw (Exception('Failed to login'));
      }
      var name = getUser.data['name'];
      await saveDataLocally(
          token: token, email: username, password: password, name: name);

      return token;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> register(
      String fullname, String username, String password) async {
    try {
      dio.options.headers = {};
      dio.options.headers['content-Type'] = 'application/json';
      final response = await dio.post('$baseUrl/api/register/',
          data: <String, String>{
            'fullname': fullname,
            'username': username,
            'password': password
          });
      if (response.statusCode != 200) {
        throw (Exception('Failed to register'));
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> changePassword({required String newPassword}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception("notLogged In");
      }

      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $token';
      Response response = await dio
          .post('$baseUrl/api/change-password/', data: <String, String>{
        'password': newPassword,
      });

      if (response.statusCode != 200) {
        throw (Exception('Failed to register'));
      }

      bool changed = await prefs.setString(
          'password', BCrypt.hashpw(newPassword, BCrypt.gensalt()));

      return changed;
    } catch (e) {
      rethrow;
    }
  }
}
