import 'package:flutter/material.dart';

class EditeScreen extends StatefulWidget {
  static const routeName = '/edit-screen';
  @override
  _EditeScreenState createState() => _EditeScreenState();
}

class _EditeScreenState extends State<EditeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
      ),
      body: Container(),
    );
  }
}
