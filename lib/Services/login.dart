import 'dart:convert';

import 'package:bcrypt/bcrypt.dart';
import 'package:http/http.dart' as http;
import '../Constant_Data/domaine.dart';
import '../Entities/Professeur.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login {
  Future<LoginResult> loginProf(String email, String password) async {
    final Uri url = Uri.https('pgpe.innovup.com.tn', '/mobile/apis/Professeur/Login');

    try {
      final Map<String, dynamic> requestBody = {
        "Email": email,
        "Password": password,
      };
      final String jsonBody = jsonEncode(requestBody);

      final http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('professor')) {
          final professor = Professeur.fromJson(responseData['professor']);
          return LoginResult.success(professor);
        } else {
          // Handle the case where 'professor' is not in the response.
          return LoginResult.failure('Response format is not as expected.');
        }
      } else {
        // Handle different error status codes with custom messages
        if (response.statusCode == 401) {
          // Unauthorized (e.g., invalid email/password)
          return LoginResult.failure('Email ou mot de passe invalide');
        } else {
          // Other error status codes
          return LoginResult.failure('Une erreur s\'est produite. Veuillez réessayer plus tard.');
        }
      }
    } catch (e) {
      // Handle exceptions more gracefully, e.g., show a generic error message
      print('Error sending professor data: $e');
      return LoginResult.failure('Une erreur s\'est produite. Veuillez réessayer plus tard.');
    }
  }
}

enum LoginResultType { success, failure }

class LoginResult {
  final LoginResultType type;
  final Professeur? professor;
  final String? errorMessage;

  LoginResult.success(this.professor)
      : type = LoginResultType.success,
        errorMessage = null;

  LoginResult.failure(this.errorMessage)
      : type = LoginResultType.failure,
        professor = null;

  bool get isSuccess => type == LoginResultType.success;
}
