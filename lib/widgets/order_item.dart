import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/order.dart' as orderModel;

class OrderItem extends StatelessWidget {
  final orderModel.OrderItem ordersData;
  OrderItem(this.ordersData);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${ordersData.amount}'),
            subtitle: Text(DateFormat('dd/MM/yyyy - hh:mm')
                .format(ordersData.dateTime as DateTime)),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
