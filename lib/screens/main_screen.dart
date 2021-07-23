import 'package:flutter/material.dart';

import '../widgets/product_grid_view.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: ProductGridView(),
    );
  }
}
