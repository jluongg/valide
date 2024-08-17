import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

// Import http from the SuperTokens package to make authenticated requests
import 'package:supertokens_flutter/http.dart' as http;

// Il faudra ajouter les permissions pour http dans ios

class Backend extends ChangeNotifier {
  // utiliser notifyListeners() quand nécessaire

  final String baseUrl;
  final client = http.Client();
  String? deviceId;
  String? preAuthSessionId;
  Map<String, String>? user;

  Backend({required this.baseUrl});

  Future<bool?> isConnectionAlive() async {
    try {
      var response = await client.post(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        Uri.http(baseUrl, '/ping'),
        body: jsonEncode(<String, String>{
          "name": "ping",
        }),
      );
      print(response.body);
      return response.statusCode == 200;
    } on SocketException {
      return false;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response?> signinupSubmitEmail(String email) async {
    try {
      var response = await client.post(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        Uri.http(baseUrl, '/auth/signinup/code'),
        body: jsonEncode(<String, String>{
          "email": email,
        }),
      );
      if (response.statusCode == 200) {
        var response_json = jsonDecode(response.body);
        deviceId = response_json["deviceId"];
        preAuthSessionId = response_json["preAuthSessionId"];
      }
      return response;
    } on SocketException {
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response?> signinupConsumeCode(String code) async {
    try {
      var response = await client.post(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        Uri.http(baseUrl, '/auth/signinup/code/consume'),
        body: jsonEncode(<String, String>{
          "deviceId": deviceId!,
          "preAuthSessionId": preAuthSessionId!,
          "userInputCode": code,
        }),
      );
      if (response.statusCode == 200) {
        var response_json = jsonDecode(response.body);
        print(response_json);
        print(response_json);
        print(response_json);
        print(response_json);
        if (response_json["status"] == "OK" &&
            response_json["createdNewUser"]) {
          user = response_json["user"];
          print(user);
          notifyListeners();
        }
      }
      return response;
    } on SocketException {
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
