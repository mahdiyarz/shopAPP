import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../models/http_exception.dart';

enum AuthMode {
  Login,
  SignUp,
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showDialogError(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Okay'))
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'] as String,
          _authData['password'] as String,
        );
      } else {
        // sign user up
        await Provider.of<Auth>(context, listen: false).singup(
          _authData['email'] as String,
          _authData['password'] as String,
        );
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed!';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address!';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage =
            'Your password is too weak. please enter another password.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password';
      }
      _showDialogError(errorMessage);
    } catch (error) {
      var errorMessage =
          'Could not connect to the server. Please check your internet connection.';
      _showDialogError(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.SignUp ? 320 : 260,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.SignUp ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'e-Mail'),
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty ||
                        !value.contains('@') ||
                        value.length < 10) {
                      return 'Please provide valid e-mail';
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value as String;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Please is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value as String;
                  },
                ),
                if (_authMode == AuthMode.SignUp)
                  TextFormField(
                    enabled: _authMode == AuthMode.SignUp,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.SignUp
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    child:
                        Text(_authMode == AuthMode.Login ? 'Login' : 'SignUp'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      primary: Theme.of(context).primaryColor,
                      onPrimary: Colors.white,
                    ),
                  ),
                TextButton(
                  onPressed: switchAuthMode,
                  child: Text(_authMode == AuthMode.Login
                      ? 'SignUp here'
                      : 'Login to Shop'),
                  style: TextButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
