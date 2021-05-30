import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sync_biryani_web/helpers/screen_navigation.dart';
import 'package:sync_biryani_web/provider/cart_provider.dart';
import 'package:sync_biryani_web/provider/coupon_provider.dart';
import 'package:sync_biryani_web/screens/login.dart';
import 'package:sync_biryani_web/services/cart_service.dart';
import 'package:sync_biryani_web/services/order_services.dart';
import 'package:sync_biryani_web/services/user_services.dart';
import 'package:sync_biryani_web/widgets/cart/cart_list.dart';
import 'package:sync_biryani_web/widgets/cart/cod_toggle.dart';
import 'package:sync_biryani_web/widgets/cart/coupon_widget.dart';

class Cart extends StatefulWidget {
  final DocumentSnapshot document;
  Cart({this.document});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  UserServices _userService = UserServices();
  OrderServices _orderServices = OrderServices();
  CartService _cartService = CartService();
  User user = FirebaseAuth.instance.currentUser;

  int deliveryFee = 50;
  double discount = 0;

  @override
  Widget build(BuildContext context) {
    var _cartProvider = Provider.of<CartProvider>(context);
    var _coupon = Provider.of<CouponProvider>(context);
    _cartProvider.getCartTotal();
    double subTotal = _cartProvider.subTotal;
    double discountRate = _coupon.discountRate / 100;
    setState(() {
      discount = (subTotal * discountRate);
    });
    var _payable = _cartProvider.subTotal + deliveryFee - discount;

    return Card(
      color: Colors.grey[350],
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,

        // color: Colors.grey[200],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cart",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text("Items " + _cartProvider.cartQty.toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 2,
                width: MediaQuery.of(context).size.width / 3.5,
                color: Colors.black,
              ),
            ),
            _cartProvider.cartQty != 0
                ? Column(
                    children: [
                      CartList(),

                      // Coupon code exicution
                      CouponWidget(),
                      // Bill Detailed Card

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.5,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bill Detail',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Cart value',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    Text(
                                      'Rs.  ' +
                                          _cartProvider.subTotal.toString(),
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                if (discount > 0)
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Discount ',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                      Text(
                                        'Rs.  ' + discount.toStringAsFixed(0),
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Delivery Charges ',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    Text(
                                      'Rs.  ' + deliveryFee.toString(),
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.grey),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Total Amount Payble ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      'Rs.  ' + _payable.toStringAsFixed(0),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.3),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Total Saving',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                        ),
                                        Text(_cartProvider.saving
                                            .toStringAsFixed(0)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(thickness: 1, color: Colors.blueGrey),
                      Container(
                        height: 100,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Deliver to This Address',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Change',
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                  'Flat No 205, Nanda block, Mahavir Enclave 1, Near Jamun gali Delhi 110045'),
                            )
                          ],
                        ),
                      ),
                      CodToggleSwitch(),
                    ],
                  )
                : Container(
                    height: 300,
                    child: Center(
                      child: Text("Your Cart Is Empty"),
                    ),
                  ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Total: Rs. " + _payable.toStringAsFixed(0),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      color: Colors.green[500],
                      height: 40,
                      onPressed: () {
                        _userService.getUserById(user.uid).then((value) {
                          if (value.name == null) {
                            changeScreen(context, LoginPage());
                          } else {
                            EasyLoading.show(status: 'Please Wait...');
                            // TODO: Payment Gateway intigration
                            _saveOrder(_cartProvider, _payable, _coupon);
                          }
                        });
                      },
                      child: Text(
                        "Checkout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _saveOrder(CartProvider cartProvider, payable, CouponProvider coupon) {
    _orderServices.saveOrder({
      'products': cartProvider.cartList,
      'userId': user.uid,
      'deliveryFee': deliveryFee,
      'totalPayable': payable,
      'discount': discount.toStringAsFixed(0),
      'cod': cartProvider.cod, // cod or not
      'discountCoupon': coupon == null ? null : coupon.title,
      'timeStamp': DateTime.now().toString(),
      'orderStatus': 'Ordered',
      'deliveryBoy': {
        'name': '',
        'phone': '',
        'location': '',
      },
    }).then((value) {
      // After Submitting order clear Cart
      _cartService.deleteCart().then((value) {
        _cartService.checkData().then((value) {
          EasyLoading.showSuccess('Your Order Is Submitted');
        });
      });
    });
  }
}
