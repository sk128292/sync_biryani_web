import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_biryani_web/helpers/commans.dart';
import 'package:sync_biryani_web/helpers/screen_navigation.dart';
import 'package:sync_biryani_web/provider/user_provider.dart';
import 'package:sync_biryani_web/screens/home_page.dart';
import 'package:sync_biryani_web/screens/login.dart';
import 'package:sync_biryani_web/widgets/custom_text.dart';

class SynchDrawer extends StatefulWidget {
  @override
  _SynchDrawerState createState() => _SynchDrawerState();
}

class _SynchDrawerState extends State<SynchDrawer> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    // final app = Provider.of<AppProvider>(context);
    final authProvider = Provider.of<UserProvider>(context);
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
            decoration: BoxDecoration(
              color: Colors.lightBlue,
            ),
            child: Column(
              children: [
                CustomText(
                  text: "Welcome You!..",
                  colors: white,
                  weight: FontWeight.bold,
                  size: 22,
                ),
                SizedBox(height: 40),
                CustomText(
                  text: authProvider.userModel?.name ?? "username loading...",
                  colors: black,
                  weight: FontWeight.bold,
                  size: 18,
                ),
                CustomText(
                  text: authProvider.userModel?.email ?? "email loading...",
                  colors: white,
                  weight: FontWeight.bold,
                ),
              ],
            ),
            // accountName: CustomText(
            //   text: authProvider.userModel?.name ?? "username loading...",
            //   colors: black,
            //   weight: FontWeight.bold,
            //   size: 18,
            // ),
            // accountEmail: CustomText(
            //   text: authProvider.userModel?.email ?? "email loading...",
            //   colors: white,
            //   weight: FontWeight.bold,
            // ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
            leading: Icon(Icons.home),
            title: CustomText(text: "Home", align: TextAlign.left),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.person),
            title: CustomText(text: "Account", align: TextAlign.left),
          ),
          ListTile(
            onTap: () {
              // changeScreen(context, CartScreen());
            },
            leading: Icon(Icons.shopping_cart),
            title: CustomText(text: "Cart", align: TextAlign.left),
          ),
          ListTile(
            onTap: () async {
              // await user.getOrders();
              // changeScreen(context, OrderScreen());
            },
            leading: Icon(Icons.bookmark_border),
            title: CustomText(text: "My Order", align: TextAlign.left),
          ),
          ListTile(
            onTap: () async {
              await user.signOut();
              changeScreen(context, LoginPage());
            },
            leading: Icon(Icons.logout),
            title: CustomText(text: "Log Out", align: TextAlign.left),
          ),
        ],
      ),

      // Container(
      //   color: Colors.black,
      //   child: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         Center(
      //           child: Text(
      //             " Welcome to You!...",
      //             style: TextStyle(
      //               fontSize: 25,
      //               color: Colors.blue,
      //             ),
      //           ),
      //         ),
      //         SizedBox(height: 20),
      //         Center(
      //           child: Text(
      //             authProvider.userModel?.name ?? "name loading...",
      //             style: TextStyle(
      //               fontSize: 20,
      //               color: Colors.white70,
      //             ),
      //           ),
      //         ),
      //         SizedBox(height: 40),
      //         InkWell(
      //           onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => MyHomePage(),
      //               ),
      //             );
      //           },
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               Icon(
      //                 Icons.home,
      //                 color: Colors.red,
      //               ),
      //               Text(
      //                 'Home',
      //                 style: TextStyle(color: Colors.white, fontSize: 17),
      //               ),
      //             ],
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      //           child: Divider(
      //             color: Colors.blueGrey[400],
      //             thickness: 1,
      //           ),
      //         ),
      //         InkWell(
      //           onTap: () {},
      //           child: Text(
      //             'Contact Us',
      //             style: TextStyle(color: Colors.white, fontSize: 17),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      //           child: Divider(
      //             color: Colors.blueGrey[400],
      //             thickness: 1,
      //           ),
      //         ),
      //         InkWell(
      //           onTap: () {},
      //           child: Text(
      //             'My Order',
      //             style: TextStyle(color: Colors.white, fontSize: 17),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      //           child: Divider(
      //             color: Colors.blueGrey[400],
      //             thickness: 1,
      //           ),
      //         ),
      //         InkWell(
      //           onTap: () {},
      //           child: Text(
      //             'Cart',
      //             style: TextStyle(color: Colors.white, fontSize: 17),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      //           child: Divider(
      //             color: Colors.blueGrey[400],
      //             thickness: 1,
      //           ),
      //         ),
      //         InkWell(
      //           onTap: () async {
      //             await user.signOut();
      //             changeScreen(context, LoginPage());
      //           },
      //           child: Text(
      //             'Sign Out',
      //             style: TextStyle(color: Colors.white, fontSize: 17),
      //           ),
      //         ),
      //         Expanded(
      //           child: Align(
      //             alignment: Alignment.bottomCenter,
      //             child: Text(
      //               'Copyright © 2020 | Synchrotron Biryani',
      //               style: TextStyle(
      //                 color: Colors.blueGrey[300],
      //                 fontSize: 12,
      //               ),
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
