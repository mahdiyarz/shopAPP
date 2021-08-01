import 'package:flutter/material.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-product';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Products'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Container(),
    );
  }
}
