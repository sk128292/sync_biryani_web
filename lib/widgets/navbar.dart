import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_biryani_web/helpers/screen_navigation.dart';
import 'package:sync_biryani_web/main.dart';
import 'package:sync_biryani_web/provider/user_provider.dart';
import 'package:sync_biryani_web/screens/login.dart';
import 'package:sync_biryani_web/widgets/menuItem.dart';
import 'package:sync_biryani_web/widgets/responsive.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    // final app = Provider.of<AppProvider>(context);
    final authProvider = Provider.of<UserProvider>(context);
    return Responsive.isDesktop(context)
        ? Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -2),
                  blurRadius: 30,
                  color: Colors.black.withOpacity(0.16),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width / 40,

                  width: MediaQuery.of(context).size.width / 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("images/a.jpg"),
                    ),
                  ),
                  // child: Image.asset(
                  //   "images/a.jpg",
                  //   height: 25,
                  //   alignment: Alignment.topCenter,
                  // ),
                ),
                SizedBox(width: 5),
                Text(
                  "S.F.".toUpperCase(),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                MenuItem(
                  title: "Home",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                      ),
                    );
                  },
                ),
                MenuItem(
                  title: "about",
                  press: () {},
                ),
                MenuItem(
                  title: "Pricing",
                  press: () {},
                ),
                MenuItem(
                  title: "LogOut",
                  press: () async {
                    await user.signOut();
                    changeScreen(context, LoginPage());
                  },
                ),
                MenuItem(
                  title: authProvider.userModel?.name ?? "name loading...",
                  press: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => LoginPage(),
                    //   ),
                    // );
                  },
                ),
                // DefaultButton(
                //   text: "Get Started",
                //   press: () {},
                // ),
              ],
            ),
          )
        // Container(
        //     // color: Color.fromRGBO(160, 10, 90, 1.0),
        //     constraints: BoxConstraints(maxWidth: double.infinity),
        //     child: Padding(
        //       padding: const EdgeInsets.all(15),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text(
        //             "Synchrotron",
        //             style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               fontSize: 28,
        //               color: Colors.black,
        //             ),
        //           ),
        //           Row(
        //             children: [
        //               GestureDetector(
        //                 onTap: () {
        //                   Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) => MyHomePage()));
        //                 },
        //                 child: Text(
        //                   "Home",
        //                   style: TextStyle(
        //                     fontSize: 20,
        //                     color: Colors.black,
        //                   ),
        //                 ),
        //               ),
        //               SizedBox(
        //                 width: 30,
        //               ),
        //               Text(
        //                 "About",
        //                 style: TextStyle(
        //                   fontSize: 20,
        //                   color: Colors.black,
        //                 ),
        //               ),
        //               SizedBox(
        //                 width: 30,
        //               ),
        //               Text(
        //                 "Login",
        //                 style: TextStyle(
        //                   fontSize: 20,
        //                   color: Colors.black,
        //                 ),
        //               ),
        //             ],
        //           )
        //         ],
        //       ),
        //     ),
        //   )
        : Container(
            child: Text("This is mobile view"),
          );
  }
}
