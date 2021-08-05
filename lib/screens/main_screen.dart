import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_grid_view.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/product_provider.dart';

enum filterOption {
  favorite,
  all,
}

class MainScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _isFavorited = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<ProductProvider>(context).fetchProducts();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
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
      drawer: AppDrawer(),
      body: ProductGridView(_isFavorited),
    );
  }
}
