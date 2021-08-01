import 'package:flutter/material.dart';

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
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 70,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.keyboard_arrow_left),
                  Text(
                    'delete',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.keyboard_arrow_right),
                  Text(
                    'edite',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
