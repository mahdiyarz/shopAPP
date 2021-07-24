import 'package:flutter/material.dart';

import '../models/product.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorite-screen';

  final List<Product> favoriteProduct;
  FavoriteScreen(this.favoriteProduct);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favorites'),
      ),
      body: Center(
        child: Text('If you like anything, can see here. Start adding some...'),
      ),
    );
  }
}
