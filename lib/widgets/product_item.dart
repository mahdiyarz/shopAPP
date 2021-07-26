import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_details_screen.dart';
import '../models/product.dart';

class ProdactItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(45),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailsScreen.routeName,
              arguments: productData.id,
            );
          },
          child: Image.network(
            productData.imageUrl as String,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            productData.title as String,
            textAlign: TextAlign.center,
          ),
          leading: Consumer<Product>(
            builder: (ctx, productData, child) => IconButton(
              icon: Icon(productData.isFavorate
                  ? Icons.favorite
                  : Icons.favorite_border),
              onPressed: () {
                productData.toggleFavoriteStatus();
              },
              color: Theme.of(context).primaryColorDark,
            ),
            
          ),
          trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).primaryColorDark),
        ),
      ),
    );
  }
}
