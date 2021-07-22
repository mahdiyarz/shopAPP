import 'package:flutter/material.dart';

import '../data_exp.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments
        as String; //we take ID from main scrren arguments
    // final showProduct =
    //     DATA_EXP.firstWhere((element) => element.id = productId);

    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
