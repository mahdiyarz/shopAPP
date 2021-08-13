import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  static const routeName = '/waiting-screen';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Please wait...'),
    );
  }
}
