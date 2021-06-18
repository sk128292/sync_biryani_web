@JS()
library stripe;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:js/js.dart';

void redirectToCheckout(BuildContext context) async {
  final stripe = Stripe('pk_test_TYooMQauvdEDq54NiTphI7jx');
  stripe.redirectToCkeckout(CheckoutOptions(
    lineItems: [LineItem(price: '200', qty: 1)],
    mode: 'Payment',
    successUrl: 'http://localhost:8080/#/success',
    cancleUrl: 'http://localhost:8080/#/cancle',
  ));
}

@JS()
class Stripe {
  external Stripe(String key);

  external redirectToCkeckout(CheckoutOptions options);
}

@JS()
@anonymous
class CheckoutOptions {
  external List<LineItem> get lineItems;

  external String get mode;
  external String get successUrl;
  external String get cancleUrl;
  external String get sessionId;

  external factory CheckoutOptions({
    List<LineItem> lineItems,
    String mode,
    String successUrl,
    String cancleUrl,
    String sessionId,
  });
}

@JS()
@anonymous
class LineItem {
  external String get price;
  external int get qty;

  external factory LineItem({String price, int qty});
}
