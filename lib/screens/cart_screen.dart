import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/order.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(label: Text('\$${cartData.totalAmount}')),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Provider.of<Order>(context, listen: false).addOrders(
                          cartData.items.values.toList(), cartData.totalAmount);
                      cartData.clearCart();
                    },
                    child: Text('Compelete Orders'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.items.length,
              itemBuilder: (ctx, i) => CartItem(
                cartData.items.values.toList()[i].id as String,
                cartData.items.keys.toList()[i],
                cartData.items.values.toList()[i].title as String,
                cartData.items.values.toList()[i].price,
                cartData.items.values.toList()[i].quantity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
