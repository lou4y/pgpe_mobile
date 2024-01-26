import 'dart:convert';
import 'package:bcrypt/bcrypt.dart';
import 'package:http/http.dart' as http;

import '../Constant_Data/domaine.dart';

class Register {
  Future<RegisterResult> registerProf(String email, String password) async {
    var url =
    Uri.https('pgpe.innovup.com.tn', '/mobile/apis/Professeur/Register');
    try {

      final Map<String, dynamic> requestBody = {
        'Email': email,
        'Password': password,
      };
      print(requestBody);

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );
      print("---------------------------------------------");
      print(jsonDecode(response.body));
      print("---------------------------------------------");
      if (response.statusCode == 200) {
        // Registration was successful
        print('Registration successful');
        return RegisterResult.success();
      } else {
        // Registration failed
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['error'] ?? 'Une erreur s\'est produite.';
        return RegisterResult.failure(errorMessage);
      }
    } catch (e) {
      // Exception occurred during registration
      print('Error registering professor: $e');
      return RegisterResult.failure('Une erreur s\'est produite. Veuillez réessayer plus tard.');
    }
  }
}

enum RegisterResultType { success, failure }

class RegisterResult {
  final RegisterResultType type;
  final String? errorMessage;

  RegisterResult.success()
      : type = RegisterResultType.success,
        errorMessage = null;

  RegisterResult.failure(this.errorMessage)
      : type = RegisterResultType.failure;

  bool get isSuccess => type == RegisterResultType.success;
}
