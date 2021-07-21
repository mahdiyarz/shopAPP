import 'package:flutter/material.dart';

class ProdactItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProdactItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }
}
