import 'package:flutter/material.dart';

import '../widgets/product_grid_view.dart';

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
