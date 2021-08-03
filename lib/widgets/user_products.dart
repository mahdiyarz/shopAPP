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
    return Dismissible(
      key: ValueKey(productId),
      background: Container(
        color: Colors.red.shade400,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(5),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<ProductProvider>(context, listen: false)
            .deleteProduct(productId);
      },
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Column(
            children: [
              Container(
                height: 15,
                child: Row(
                  children: [
                    Icon(Icons.keyboard_arrow_left),
                    Text(
                      'delete',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Container(
                height: 35,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_right),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          EditeScreen.routeName,
                          arguments: productId,
                        );
                      },
                    ),
                    Text(
                      'edite',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
