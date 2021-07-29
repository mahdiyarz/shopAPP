import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/main_screen.dart';
import './screens/product_details_screen.dart';
import './providers/product_provider.dart';
import './providers/cart.dart';
import './providers/order.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Order(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.grey,
          fontFamily: 'Roboto',
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => MainScreen(),
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
