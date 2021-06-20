import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:provider/provider.dart';
import 'package:sync_biryani_web/provider/cart_provider.dart';
import 'package:sync_biryani_web/widgets/responsive.dart';

class CodToggleSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _cart = Provider.of<CartProvider>(context);
    return Container(
      child: FlutterToggleTab(
        width: Responsive.isDesktop(context) ? 30 : 60,
        borderRadius: 10,
        height: 33,
        initialIndex: 0,
        selectedBackgroundColors: [Colors.blue],
        selectedTextStyle: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
        unSelectedTextStyle: TextStyle(
            color: Colors.black, fontSize: 13, fontWeight: FontWeight.w400),
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
