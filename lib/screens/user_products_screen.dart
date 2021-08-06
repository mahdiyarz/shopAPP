import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../widgets/user_products.dart';
import '../widgets/app_drawer.dart';
import '../screens/edite_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-product';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditeScreen.routeName,
                arguments: '',
              );
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (_, i) {
              return Column(
                children: [
                  Divider(),
                  UserProducts(
                    productData.items[i].title as String,
                    productData.items[i].imageUrl as String,
                    productData.items[i].id as String,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
