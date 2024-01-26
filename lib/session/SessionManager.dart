import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../Entities/Professeur.dart';

class SessionManager {
  static const String _keyLoggedIn = 'isLoggedIn';
  static const String _keyProfessorData = 'professorData';

  // Function to check if the user is logged in
  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLoggedIn) ?? false;
  }

  // Function to log the user in and save professor data
  static Future<void> logIn(Professeur professor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, true);
    await prefs.setString(_keyProfessorData, jsonEncode(professor.toJson()));
  }

  // Function to log the user out and clear professor data
  static Future<void> logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, false);
    await prefs.remove(_keyProfessorData);
  }

  // Function to get professor data when logged in
  static Future<Professeur?> getProfessorData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? ProfesseurData = prefs.getString(_keyProfessorData);
    if (ProfesseurData != null) {
      return Professeur.fromJson(jsonDecode(ProfesseurData));
    }
    return null;
  }
}
