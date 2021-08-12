import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_details_screen.dart';
import '../models/product.dart';
import '../providers/cart.dart';
import '../providers/auth_provider.dart';

class ProdactItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context, listen: false);
    final cartData = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

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
                productData.toggleFavoriteStatus(authData.myToken as String);
              },
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          trailing: IconButton(
              onPressed: () {
                cartData.addItem(
                  productData.id as String,
                  productData.title as String,
                  productData.price as double,
                );
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added item to cart!'),
                    duration: Duration(seconds: 1),
                    action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          cartData.removeSingleItem(productData.id as String);
                        }),
                  ),
                );
              },
              icon: Consumer<Cart>(
                builder: (ctx, cartData, myChild) => Icon(
                    cartData.items.containsKey(productData.id)
                        ? Icons.shopping_cart
                        : Icons.add_shopping_cart),
              ),
              color: Theme.of(context).primaryColorDark),
        ),
      ),
    );
  }
}
