import 'dart:html';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_biryani_web/provider/coupon_provider.dart';

class CouponWidget extends StatefulWidget {
  @override
  _CouponWidgetState createState() => _CouponWidgetState();
}

class _CouponWidgetState extends State<CouponWidget> {
  Color color = Colors.grey;
  bool _enable = false;
  bool _visible = false;

  var _couponText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _coupon = Provider.of<CouponProvider>(context);
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 20, bottom: 15),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: TextField(
                      controller: _couponText,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[300],
                        hintText: 'Coupon Code',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                      onChanged: (String value) {
                        if (value.length < 3) {
                          setState(() {
                            color = Colors.grey;
                            _enable = false;
                          });
                        }
                        if (value.isNotEmpty) {
                          setState(() {
                            color = Colors.green;
                            _enable = true;
                          });
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: AbsorbPointer(
                    absorbing: _enable ? false : true,
                    child: MaterialButton(
                      color: color,
                      onPressed: () {
                        _coupon
                            .getCouponDetails(_couponText.text)
                            .then((value) {
                          if (value.data() == null) {
                            setState(() {
                              _coupon.discountRate = 0;
                              _visible = false;
                            });
                            showDialoge(_couponText.text, 'Not Valid');
                            return;
                          }
                          if (_coupon.expired == false) {
                            setState(() {
                              _visible = true;
                            });
                            return;
                          }
                          if (_coupon.expired == true) {
                            setState(() {
                              _coupon.discountRate = 0;
                              _visible = false;
                            });
                            showDialoge(_couponText.text, 'Expired');
                          }
                        });
                        print(_coupon.document.data()['title']);
                      },
                      child: Text(
                        'Apply',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: _visible,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DottedBorder(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.deepOrangeAccent.withOpacity(.4),
                        ),
                        width: MediaQuery.of(context).size.width / 4.5,
                        // height: 60,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                  _coupon.document.data()['title'].toString()),
                            ),
                            Divider(color: Colors.grey),
                            Text('New year Special Discount'),
                            Text('20% discount on total order'),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Positioned(
                        right: -5,
                        top: -5,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.clear),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showDialoge(code, validity) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Apply Coupon'),
            content: Text(
                'This Discount Coupon $code you have entered is $validity. Please try with another Code'),
            actions: [
              MaterialButton(
                color: Colors.green,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }
}
