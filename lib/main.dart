import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sync_biryani_web/provider/app_provider.dart';
import 'package:sync_biryani_web/provider/cart_provider.dart';
import 'package:sync_biryani_web/provider/category_provider.dart';
import 'package:sync_biryani_web/provider/coupon_provider.dart';
import 'package:sync_biryani_web/provider/order_provider.dart';
import 'package:sync_biryani_web/provider/product_provider.dart';
import 'package:sync_biryani_web/provider/user_provider.dart';
import 'package:sync_biryani_web/screens/home_page.dart';
import 'package:sync_biryani_web/screens/login.dart';
import 'package:sync_biryani_web/screens/product_page.dart';
import 'package:sync_biryani_web/screens/profile_screen.dart';
import 'package:sync_biryani_web/screens/registration.dart';
import 'package:sync_biryani_web/screens/second_screen/second_page.dart';
import 'package:sync_biryani_web/widgets/loading.dart';
import 'package:sync_biryani_web/widgets/profile/profile_update_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        ChangeNotifierProvider.value(value: CartProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
        ChangeNotifierProvider.value(value: CouponProvider.initialize()),
        ChangeNotifierProvider.value(value: OrderProvider.initialize()),
      ],
      child: MaterialApp(
        title: 'Synchrotron Biryani',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: ScreenController.id,
        routes: {
          MyHomePage.id: (context) => MyHomePage(),
          LoginPage.id: (context) => LoginPage(),
          Items.id: (context) => Items(),
          Registration.id: (context) => Registration(),
          ProductScreen.id: (context) => ProductScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          ProfileUpdateWidget.id: (context) => ProfileUpdateWidget(),
          ScreenController.id: (context) => ScreenController(),
          // RazorpayPaymentScreen.id: (context) => RazorpayPaymentScreen(),
        },
        builder: EasyLoading.init(),
      ),
    ),
  );
}

class ScreenController extends StatelessWidget {
  static const String id = 'screenController-screen';
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginPage();
      case Status.Authenticated:
        return MyHomePage();
      default:
        return LoginPage();
    }
  }
}
