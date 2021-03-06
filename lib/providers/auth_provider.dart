import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _timerChecking;

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
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final prefsData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String(),
      });

      prefs.setString('prefsKey', prefsData);
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

  Future<bool> tryToLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('prefsKey')) {
      return false;
    }
    final extractedPrefs = json.decode(prefs.getString('prefsKey') as String)
        as Map<String, dynamic>;
    final extractedDate =
        DateTime.parse(extractedPrefs['expiryDate'] as String);
    if (extractedDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedPrefs['token'] as String;
    _userId = extractedPrefs['userId'] as String;
    _expiryDate = extractedDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = '';
    _expiryDate = null;
    _userId = '';
    if (_timerChecking != null) {
      _timerChecking!.cancel();
      _timerChecking = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_timerChecking != null) {
      _timerChecking!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    Timer(Duration(seconds: timeToExpiry), logout);
  }
}
