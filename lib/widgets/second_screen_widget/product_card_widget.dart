import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:sync_biryani_web/widgets/second_screen_widget/add_to_cart_widget.dart';

class ProductCard extends StatelessWidget {
  final DocumentSnapshot documnet;
  ProductCard(this.documnet);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 5.8,
                  height: MediaQuery.of(context).size.width / 7,
                  child: Material(
                    elevation: 5,
                    child: Image.network(
                      documnet.data()['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3.7,
                  height: MediaQuery.of(context).size.width / 7,
                  // color: Colors.lightBlue,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(documnet.data()['category'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[700],
                              fontSize: MediaQuery.of(context).size.width / 70,
                            )),
                        RichText(
                          text: TextSpan(
                            text: documnet.data()['name'],
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 85,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ReadMoreText(
                          documnet.data()['description'],
                          // trimLength: 2,
                          trimLength: 120,
                          trimMode: TrimMode.Length,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 90,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rs: " + (documnet.data()['price'].toString()),
                              style: TextStyle(
                                color: Colors.orange[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Qty: " + (documnet.data()['unitQty'].toString()),
                              style: TextStyle(
                                color: Colors.orange[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            AddToCartWidget(documnet)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width / 3.7,
                //   height: MediaQuery.of(context).size.width / 7,
                //   alignment: Alignment.center,
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 10, right: 10),
                //     child: Column(
                //       // mainAxisSize: MainAxisSize.min,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           child: Column(
                //             children: [
                //               Text(documnet.data()['category']),
                //               SizedBox(height: 6),
                //               Text(documnet.data()['name']),
                //               SizedBox(height: 6),
                //               Text(documnet.data()['description']),
                //               SizedBox(height: 6),
                //               Row(
                //                 children: [
                //                   Text(documnet.data()['price']),
                //                   Text(documnet.data()['unitQty'].toString()),
                //                 ],
                //               ),
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.end,
                //                 children: [
                //                   Container(
                //                     width: 200,
                //                     child: Row(
                //                       mainAxisAlignment: MainAxisAlignment.end,
                //                       children: [
                //                         Card(
                //                           color: Colors.pink,
                //                           child: Padding(
                //                             padding: const EdgeInsets.only(
                //                                 left: 30,
                //                                 right: 30,
                //                                 top: 7,
                //                                 bottom: 7),
                //                             child: AddToCartWidget(documnet),
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Divider(height: 5),
        ],
      ),
    );
  }
}
