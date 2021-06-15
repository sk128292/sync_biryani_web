import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sync_biryani_web/services/cart_service.dart';
import 'package:sync_biryani_web/widgets/second_screen_widget/add_to_cart_widget.dart';

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
  bool _exists = true;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _unitQty = widget.unitQty;
    });

    return _exists
        ? Container(
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.pink),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _updating = true;
                    });
                    if (_unitQty == 1) {
                      _cartService.removeFromCart(widget.docId).then((value) {
                        setState(() {
                          _updating = false;
                          _exists = false;
                        });
                        // need to check after remove
                        _cartService.checkData();
                      });
                    }
                    if (_unitQty > 1) {
                      setState(() {
                        _unitQty--;
                      });
                      var total = _unitQty * widget.snapshot.data()['price'];
                      _cartService
                          .updateCartQty(widget.docId, _unitQty, total)
                          .then((value) {
                        setState(() {
                          _updating = false;
                        });
                      });
                    }
                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 3, right: 3),
                      child: _unitQty == 1
                          ? Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            )
                          : Icon(Icons.remove, color: Colors.red),
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: 32,
                  color: Colors.pink,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, top: 3),
                    child: _updating
                        ? Container(
                            height: 12,
                            width: 15,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor),
                            ),
                          )
                        : Text(_unitQty.toString(),
                            style: TextStyle(color: Colors.white)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _updating = true;
                      _unitQty++;
                    });
                    var total = _unitQty * widget.snapshot.data()['price'];
                    _cartService
                        .updateCartQty(widget.docId, _unitQty, total)
                        .then((value) {
                      setState(() {
                        _updating = false;
                      });
                    });
                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 3, right: 3),
                      child: Icon(Icons.add, color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          )
        : AddToCartWidget(widget.snapshot);
  }
}
