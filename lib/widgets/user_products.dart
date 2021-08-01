import 'package:flutter/material.dart';

class UserProducts extends StatelessWidget {
  final String title;
  final String imageUrl;

  UserProducts(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
    );
  }
}
