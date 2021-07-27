import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_grid_view.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';

enum filterOption {
  favorite,
  all,
}

class MainScreen extends StatefulWidget {
  static const routeName = '/main-screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          Consumer<Cart>(
            builder: (_, cartData, myChild) => Badge(
              child: myChild,
              value: cartData.itemCount.toString(),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
            ),
          ),
          PopupMenuButton(
            onSelected: (filterOption selectedValue) {
              setState(() {
                if (selectedValue == filterOption.favorite) {
                  _isFavorited = true;
                } else {
                  _isFavorited = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('My Favorites'),
                value: filterOption.favorite,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: filterOption.all,
              )
            ],
          )
        ],
      ),
      body: ProductGridView(_isFavorited),
    );
  }
}
