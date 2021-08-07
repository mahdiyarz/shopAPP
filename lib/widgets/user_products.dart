import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edite_screen.dart';
import '../providers/product_provider.dart';

class UserProducts extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String productId;

  UserProducts(this.title, this.imageUrl, this.productId);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.blueGrey,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditeScreen.routeName,
                  arguments: productId,
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              onPressed: () async {
                try {
                  await Provider.of<ProductProvider>(context, listen: false)
                      .deleteProduct(productId);
                } catch (error) {
                  scaffold.showSnackBar(SnackBar(
                      content: Text(
                    'Delete Faild!',
                    textAlign: TextAlign.center,
                  )));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
