import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth {
    return myToken != null;
  }

  String get myId {
    return _userId as String;
  }

  String? get myToken {
    if (_expiryDate != null &&
        _token != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDq_puXGG8IniHrx48K-t3Cosia19QjzQ4');
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responsData = json.decode(response.body);
      if (responsData['error'] != null) {
        throw HttpException(responsData['error']['message']);
      }
      _token = responsData['idToken'];
      _userId = responsData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responsData['expiresIn']),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> singup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  void logout() {
    _token = '';
    _expiryDate = null;
    _userId = '';
    notifyListeners();
  }
}
