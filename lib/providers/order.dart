import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
  String authToken;
  String userId;

  Order(this._orders, this.userId, this.authToken);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final url = Uri.https(
        'my-shop-app-5ef04-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/orders/$userId.json', {
      'auth': authToken,
    });
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final Map<String, dynamic>? extractedOrders = json.decode(response.body);

    if (extractedOrders == null) {
      return;
    }
    extractedOrders.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
        id: orderId,
        amount: orderData['amount'],
        products: (orderData['products'] as List<dynamic>)
            .map((e) => CartItem(
                  id: e['id'],
                  title: e['title'],
                  quantity: e['quantity'],
                  price: e['price'],
                ))
            .toList(),
        dateTime: DateTime.parse(orderData['dateTime']),
      ));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrders(List<CartItem> cartProduct, double total) async {
    final url = Uri.https(
        'my-shop-app-5ef04-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/orders/$userId.json', {
      'auth': authToken,
    });
    final dateTamp = DateTime.now();
    final response = await http.post(url,
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
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProduct,
          dateTime: dateTamp,
        ));
    notifyListeners();
  }
}
