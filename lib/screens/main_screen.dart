import 'package:flutter/material.dart';
import 'package:shop_app/widgets/product_item.dart';

import '../data_exp.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 2 / 3,
        ),
        padding: EdgeInsets.all(5),
        itemBuilder: (ctx, i) {
          return ProdactItem(
            DATA_EXP[i].id as String,
            DATA_EXP[i].title as String,
            DATA_EXP[i].imageUrl as String,
          );
        },
        itemCount: DATA_EXP.length,
      ),
    );
  }
}
