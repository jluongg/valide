import 'dart:convert';

import 'package:http/http.dart' as http;

// Il faudra ajouter les permissions pour http dans ios

/// A class that many Widgets can interact with to call the backend api.
class BackendManager {
  final client = http.Client();

  Future<bool> isConnectionAlive([int retries = 3]) async {
    var response = await client.post(
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      Uri.http('192.168.35.51:8080', '/ping'),
      body: jsonEncode(<String, String>{
        "name": "ping",
      }),
    );
    print(response.body);
    return response.statusCode == 200;
  }
}
