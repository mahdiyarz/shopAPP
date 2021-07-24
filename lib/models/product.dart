import 'package:flutter/foundation.dart';

class Product {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;
  final bool? isShirt;
  final bool? isScarf;
  final bool? isPan;
  final bool? isJean;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.isShirt,
    @required this.isJean,
    @required this.isPan,
    @required this.isScarf,
  });
}
