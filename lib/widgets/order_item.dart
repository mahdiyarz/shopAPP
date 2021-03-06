import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/order.dart' as orderModel;

class OrderItem extends StatefulWidget {
  final orderModel.OrderItem ordersData;
  OrderItem(this.ordersData);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expand = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.ordersData.amount!.toStringAsFixed(2)}'),
            subtitle: Text(DateFormat('dd/MM/yyyy - hh:mm')
                .format(widget.ordersData.dateTime as DateTime)),
            trailing: IconButton(
              icon: Icon(_expand ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expand = !_expand;
                });
              },
            ),
          ),
          // if (_expand)
          AnimatedContainer(
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            height: _expand
                ? min(widget.ordersData.products!.length * 20.0 + 5, 100)
                : 0,
            child: ListView(
              children: widget.ordersData.products!.map((e) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e.title as String),
                    Text('${e.quantity}x ${e.price}')
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
