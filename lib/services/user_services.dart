import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sync_biryani_web/models/user_model.dart';

class UserServices {
  String collection = "users";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createUser(Map<String, dynamic> values) {
    String id = values["id"];
    _firestore.collection(collection).doc(id).set(values);
  }

  void updateUserData(Map<String, dynamic> values) {
    _firestore.collection(collection).doc(values["id"]).update(values);
  }

  void addToCart({String userId, Map cartItem}) {
    print("The User Id is : $userId");
    print("Cart Items are : ${cartItem.toString()}");
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem]),
    });
  }

  void removeFromCart({String userId, Map cartItem}) {
    print("The User Id is : $userId");
    print("Cart Items are : ${cartItem.toString()}");
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem]),
    });
  }

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).doc(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });
}
