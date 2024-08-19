import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Import http from the SuperTokens package to make authenticated requests
import 'package:supertokens_flutter/http.dart' as http;

// Il faudra ajouter les permissions pour http dans ios

class Backend extends ChangeNotifier {
  // utiliser notifyListeners() quand nécessaire

  final String baseUrl;
  final client = http.Client();
  String? deviceId;
  String? preAuthSessionId;

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

  // Return a Response if the client was not disconnected, null otherwise.
  Response? handleClientDisconnectedError(
      Response response, BuildContext context) {
    if (response.statusCode == 404) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(AppLocalizations.of(context)!.client_connection_error)));
      }
      return null;
    } else if (response.statusCode == 403) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.access_denied)));
      }
      return null;
    } else if (response.statusCode != 200) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.unknown_error)));
      }
      return null;
    }
    return response;
  }

  void handleServerDisconnectedError(BuildContext context) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(AppLocalizations.of(context)!.server_connection_error)));
    }
  }

  Future<Response?> signinupSubmitEmail(
      BuildContext context, String email) async {
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
      if (handleClientDisconnectedError(response, context) != null) {
        var response_json = jsonDecode(response.body);
        deviceId = response_json["deviceId"];
        preAuthSessionId = response_json["preAuthSessionId"];
        return response;
      }
      return null;
    } on SocketException {
      handleServerDisconnectedError(context);
    }
    return null;
  }

  Future<Response?> signinupResendCode(BuildContext context) async {
    try {
      var response = await client.post(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        Uri.http(baseUrl, '/auth/signinup/code/resend'),
        body: jsonEncode(<String, String>{
          "deviceId": deviceId!,
          "preAuthSessionId": preAuthSessionId!,
        }),
      );
      return handleClientDisconnectedError(response, context);
    } on SocketException {
      handleServerDisconnectedError(context);
    }
    return null;
  }

  Future<Response?> signinupConsumeCode(
      BuildContext context, String code) async {
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
      if (handleClientDisconnectedError(response, context) != null) {
        var responseJson = jsonDecode(response.body);
        if (responseJson["status"] == "OK") {
          return response;
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppLocalizations.of(context)!.login_failed)));
          }
          return null;
        }
      }
    } on SocketException {
      handleServerDisconnectedError(context);
    }
    return null;
  }
}
