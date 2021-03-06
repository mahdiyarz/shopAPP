import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../models/http_exception.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [];
  //  = [
  // Product(
  //   id: 'p11111111',
  //   title: 'Red Shirt',
  //   description: 'A red shirt - it is pretty red!',
  //   price: 29.99,
  //   imageUrl:
  //       'https://rukminim1.flixcart.com/image/714/857/juh9ksw0/shirt/g/f/j/xl-red-casual-shirt-qlonz-store-original-imaffhcbrb4kgsuv.jpeg?q=50',
  //   isJean: false,
  //   isPan: false,
  //   isScarf: false,
  //   isShirt: true,
  // ),
  // Product(
  //   id: 'p21111111',
  //   title: 'Trousers',
  //   description: 'A nice pair of trousers.',
  //   price: 59.99,
  //   imageUrl:
  //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
  //   isJean: true,
  //   isPan: false,
  //   isScarf: false,
  //   isShirt: false,
  // ),
  // Product(
  //   id: 'p311111',
  //   title: 'Yellow Scarf',
  //   description: 'Warm and cozy - exactly what you need for the winter.',
  //   price: 19.99,
  //   imageUrl: 'https://m.media-amazon.com/images/I/417Kbn0NO8L.jpg',
  //   isJean: false,
  //   isPan: false,
  //   isScarf: true,
  //   isShirt: false,
  // ),
  // Product(
  //   id: 'p4111111',
  //   title: 'A Pan',
  //   description: 'Prepare any meal you want.',
  //   price: 49.99,
  //   imageUrl:
  //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  //   isJean: false,
  //   isPan: true,
  //   isScarf: false,
  //   isShirt: false,
  // ),
  // ];

  String authToken;
  String userId;

  ProductProvider(this._items, this.authToken, this.userId);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorate == true).toList();
  }

  Product findById(String id) {
    return _items.firstWhere(
      (element) => element.id == id,
    );
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    var url = Uri.https(
        'my-shop-app-5ef04-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/products.json', {
      'auth': authToken,
      if (filterByUser) 'orderBy': '"creatorId"',
      if (filterByUser) 'equalTo': '"$userId"',
    });
    try {
      // print(url);
      final response = await http.get(url);
      // print(json.decode(response.body));
      final Map<String, dynamic>? extractedData = json.decode(response.body);

      if (extractedData == null) {
        return;
      }
      var favUrl = Uri.https(
          'my-shop-app-5ef04-default-rtdb.asia-southeast1.firebasedatabase.app',
          '/favProducts/$userId.json', {
        'auth': authToken,
      });
      final favResponse = await http.get(favUrl);
      // print(json.decode(favResponse.body));
      final favData = json.decode(favResponse.body);
      final List<Product> loadedProduct = [];
      extractedData.forEach((proId, proData) {
        loadedProduct.add(
          Product(
              id: proId,
              title: proData['title'],
              description: proData['description'],
              price: proData['price'],
              imageUrl: proData['imageUrl'],
              isShirt: proData['isShirt'],
              isJean: proData['isJean'],
              isPan: proData['isPan'],
              isScarf: proData['isScarf'],
              isFavorate: favData == null ? false : favData[proId] ?? false),
        );
      });
      _items = loadedProduct;
      notifyListeners();
    } catch (error) {
      throw 'Permition denied from your server. Please check your url path of authentication!';
    }
  }

  Future<void> addProduct(Product newProduct) {
    final url = Uri.https(
        'my-shop-app-5ef04-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/products.json', {
      'auth': authToken,
    });
    return http
        .post(
      url,
      body: json.encode({
        'title': newProduct.title,
        'price': newProduct.price,
        'description': newProduct.description,
        'imageUrl': newProduct.imageUrl,
        'isJean': newProduct.isJean,
        'isPan': newProduct.isPan,
        'isScarf': newProduct.isScarf,
        'isShirt': newProduct.isShirt,
        'creatorId': userId,
      }),
    )
        .then((response) {
      print(json.decode(response.body));
      final myProduct = Product(
          id: json.decode(response.body)['name'],
          title: newProduct.title,
          description: newProduct.description,
          price: newProduct.price,
          imageUrl: newProduct.imageUrl,
          isShirt: false,
          isJean: false,
          isPan: false,
          isScarf: false);
      _items.add(myProduct);
      notifyListeners();
    }).catchError((error) {
      print(error);
      throw error;
    });
  }

  Future<void> updateProduct(String productId, Product editedProduct) async {
    final productIndex =
        _items.indexWhere((element) => element.id == productId);
    if (productIndex >= 0) {
      final url = Uri.https(
          'my-shop-app-5ef04-default-rtdb.asia-southeast1.firebasedatabase.app',
          '/products/$productId.json', {
        'auth': authToken,
      });
      await http.patch(url,
          body: json.encode({
            'title': editedProduct.title,
            'price': editedProduct.price,
            'imageUrl': editedProduct.imageUrl,
            'description': editedProduct.description,
          }));
      _items[productIndex] = editedProduct;
      notifyListeners();
    } else {
      print('CHECK THE product_provider.dart');
    }
  }

  Future<void> deleteProduct(String productId) async {
    final url = Uri.https(
        'my-shop-app-5ef04-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/products/$productId.json', {
      'auth': authToken,
    });
    final existingProIndex =
        _items.indexWhere((element) => element.id == productId);
    Product? existingProduct = _items[existingProIndex];
    _items.removeAt(existingProIndex);
    final response = await http.delete(url);
    print(response.statusCode);
    if (response.statusCode >= 400) {
      _items.insert(existingProIndex, existingProduct);

      notifyListeners();
      throw HttpException('Delete not compelete!');
    }
    existingProduct = null;

    notifyListeners();
  }
}
