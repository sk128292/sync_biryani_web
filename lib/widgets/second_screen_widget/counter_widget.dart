import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sync_biryani_web/services/cart_service.dart';

class CounterWidget extends StatefulWidget {
  final DocumentSnapshot snapshot;
  final String docId;
  final int unitQty;
  CounterWidget({this.snapshot, this.unitQty, this.docId});
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  CartService _cartService = CartService();

  int _unitQty;
  bool _updating = false;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _unitQty = widget.unitQty;
    });
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12),
      height: 45,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: FittedBox(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _updating = true;
                      _unitQty--;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.remove, color: Colors.red),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
                    child: _updating
                        ? Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor),
                            ),
                          )
                        : Text(_unitQty.toString(),
                            style: TextStyle(color: Colors.red)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _updating = true;
                      _unitQty++;
                    });
                    _cartService
                        .updateCartQty(widget.docId, _unitQty)
                        .then((value) {
                      setState(() {
                        _updating = false;
                      });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.add, color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
