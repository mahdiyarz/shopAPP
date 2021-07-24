import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/favorite_screen.dart';
import './screens/main_screen.dart';
import './screens/product_details_screen.dart';
import './providers/product_provider.dart';
import './models/product.dart';
import './our_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Product> get myData {
    return Provider.of<ProductProvider>(context, listen: false).items;
  }

  List<Product> _favoriteProduct = [];

  void _toggleFavorite(String productId) {
    final existingIndex =
        _favoriteProduct.indexWhere((element) => element.id == productId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteProduct.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteProduct
            .add(myData.firstWhere((element) => element.id == productId));
      });
    }
  }

  bool _isFavorite(String id) {
    return _favoriteProduct.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ProductProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.grey,
          fontFamily: 'Roboto',
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => MainScreen(_toggleFavorite, _isFavorite),
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          FavoriteScreen.routeName: (ctx) => FavoriteScreen(_favoriteProduct),
        },
      ),
    );
  }
}
