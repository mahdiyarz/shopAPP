import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String? id;
  final double? amount;
  final List<CartItem>? products;
  final DateTime? dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrders(List<CartItem> cartProduct, double total) async {
    final url = Uri.https(
        'my-shop-app-5ef04-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/orders.json');
    final dateTamp = DateTime.now();
    await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': dateTamp.toIso8601String(),
          'products': cartProduct
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
        }));
    _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          products: cartProduct,
          dateTime: dateTamp,
        ));
    notifyListeners();
  }
}
