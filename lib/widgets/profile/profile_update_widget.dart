import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sync_biryani_web/provider/user_provider.dart';
import 'package:sync_biryani_web/services/user_services.dart';

class ProfileUpdateWidget extends StatefulWidget {
  static const String id = 'profile-update-widget';
  @override
  _ProfileUpdateWidgetState createState() => _ProfileUpdateWidgetState();
}

class _ProfileUpdateWidgetState extends State<ProfileUpdateWidget> {
  UserServices _userServices = UserServices();
  User _user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var mob = TextEditingController();

  bool _name = false;
  bool _email = false;
  bool _mob = false;

  updateName() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .update({
      'name': name.text,
    });
  }

  @override
  void initState() {
    _userServices.getUserById(_user.uid).then((value) {
      if (mounted) {
        name.text = value.name;
        email.text = value.email;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.lightBlue[50],
        child: Padding(
          padding: const EdgeInsets.only(left: 250, right: 250, top: 20),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Change Your Details !',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Divider(color: Colors.black, thickness: 0.5),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _name
                          ? Expanded(
                              child: TextFormField(
                                controller: name,
                                decoration: InputDecoration(
                                  labelText: 'Full Name',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Name';
                                  }
                                  return null;
                                },
                              ),
                            )
                          : Text('Name: \n' + authProvider.userModel?.name),
                      SizedBox(width: 50),
                      _name
                          ? MaterialButton(
                              color: Colors.green,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  EasyLoading.show(status: 'Updating Name');
                                  updateName().then((value) {
                                    EasyLoading.showSuccess(
                                        'Name Updated successfully');
                                    setState(() {
                                      _name = false;
                                    });
                                    authProvider.reloadUserModel();
                                  });
                                }
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : MaterialButton(
                              color: Colors.brown,
                              onPressed: () {
                                setState(() {
                                  _name = true;
                                });
                              },
                              child: Text(
                                'Edit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    ],
                  ),
                ),
                Divider(thickness: 0.3, color: Colors.black),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _email
                          ? Expanded(
                              child: TextFormField(
                                controller: email,
                                decoration: InputDecoration(
                                  labelText: 'Enter Email Id',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Email';
                                  }
                                  return null;
                                },
                              ),
                            )
                          : Text('E-Mail: \n' + authProvider.userModel?.email),
                      SizedBox(width: 50),
                      _email
                          ? MaterialButton(
                              color: Colors.green,
                              onPressed: () {
                                setState(() {
                                  _email = false;
                                });
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : MaterialButton(
                              color: Colors.brown,
                              onPressed: () {
                                setState(() {
                                  _email = true;
                                });
                              },
                              child: Text(
                                'Edit',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                    ],
                  ),
                ),
                Divider(thickness: 0.3, color: Colors.black),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _mob
                          ? Expanded(
                              child: TextFormField(
                                controller: mob,
                                decoration: InputDecoration(
                                  labelText: 'Enter Mobile No.',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Mobile number';
                                  }
                                  return null;
                                },
                              ),
                            )
                          : Text('Mobile No: \n9074673202'),
                      SizedBox(width: 50),
                      _mob
                          ? MaterialButton(
                              color: Colors.green,
                              onPressed: () {
                                setState(() {
                                  _mob = false;
                                });
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : MaterialButton(
                              color: Colors.brown,
                              onPressed: () {
                                setState(() {
                                  _mob = true;
                                });
                              },
                              child: Text(
                                'Edit',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                    ],
                  ),
                ),
                Divider(thickness: 0.3, color: Colors.black),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
