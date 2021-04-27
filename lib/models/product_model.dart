import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const CATEGORY = "category";
  static const DESCRIPTION = "description";
  static const AVAILABLE = "available";
  static const QTY = "qty";

  int _id;
  String _name;
  String _image;
  String _price;
  String _category;
  String _description;
  bool _available;
  int _qty;

  // getter

  int get id => _id;
  String get name => _name;
  String get image => _image;
  String get category => _category;
  String get description => _description;
  String get price => _price;
  int get qty => _qty;
  bool get featured => _available;

  // bool featured = _featured;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[id];
    _name = snapshot.data()[NAME];
    _image = snapshot.data()[IMAGE];
    _category = snapshot.data()[CATEGORY];
    _description = snapshot.data()[DESCRIPTION];
    _price = snapshot.data()[PRICE];
    _qty = snapshot.data()[QTY];
    _available = snapshot.data()[AVAILABLE];
  }
}
