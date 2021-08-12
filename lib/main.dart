import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/main_screen.dart';
import './screens/product_details_screen.dart';
import './providers/product_provider.dart';
import './providers/cart.dart';
import './providers/order.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edite_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth_provider.dart';

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
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductProvider>(
          create: (ctx) => ProductProvider([]),
          update: (ctx, authData, previuosProduct) => ProductProvider(
            previuosProduct == null ? [] : previuosProduct.items,
            authData.myToken as String,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Order>(
          create: (ctx) => Order([], ''),
          update: (ctx, authData, previuosOrders) => Order(
            previuosOrders == null ? [] : previuosOrders.orders,
            authData.myToken as String,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.cyan,
            accentColor: Colors.grey,
            fontFamily: 'Roboto',
          ),
          initialRoute: '/',
          routes: {
            '/': (ctx) => authData.isAuth ? MainScreen() : AuthScreen(),
            ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditeScreen.routeName: (ctx) => EditeScreen(),
          },
        ),
      ),
    );
  }
}
