import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_biryani_web/helpers/screen_navigation.dart';
import 'package:sync_biryani_web/provider/user_provider.dart';
import 'package:sync_biryani_web/screens/home_page.dart';
import 'package:sync_biryani_web/screens/login.dart';

class TopBarContent extends StatefulWidget {
  @override
  _TopBarContentState createState() => _TopBarContentState();
}

class _TopBarContentState extends State<TopBarContent> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  // bool _isProcessing = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    // final app = Provider.of<AppProvider>(context);
    final authProvider = Provider.of<UserProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color: Colors.black.withOpacity(0.6),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'SF Biryani',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: screenSize.width / 8),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[0] = true
                              : _isHovering[0] = false;
                        });
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Home',
                            style: TextStyle(
                              color: _isHovering[0]
                                  ? Colors.blue[200]
                                  : Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[0],
                            child: Container(
                              height: 2,
                              width: 30,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 30),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[1] = true
                              : _isHovering[1] = false;
                        });
                      },
                      onTap: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Contact Us',
                            style: TextStyle(
                              color: _isHovering[1]
                                  ? Colors.blue[200]
                                  : Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[1],
                            child: Container(
                              height: 2,
                              width: 30,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 30),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[2] = true
                              : _isHovering[2] = false;
                        });
                      },
                      onTap: () async {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            authProvider.userModel?.name ?? "name loading...",
                            style: TextStyle(
                              color: _isHovering[2]
                                  ? Colors.blue[200]
                                  : Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[2],
                            child: Container(
                              height: 2,
                              width: 30,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 30),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[3] = true
                              : _isHovering[3] = false;
                        });
                      },
                      onTap: () async {
                        await user.signOut();
                        changeScreen(context, LoginPage());
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Sign Out',
                            style: TextStyle(
                              color: _isHovering[3]
                                  ? Colors.blue[200]
                                  : Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[3],
                            child: Container(
                              height: 2,
                              width: 30,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // IconButton(
              //   icon: Icon(Icons.brightness_6),
              //   splashColor: Colors.transparent,
              //   highlightColor: Colors.transparent,
              //   color: Colors.white,
              //   onPressed: () {},
              // ),
              // SizedBox(
              //   width: screenSize.width / 50,
              // ),
              // InkWell(
              //     onHover: (value) {
              //       setState(() {
              //         value ? _isHovering[3] = true : _isHovering[3] = false;
              //       });
              //     },
              //     onTap: () {},
              //     child: Text(
              //       'Sign in',
              //       style: TextStyle(
              //         color: _isHovering[3] ? Colors.white : Colors.white70,
              //       ),
              //     )
              // : Row(
              //     children: [
              //       CircleAvatar(
              //         radius: 15,
              //         backgroundImage: imageUrl != null
              //             ? NetworkImage(imageUrl!)
              //             : null,
              //         child: imageUrl == null
              //             ? Icon(
              //                 Icons.account_circle,
              //                 size: 30,
              //               )
              //             : Container(),
              //       ),
              //       SizedBox(width: 5),
              //       Text(
              //         name ?? userEmail!,
              //         style: TextStyle(
              //           color: _isHovering[3]
              //               ? Colors.white
              //               : Colors.white70,
              //         ),
              //       ),
              //       SizedBox(width: 10),
              //       TextButton(
              //         style: TextButton.styleFrom(
              //           primary: Colors.blueGrey,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(15),
              //           ),
              //         ),
              //         onPressed: _isProcessing
              //             ? null
              //             : () async {
              //                 setState(() {
              //                   _isProcessing = true;
              //                 });
              //                 await signOut().then((result) {
              //                   print(result);
              //                   Navigator.of(context).pushReplacement(
              //                     MaterialPageRoute(
              //                       fullscreenDialog: true,
              //                       builder: (context) => HomePage(),
              //                     ),
              //                   );
              //                 }).catchError((error) {
              //                   print('Sign Out Error: $error');
              //                 });
              //                 setState(() {
              //                   _isProcessing = false;
              //                 });
              //               },
              //         child: Padding(
              //           padding: EdgeInsets.only(
              //             top: 8.0,
              //             bottom: 8.0,
              //           ),
              //           child: _isProcessing
              //               ? CircularProgressIndicator()
              //               : Text(
              //                   'Sign out',
              //                   style: TextStyle(
              //                     fontSize: 14,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
