import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geodesy/geodesy.dart';
import 'package:js/js.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sync_biryani_web/helpers/screen_navigation.dart';
import 'package:sync_biryani_web/location/utilities/api.dart';
import 'package:sync_biryani_web/location/utilities/loc.dart';
import 'package:sync_biryani_web/provider/cart_provider.dart';
import 'package:sync_biryani_web/provider/coupon_provider.dart';
import 'package:sync_biryani_web/screens/login.dart';
import 'package:sync_biryani_web/screens/payment/razorpay/razor_pay_web.dart';
import 'package:sync_biryani_web/services/cart_service.dart';
import 'package:sync_biryani_web/services/comman_services.dart';
import 'package:sync_biryani_web/services/order_services.dart';
import 'package:sync_biryani_web/services/user_services.dart';
import 'package:sync_biryani_web/widgets/cart/cart_list.dart';
import 'package:sync_biryani_web/widgets/cart/cod_toggle.dart';
import 'package:sync_biryani_web/widgets/cart/coupon_widget.dart';
import 'package:sync_biryani_web/widgets/responsive.dart';
import 'package:toast/toast.dart';

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
  CommanServices _commanServices = CommanServices();
  User user = FirebaseAuth.instance.currentUser;

  var _addressTextController = TextEditingController();

  var _contactNumberTextController = TextEditingController();

  int deliveryFee = 50;
  double discount = 0;
  bool _visible = false;
  CommanServices _services = CommanServices();
  Geodesy geodesy = Geodesy();

  String _city = '';
  double _latitude = 0.0;
  double _longitude = 0.0;
  Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_62wBmqWXtrZhOd",
      "amount": textEditingController.text,
      "name": "Sample App",
      "description": "Payment Gateway for demo app",
      "prefill": {
        "contact": "8080036747",
        "email": "pranalipardeshi30@gmail.com",
        "external": {
          "wallet": ["paytm"]
        }
      }
    };
    try {
      print("razopay api called");
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlePaymentSuccess() {
    print('Payment SUccessful');
    EasyLoading.showSuccess('Payment Successfull');
    Navigator.pop(context);
  }

  void handlePaymentError() {
    print('Payment Error');
    EasyLoading.showError('Payment Failed');
  }

  void handleExternalWallet() {
    print('External Wallet');
    Toast.show("External Wallet", context);
  }

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
      color: Colors.grey[100],
      child: Container(
        width: Responsive.isDesktop(context)
            ? MediaQuery.of(context).size.width / 3.2
            : MediaQuery.of(context).size.width / 1.2,
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
                width: Responsive.isDesktop(context)
                    ? MediaQuery.of(context).size.width / 3.2
                    : MediaQuery.of(context).size.width / 1.2,
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
                        // width: MediaQuery.of(context).size.width / 3.5,
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
                        // height: 100,
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
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 8, right: 8, bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 30,
                                      child: TextField(
                                        enabled: false,
                                        textInputAction: TextInputAction.done,
                                        onSubmitted: (String city) {
                                          setState(() {
                                            _city = city;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          filled: true,
                                          fillColor: Colors.grey[300],
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          contentPadding:
                                              EdgeInsets.only(left: 10),
                                          hintText: _city.isEmpty
                                              ? "Check Availablity"
                                              : '$_city',
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  _city.isEmpty
                                      ? SizedBox(
                                          height: 30,
                                          child: MaterialButton(
                                            color: Colors.red,
                                            onPressed: () async {
                                              final _val = await LocationAPI()
                                                  .fetchData();
                                              setState(
                                                () {
                                                  _city = _val;
                                                },
                                              );
                                              getLat();
                                            },
                                            child: Text(
                                              'Get Location',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          height: 30,
                                          child: MaterialButton(
                                            color: Colors.lightGreen,
                                            onPressed: () {
                                              LatLng l2 =
                                                  LatLng(_latitude, _longitude);
                                              LatLng l1 =
                                                  LatLng(28.599365, 77.074882);
                                              num distance = (geodesy
                                                      .distanceBetweenTwoGeoPoints(
                                                          l1, l2)) /
                                                  1000;
                                              print('Distance From Store: ' +
                                                  distance.toStringAsFixed(2) +
                                                  ' Km');
                                              if (distance >= 10) {
                                                _services.showMyDialog(
                                                  title: 'Delivery Unavailable',
                                                  message:
                                                      'You Location is more than 10 km Please Try again after come in our delivery range',
                                                  context: context,
                                                );
                                              } else {
                                                setState(() {
                                                  _visible = true;
                                                });
                                              }
                                            },
                                            child: Text(
                                              'Check Availability',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: _visible,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Delivery Available Please Enter Details',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller:
                                            _contactNumberTextController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Contact Number',
                                          enabledBorder: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.green,
                                            ),
                                          ),
                                          focusColor: Colors.green,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    TextField(
                                      controller: _addressTextController,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Enter Address',
                                        enabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: Colors.green,
                                          ),
                                        ),
                                        focusColor: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                        EasyLoading.show(status: 'Please wait....');
                        _userService.getUserById(user.uid).then((value) {
                          if (value.name == null) {
                            EasyLoading.dismiss();
                            changeScreen(context, LoginPage());
                          } else {
                            EasyLoading.dismiss();

                            if (_city.isNotEmpty) {
                              if (_contactNumberTextController.text.length !=
                                  0) {
                                if (_addressTextController.text.length != 0) {
                                  if (_cartProvider.cod == false) {
                                    print('pay Online');
                                    // pay Online
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RazorPayWeb()));
                                  } else {
                                    // cash On delivery
                                    // _saveOrder(
                                    //     _cartProvider, _payable, _coupon);
                                    print('Cash on Delivery');
                                  }
                                } else {
                                  print('Please Enter Delivery Address');
                                  _commanServices.showMyDialog(
                                      context: context,
                                      message:
                                          'Please provide Delivery Address',
                                      title: 'Delivery Address');
                                }
                              } else {
                                print('Please provide Contact number');
                                _commanServices.showMyDialog(
                                    context: context,
                                    message: 'Please provide Contact number',
                                    title: 'Contact Number');
                              }
                            } else {
                              _commanServices.showMyDialog(
                                  context: context,
                                  message:
                                      'Please tap on get location and check delivery availability',
                                  title: 'Location Unknown');
                            }
                            // EasyLoading.show(status: 'Please Wait...');
                            // First check Payment type
                            // if (_cartProvider.cod == false) {
                            //   // pay Online
                            //   Navigator.pushNamed(
                            //       context, RazorpayPaymentScreen.id);
                            // } else {
                            //   // cash On delivery
                            //   _saveOrder(_cartProvider, _payable, _coupon);
                            // }
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
      'orderId': DateTime.now().microsecondsSinceEpoch.toString(),
      'products': cartProvider.cartList,
      'userId': user.uid,
      'contactNumber': _contactNumberTextController.text,
      'deliveryAddress': _addressTextController.text,
      'location': GeoPoint(this._latitude, this._longitude),
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
          _addressTextController.clear();
          _contactNumberTextController.clear();
          setState(() {
            _city = null;
          });
          EasyLoading.showSuccess('Your Order Is Submitted');
        });
      });
    });
  }

  void getLat() {
    getCurrentPosition(allowInterop((pos) {
      setState(() {
        _latitude = pos.coords.latitude;
        _longitude = pos.coords.longitude;
      });
      return;
    }));
  }

  void calculateDistance() {
    Geodesy geodesy = Geodesy();

    LatLng l1 = LatLng(28.599365, 77.074882);
    LatLng l2 = LatLng(_latitude, _longitude);

    num distance = geodesy.distanceBetweenTwoGeoPoints(l1, l2);
    print("Distance: " + (distance / 1000).toString());
    print(_latitude);
    print(_longitude);
  }
}
