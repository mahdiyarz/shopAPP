import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://rukminim1.flixcart.com/image/714/857/juh9ksw0/shirt/g/f/j/xl-red-casual-shirt-qlonz-store-original-imaffhcbrb4kgsuv.jpeg?q=50',
      isJean: false,
      isPan: false,
      isScarf: false,
      isShirt: true,
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
      isJean: true,
      isPan: false,
      isScarf: false,
      isShirt: false,
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl: 'https://m.media-amazon.com/images/I/417Kbn0NO8L.jpg',
      isJean: false,
      isPan: false,
      isScarf: true,
      isShirt: false,
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
      isJean: false,
      isPan: true,
      isScarf: false,
      isShirt: false,
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere(
      (element) => element.id == id,
    );
  }

  void addProduct() {
    notifyListeners();
  }
}
