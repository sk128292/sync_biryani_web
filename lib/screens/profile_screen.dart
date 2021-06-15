import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_biryani_web/helpers/screen_navigation.dart';
import 'package:sync_biryani_web/provider/user_provider.dart';
import 'package:sync_biryani_web/screens/login.dart';
import 'package:sync_biryani_web/widgets/order/order_widget.dart';
import 'package:sync_biryani_web/widgets/profile/profile_update_widget.dart';
import 'package:sync_biryani_web/widgets/responsive.dart';
import 'package:sync_biryani_web/widgets/synch_drawer.dart';
import 'package:sync_biryani_web/widgets/top_bar_content.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile-screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double _opacity = 0.6;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blue[50],
      appBar: Responsive.isMobile(context)
          ? AppBar(
              backgroundColor: Colors.blueGrey.shade900.withOpacity(_opacity),
              elevation: 0,
              title: Text(
                'SF Biryani',
                style: TextStyle(
                  color: Colors.blueGrey.shade100,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
            )
          : PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 1000),
              child: TopBarContent(),
            ),
      drawer: SynchDrawer(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    image: AssetImage(
                      'images/header.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Center(
                    child: Text(
                      'Welcome to you ' + authProvider.userModel?.name + " !" ??
                          "name loading...",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: VerticalTabs(
                  selectedTabBackgroundColor: Colors.green,
                  contentScrollAxis: Axis.vertical,
                  tabsWidth: 300,
                  tabs: <Tab>[
                    Tab(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 3),
                        height: 35,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.person_rounded),
                              SizedBox(width: 35),
                              Expanded(
                                child: Text(
                                  'Profile Account',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 3),
                        height: 35,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.history),
                              SizedBox(width: 35),
                              Expanded(
                                child: Text('My Order'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 3),
                        height: 35,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.comment_outlined),
                              SizedBox(width: 35),
                              Expanded(
                                child: Text('My Review'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 3),
                        height: 35,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.person_rounded),
                              SizedBox(width: 35),
                              Expanded(
                                child: Text('Notification'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 3),
                        height: 35,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: InkWell(
                            onTap: () async {
                              await authProvider.signOut();
                              changeScreen(context, LoginPage());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.power_settings_new),
                                SizedBox(width: 35),
                                Expanded(
                                  child: Text('Logout'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  contents: <Widget>[
                    ProfileUpdateWidget(),
                    OrderWidget(),
                    Center(child: Text('Review ')),
                    Center(child: Text('Notification')),
                    Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
