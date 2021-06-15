// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/credit_card_widget.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:stripe_payment/stripe_payment.dart';
// import 'package:sync_biryani_web/services/payment/stripe_payment_services.dart';

// class ExistingCardsPage extends StatefulWidget {
//   static const String id = 'existing-cards';
//   ExistingCardsPage({Key key}) : super(key: key);

//   @override
//   ExistingCardsPageState createState() => ExistingCardsPageState();
// }

// class ExistingCardsPageState extends State<ExistingCardsPage> {
//   List cards = [
//     {
//       'cardNumber': '4242424242424242',
//       'expiryDate': '04/24',
//       'cardHolderName': 'Muhammad Ahsan Ayaz',
//       'cvvCode': '424',
//       'showBackView': false,
//     },
//     {
//       'cardNumber': '5555555566554444',
//       'expiryDate': '04/23',
//       'cardHolderName': 'Tracer',
//       'cvvCode': '123',
//       'showBackView': false,
//     }
//   ];

//   payViaExistingCard(BuildContext context, card) async {
//     await EasyLoading.show(status: 'Please Wait...');
//     var expiryArr = card['expiryDate'].split('/');
//     CreditCard stripeCard = CreditCard(
//       number: card['cardNumber'],
//       expMonth: int.parse(expiryArr[0]),
//       expYear: int.parse(expiryArr[1]),
//     );
//     var response = await StripeService.payViaExistingCard(
//         amount: '2500', currency: 'USD', card: stripeCard);
//     await EasyLoading.dismiss();
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(
//           content: Text(response.message),
//           duration: new Duration(milliseconds: 1200),
//         ))
//         .closed
//         .then((_) {
//       Navigator.pop(context);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Choose existing card'),
//       ),
//       body: Container(
//         width: 500,
//         color: Colors.blueGrey,
//         padding: EdgeInsets.all(20),
//         child: ListView.builder(
//           itemCount: cards.length,
//           itemBuilder: (BuildContext context, int index) {
//             var card = cards[index];
//             return InkWell(
//               onTap: () {
//                 payViaExistingCard(context, card);
//               },
//               child: CreditCardWidget(
//                 cardNumber: card['cardNumber'],
//                 expiryDate: card['expiryDate'],
//                 cardHolderName: card['cardHolderName'],
//                 cvvCode: card['cvvCode'],
//                 showBackView: false,
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
