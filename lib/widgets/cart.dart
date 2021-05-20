import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_biryani_web/provider/app_provider.dart';
import 'package:sync_biryani_web/provider/user_provider.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Card(
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
                  Text("Items " + user.userModel.cart.length.toString()),
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
            user.userModel.cart.length != 0
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: user.userModel.cart.length,
                    itemBuilder: (_, index) {
                      print(
                          'The Price is : ${user.userModel.cart[index]["price"].toString()}');
                      return Column(
                        children: [
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 8, right: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: user.userModel.cart[index]
                                                    ["name"],
                                                // "Hyderabadi Dum Gosht [Mutton Biryani, Boneless - Serves 1]",
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          85,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "kg" +
                                                      " X " +
                                                      user
                                                          .userModel
                                                          .cart[index]
                                                              ["unitQty"]
                                                          .toString(),
                                                ),
                                                SizedBox(
                                                  width: 40,
                                                ),
                                                Text(
                                                  "Rs: " +
                                                      (user.userModel
                                                                  .cart[index]
                                                              ["price"])
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.orange[700],
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(
                                          Icons.remove_circle,
                                          color: Colors.orange[500],
                                        ),
                                        onPressed: () async {
                                          app.changeLoading();
                                          bool value =
                                              await user.removeFromCart(
                                                  cartItem: user
                                                      .userModel.cart[index]);
                                          if (value) {
                                            user.reloadUserModel();
                                            print("Item Added to cart");
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text("Removed from Cart"),
                                                duration: Duration(seconds: 1),
                                              ),
                                            );
                                            user.reloadUserModel();
                                            app.changeLoading();
                                            return;
                                          } else {
                                            print("Item was not removed");
                                            app.changeLoading();
                                          }
                                        },
                                      ),
                                      Text(2.toString()),
                                      IconButton(
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: Colors.orange[500],
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.width / 80,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Rs: " + (200 * 2).toString(),
                                        style: TextStyle(
                                            color: Colors.orange[700],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(),
                          ),
                        ],
                      );
                    })
                : Container(
                    height: 300,
                    child: Center(
                      child: Text("Your Cart Is Empty"),
                    ),
                  ),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: Container(
            //         padding: EdgeInsets.only(left: 8, right: 5),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>[
            //             Container(
            //               width: MediaQuery.of(context).size.width / 6,
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   RichText(
            //                     text: TextSpan(
            //                       text:
            //                           "Hyderabadi Dum Gosht [Mutton Biryani, Boneless - Serves 1]",
            //                       style: TextStyle(
            //                         fontSize:
            //                             MediaQuery.of(context).size.width / 85,
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     height: 10,
            //                   ),
            //                   Row(
            //                     children: <Widget>[
            //                       Text(
            //                         "kg" + " X " + "2",
            //                       ),
            //                       SizedBox(
            //                         width: 40,
            //                       ),
            //                       Text("Rs: " + (200 * 2).toString(),
            //                           style: TextStyle(
            //                               color: Colors.orange[700],
            //                               fontWeight: FontWeight.bold)),
            //                     ],
            //                   ),
            //                   SizedBox(
            //                     height: 10,
            //                   ),
            //                 ],
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Row(
            //           children: <Widget>[
            //             IconButton(
            //                 icon: Icon(
            //                   Icons.remove_circle,
            //                   color: Colors.orange[500],
            //                 ),
            //                 onPressed: () {}),
            //             Text(2.toString()),
            //             IconButton(
            //               icon: Icon(
            //                 Icons.add_circle,
            //                 color: Colors.orange[500],
            //               ),
            //               onPressed: () {},
            //             ),
            //           ],
            //         ),
            //         SizedBox(
            //           height: MediaQuery.of(context).size.width / 80,
            //         ),
            //         Row(
            //           children: [
            //             Text(
            //               "Rs: " + (200 * 2).toString(),
            //               style: TextStyle(
            //                   color: Colors.orange[700],
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Divider(),
            // ),
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
                      "Total: Rs. " + 400.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      color: Colors.green[500],
                      onPressed: () {},
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
}
