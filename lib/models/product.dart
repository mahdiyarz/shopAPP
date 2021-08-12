import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;
  bool isFavorate;
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
    this.isFavorate = false,
    @required this.isShirt,
    @required this.isJean,
    @required this.isPan,
    @required this.isScarf,
  });

  void _favoriteStatus(bool newStatus) {
    isFavorate = newStatus;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String authToken, String userId) async {
    final oldStatus = isFavorate;
    final url = Uri.https(
        'my-shop-app-5ef04-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/favProducts/$userId/$id.json', {
      'auth': authToken,
    });
    isFavorate = !isFavorate;
    notifyListeners();
    try {
      final response = await http.put(
        url,
        body: json.encode(isFavorate),
      );
      if (response.statusCode >= 400) {
        _favoriteStatus(oldStatus);
      }
    } catch (error) {
      _favoriteStatus(oldStatus);
    }
  }
}
