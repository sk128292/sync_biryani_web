import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sync_biryani_web/models/order_model.dart';

class OrderServices {
  String collection = "orders";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createOrder(
      {String userId,
      String id,
      String description,
      String status,
      List cart,
      int totalAmount}) {
    _firestore.collection(collection).doc(id).set({
      "userId": userId,
      "id": id,
      "description": description,
      "cart": cart,
      "totalAmount": totalAmount,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "status": status
    });
  }

  Future<List<OrderModel>> getUserOrders({String userId}) async => _firestore
          .collection(collection)
          .where("userid", isEqualTo: userId)
          .get()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.docs) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });
}
