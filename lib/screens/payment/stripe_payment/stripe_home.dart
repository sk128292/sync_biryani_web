// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:sync_biryani_web/screens/payment/stripe_payment/existing-cards.dart';
// import 'package:sync_biryani_web/services/payment/stripe_payment_services.dart';

// class StripeHome extends StatefulWidget {
//   static const String id = 'stripe-home';
//   StripeHome({Key key}) : super(key: key);

//   @override
//   StripeHomeState createState() => StripeHomeState();
// }

// class StripeHomeState extends State<StripeHome> {
//   onItemPress(BuildContext context, int index) async {
//     switch (index) {
//       case 0:
//         payViaNewCard(context);
//         break;
//       case 1:
//         Navigator.pushNamed(context, ExistingCardsPage.id);
//         break;
//     }
//   }

//   payViaNewCard(BuildContext context) async {
//     await EasyLoading.show(status: 'Please Wait....');
//     var response =
//         await StripeService.payWithNewCard(amount: '15000', currency: 'USD');
//     await EasyLoading.dismiss();
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(response.message),
//       duration:
//           new Duration(milliseconds: response.success == true ? 1200 : 3000),
//     ));
//   }

//   @override
//   void initState() {
//     super.initState();
//     StripeService.init();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(20),
//             child: ListView.separated(
//                 itemBuilder: (context, index) {
//                   Icon icon;
//                   Text text;

//                   switch (index) {
//                     case 0:
//                       icon = Icon(Icons.add_circle, color: theme.primaryColor);
//                       text = Text('Pay via new card');
//                       break;
//                     case 1:
//                       icon = Icon(Icons.credit_card, color: theme.primaryColor);
//                       text = Text('Pay via existing card');
//                       break;
//                   }

//                   return InkWell(
//                     onTap: () {
//                       onItemPress(context, index);
//                     },
//                     child: ListTile(
//                       title: text,
//                       leading: icon,
//                     ),
//                   );
//                 },
//                 separatorBuilder: (context, index) => Divider(
//                       color: theme.primaryColor,
//                     ),
//                 itemCount: 2),
//           ),
//         ],
//       ),
//     );
//     ;
//   }
// }
