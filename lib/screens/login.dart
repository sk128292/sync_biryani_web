import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_biryani_web/helpers/commans.dart';
import 'package:sync_biryani_web/helpers/screen_navigation.dart';
import 'package:sync_biryani_web/provider/user_provider.dart';
import 'package:sync_biryani_web/screens/home_page.dart';
import 'package:sync_biryani_web/screens/registration.dart';
import 'package:sync_biryani_web/widgets/custom_text.dart';
import 'package:sync_biryani_web/widgets/loading.dart';
import 'package:sync_biryani_web/widgets/responsive.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login-screen';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: authProvider.status == Status.Authenticating
          ? Loading()
          : Center(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 500,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      colors: [
                        Colors.green,
                        Colors.orange,
                        Colors.black,
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Responsive.isDesktop(context)
                      ? Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              // color: Colors.red,
                              child: Image(
                                height: MediaQuery.of(context).size.width / 2.8,
                                // width: MediaQuery.of(context).size.width / 12,
                                image:
                                    AssetImage("images/HighQualityFresh.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 50),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Image.asset("images/a.jpg",
                                            width: 140, height: 120),
                                      ),
                                      CustomText(
                                        text: "Synchrotron Biryani",
                                        size: 20,
                                        colors: white,
                                        weight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: grey),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: TextFormField(
                                          controller: authProvider.email,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Email Id",
                                            icon: Icon(Icons.email),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: grey),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: TextFormField(
                                          controller: authProvider.password,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Password",
                                              icon: Icon(Icons.lock)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (!await authProvider.signIn()) {
                                          // ignore: deprecated_member_use
                                          _key.currentState.showSnackBar(
                                            SnackBar(
                                                content:
                                                    Text("Login failed! ")),
                                          );
                                          return;
                                        }
                                        authProvider.cleanControllers();
                                        changeScreenReplacement(
                                            context, MyHomePage());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: red,
                                          border: Border.all(color: grey),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 1, bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomText(
                                                text: "Login",
                                                colors: white,
                                                size: 22,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      changeScreen(context, Registration());
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                            text: "Register Here", size: 20),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : SingleChildScrollView(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 50),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    text: "Synchrotron Biryani",
                                    size: 20,
                                    colors: black,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: grey),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: TextFormField(
                                        controller: authProvider.email,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Email Id",
                                            icon: Icon(Icons.email)),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: grey),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: TextFormField(
                                        controller: authProvider.password,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Password",
                                            icon: Icon(Icons.lock)),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (!await authProvider.signIn()) {
                                        // ignore: deprecated_member_use
                                        _key.currentState.showSnackBar(
                                          SnackBar(
                                              content: Text("Login failed! ")),
                                        );
                                        return;
                                      }
                                      authProvider.cleanControllers();
                                      changeScreenReplacement(
                                          context, MyHomePage());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: red,
                                        border: Border.all(color: grey),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 1, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              text: "Login",
                                              colors: white,
                                              size: 22,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    changeScreen(context, Registration());
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                          text: "Register Here", size: 20),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ),
    );
  }
}
