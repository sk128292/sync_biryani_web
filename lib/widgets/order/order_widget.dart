import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_biryani_web/provider/order_provider.dart';
import 'package:sync_biryani_web/services/order_services.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatefulWidget {
  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  OrderServices _orderServices = OrderServices();
  User user = FirebaseAuth.instance.currentUser;

  int tag = 0;
  List<String> options = [
    'All Orders',
    'Ordered',
    'Accepted',
    'Picked Up',
    'on the way',
    'Delivered',
  ];

  @override
  Widget build(BuildContext context) {
    var _orderProvider = Provider.of<OrderProvider>(context);
    return Column(
      children: [
        Container(
          height: 70,
          child: ChipsChoice<int>.single(
            choiceStyle: C2ChoiceStyle(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            value: tag,
            onChanged: (val) {
              if (val == 0) {
                setState(() {
                  _orderProvider.status = null;
                });
              }
              setState(() {
                tag = val;
                _orderProvider.status = options[val];
              });
            },
            choiceItems: C2Choice.listFrom<int, String>(
              source: options,
              value: (i, v) => i,
              label: (i, v) => v,
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.grey[300],
            child: StreamBuilder<QuerySnapshot>(
              stream: _orderServices.orders
                  .where('userId', isEqualTo: user.uid)
                  .where('orderStatus',
                      isEqualTo: tag > 0 ? _orderProvider.status : null)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.data.size == 0) {
                  return Center(
                    child: Text(tag > 0
                        ? 'No ${options[tag]} Orders'
                        : 'No Orders yet, Continue Shoping'),
                  );
                }

                return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 14,
                              child: _orderServices.statusIcon(document),
                            ),
                            title: Text(
                              document.data()['orderStatus'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _orderServices.statusColor(document),
                              ),
                            ),
                            subtitle: Text(
                              'on ' +
                                  DateFormat.yMMMd().format(
                                    DateTime.parse(
                                        document.data()['timeStamp']),
                                  ),
                            ),
                            trailing: Column(
                              children: [
                                Text(
                                  'Payment Type: ' +
                                      (document.data()['cod'] == true
                                          ? ' Cash on Delivery'
                                          : ' Paid Online'),
                                ),
                                Text(
                                  'Amount Rs. ' +
                                      document
                                          .data()['totalPayable']
                                          .toStringAsFixed(0),
                                ),
                              ],
                            ),
                          ),
                          //  Delivery boy Contact

                          if (document.data()['deliveryBoy']['image'] != null)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: ListTile(
                                tileColor: Colors.grey[300],
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Image.network(
                                    document
                                        .data()['deliveryBoy']['image']
                                        .toString(),
                                  ),
                                ),
                                title: Text(
                                    document.data()['deliveryBoy']['name']),
                                subtitle: Text(
                                  _orderServices.statusComment(document),
                                ),
                              ),
                            ),
                          ExpansionTile(
                            title: Text(
                              'Order Details',
                              style: TextStyle(color: Colors.black),
                            ),
                            subtitle: Text(
                              'View Order Details',
                              style: TextStyle(color: Colors.grey),
                            ),
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: document.data()['products'].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text(document.data()['products']
                                        [index]['name']),
                                    subtitle: Text(
                                        '${document.data()['products'][index]['unitQty']} x  ${document.data()['products'][index]['price'].toStringAsFixed(0)} = ${document.data()['products'][index]['total'].toStringAsFixed(0)}'),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 5,
                                  color: Colors.blueGrey.withOpacity(.2),
                                  child: Column(
                                    children: [
                                      if (int.parse(
                                              document.data()['discount']) >
                                          0)
                                        Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Discount: ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(document
                                                      .data()['discount'])
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Text(
                                                    'DiscountCode: ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(document
                                                      .data()['discountCoupon'])
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            'Delivery Fee: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(document
                                              .data()['deliveryFee']
                                              .toString())
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
