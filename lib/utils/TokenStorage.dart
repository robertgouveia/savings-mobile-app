import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenStorage {
  final _storage = const FlutterSecureStorage();
  String _user = '';
  String _email = '';
  int _exp = 0;

  void _decode(String token) {
    Map<String, dynamic> decoded = JwtDecoder.decode(token);

    _user = decoded['id'];
    _email = decoded['email'];
    _exp = decoded['exp'];
  }

  bool _compareExp(String exp) {
    if (DateTime.now().microsecondsSinceEpoch ~/ 1000000 > int.parse(exp)) {
      deleteToken();
      return false;
    }
    return true;
  }

  Future<bool> saveToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);

    _decode(token);

    await _storage.write(key: 'user', value: _user);
    await _storage.write(key: 'email', value: _email);
    await _storage.write(key: 'exp', value: _exp.toString());
    return true;
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'auth_token');
    final exp = await _storage.read(key: 'exp');
    return (token != null && exp != null && _compareExp(exp)) ? true : false;
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
    await _storage.delete(key: 'user');
    await _storage.delete(key: 'email');
    await _storage.delete(key: 'exp');
  }

  Future<String?> getEmail() async {
    return await _storage.read(key: 'email');
  }
}