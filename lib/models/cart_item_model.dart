class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const PRODUCT_ID = "productId";
  static const QTY = "qty";
  static const PRICE = "price";

  int _id;
  String _name;
  int _productId;
  int _qty;
  int _price;

  // getter

  int get id => _id;
  String get name => _name;
  int get productId => _productId;
  int get qty => _qty;
  int get price => _price;

  CartItemModel.fromMap(Map data) {
    _id = data[ID];
    _name = data[NAME];
    _productId = data[PRODUCT_ID];
    _qty = data[QTY];
    _price = data[PRICE];
  }

  Map toMap() => {
        ID: _id,
        NAME: _name,
        PRODUCT_ID: _productId,
        QTY: _qty,
        PRICE: _price,
      };
}
