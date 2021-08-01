import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../widgets/user_products.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-product';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Products'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
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
    );
  }
}
