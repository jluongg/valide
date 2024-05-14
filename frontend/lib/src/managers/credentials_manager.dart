import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A class that many Widgets can interact with to read the credentials stored with flutter_secure_storage.
class CredentialsManager {
  final FlutterSecureStorage _storage = new FlutterSecureStorage();

  String? _cred;
  String? get credentials => _cred;

  /// Load the user's credentials from the SecureStorage if possible.
  Future<void> loadCredentials() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cred = await _storage.read(key: "credentials");
    print("Credentials retrieved : $_cred");
  }

  bool isUserConnected() {
    return _cred == null; // TODO : check the credential validity
  }
}
