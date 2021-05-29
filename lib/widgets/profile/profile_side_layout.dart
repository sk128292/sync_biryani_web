import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:sync_biryani_web/helpers/screen_navigation.dart';
import 'package:sync_biryani_web/provider/user_provider.dart';
import 'package:sync_biryani_web/screens/login.dart';
import 'package:sync_biryani_web/widgets/profile/profile_update_widget.dart';

class ProfileSideLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    final user = Provider.of<UserProvider>(context);
    return Container(
      child: Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Colors.blueGrey.shade900.withOpacity(0.6),
          child: Column(
            children: <Widget>[
              SizedBox(height: 70),
              // Image.asset('assets/images/logo.png'),
              Text(
                'Hello.. !' + authProvider.userModel?.name ?? "name loading...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: Colors.blue,
                ),
                height: 40,
                child: InkWell(
                  onTap: () {
                    pushNewScreenWithRouteSettings(
                      context,
                      screen: ProfileUpdateWidget(),
                      settings: RouteSettings(name: ProfileUpdateWidget.id),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.person_rounded, size: 18, color: Colors.white),
                      SizedBox(width: 35),
                      Expanded(
                        child: Text(
                          'Profile Account',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: Colors.blue,
                ),
                height: 40,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.history, size: 18, color: Colors.white),
                      SizedBox(width: 35),
                      Expanded(
                        child: Text(
                          'My Order',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: Colors.blue,
                ),
                height: 40,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.comment_outlined,
                          size: 18, color: Colors.white),
                      SizedBox(width: 35),
                      Expanded(
                        child: Text(
                          'My Review',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: Colors.blue,
                ),
                height: 40,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.person_rounded, size: 18, color: Colors.white),
                      SizedBox(width: 35),
                      Expanded(
                        child: Text(
                          'Notification',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: Colors.blue,
                ),
                height: 40,
                child: InkWell(
                  onTap: () async {
                    await user.signOut();
                    changeScreen(context, LoginPage());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.power_settings_new,
                          size: 18, color: Colors.white),
                      SizedBox(width: 35),
                      Expanded(
                        child: Text(
                          'Logout',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
