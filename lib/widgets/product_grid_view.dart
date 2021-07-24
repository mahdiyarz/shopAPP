import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './product_item.dart';
import '../providers/product_provider.dart';

class ProductGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final products = productData.items;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 2 / 3,
      ),
      padding: const EdgeInsets.all(5),
      itemBuilder: (ctx, i) {
        return ChangeNotifierProvider.value(
          value: products[i],
          child: ProdactItem(),
        );
      },
      itemCount: products.length,
    );
  }
}
