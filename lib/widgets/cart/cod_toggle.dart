import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:provider/provider.dart';
import 'package:sync_biryani_web/provider/cart_provider.dart';

class CodToggleSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _cart = Provider.of<CartProvider>(context);
    return Container(
      width: 300,
      child: FlutterToggleTab(
        width: 22,
        borderRadius: 10,
        height: 33,
        initialIndex: 0,
        selectedBackgroundColors: [Colors.blue],
        selectedTextStyle: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
        unSelectedTextStyle: TextStyle(
            color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
        labels: ["Pay Online", "Cash on Delivery"],
        selectedLabelIndex: (index) {
          // print('$index');
          _cart.getPaymentMethod(index);
        },
        isScroll: false, // Do something with index
      ),
    );
  }
}
