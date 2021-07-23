import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorite-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favorites'),
      ),
      body: Center(
        child: Text('If you like anything, can see here.'),
      ),
    );
  }
}
