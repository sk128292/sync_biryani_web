// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
// ignore: unused_import
import 'dart:ui' as ui;
//conditional import
import 'package:sync_biryani_web/screens/payment/razorpay/ui_fake.dart'
    if (dart.library.html) 'dart:ui' as ui;
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
String razorpay_key = "rzp_test_Tu5Bvpcye1aPrh";
String amount = "1000";

class RazorPayWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //register view factory
    ui.platformViewRegistry.registerViewFactory("rzp-html", (int viewId) {
      IFrameElement element = IFrameElement();
//Event Listener
      window.onMessage.forEach((element) {
        print('Event Received in callback: ${element.data}');
        if (element.data == 'MODAL_CLOSED') {
          Navigator.pop(context);
        } else if (element.data == 'SUCCESS') {
          print('PAYMENT SUCCESSFULL!!!!!!!');
          Navigator.pop(context);
        }
        print(element.data);
      });

      element.requestFullscreen();
      element.src = 'https://fwrzp.netlify.app/payment.html?amt=' +
          amount +
          '&rpay_key=' +
          razorpay_key;
      element.allowPaymentRequest = true;
      element.style.border = 'none';
      print(element.attributes);
      return element;
    });
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return Container(
        child: HtmlElementView(viewType: 'rzp-html'),
      );
    }));
  }
}
