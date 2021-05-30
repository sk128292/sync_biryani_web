import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sync_biryani_web/services/order_services.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OrderServices _orderServices = OrderServices();
    User user = FirebaseAuth.instance.currentUser;
    return Container(
      color: Colors.grey[300],
      child: StreamBuilder<QuerySnapshot>(
        stream: _orderServices.orders
            .where('userId', isEqualTo: user.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text('No Orders yet, Continue Shoping'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 14,
                          child: Icon(CupertinoIcons.square_list),
                        ),
                        title: Text(document.data()['orderStatus']),
                        subtitle: Text(
                          'on ' +
                              DateFormat.yMMMd().format(
                                DateTime.parse(document.data()['timeStamp']),
                              ),
                        ),
                        trailing: Text('Amount Rs. ' +
                            document.data()['totalPayable'].toStringAsFixed(0)),
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
                                  title: Text(document.data()['products'][index]
                                      ['name']),
                                  subtitle: Text(
                                      '${document.data()['products'][index]['unitQty']} x  ${document.data()['products'][index]['price'].toStringAsFixed(0)} = ${document.data()['products'][index]['total'].toStringAsFixed(0)}'),
                                );
                              }),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
