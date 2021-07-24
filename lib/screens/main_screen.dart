import 'package:flutter/material.dart';

import '../widgets/product_grid_view.dart';
import '../widgets/main_drawer.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main-screen';

  final Function toggleFavorite;
  final Function isFavorite;
  MainScreen(this.toggleFavorite, this.isFavorite);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      drawer: MainDrawer(),
      body: ProductGridView(toggleFavorite, isFavorite),
    );
  }
}
