import 'dart:js';

import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';
import 'package:sync_biryani_web/location/utilities/api.dart';
import 'package:sync_biryani_web/location/utilities/loc.dart';
import 'package:sync_biryani_web/screens/second_screen/second_page.dart';
import 'package:sync_biryani_web/services/comman_services.dart';
import 'package:sync_biryani_web/widgets/responsive.dart';

class SearchBox extends StatefulWidget {
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  CommanServices _services = CommanServices();
  Geodesy geodesy = Geodesy();

  String _city = '';
  double _latitude = 0.0;
  double _longitude = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 30),
          child: Image(
            height: MediaQuery.of(context).size.width / 6.5,
            image: AssetImage("images/DumCooked.png"),
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: Responsive.isMobile(context)
                    ? MediaQuery.of(context).size.width / 1.5
                    : MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  color: Colors.white,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Colors.red,
                  ),
                  title: TextField(
                    enabled: false,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (String city) {
                      setState(() {
                        _city = city;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: _city.isEmpty ? "Get your Location" : '$_city',
                      border: InputBorder.none,
                    ),
                  ),
                  // trailing: Padding(
                  //   padding: EdgeInsets.all(10),
                  //   child: Icon(Icons.filter_list, color: Colors.red),
                  // ),
                ),
              ),
              _city.isEmpty
                  ? GestureDetector(
                      onTap: () async {
                        final _val = await LocationAPI().fetchData();
                        setState(
                          () {
                            _city = _val;
                          },
                        );
                        getLat();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                " Get Location",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        LatLng l2 = LatLng(_latitude, _longitude);
                        LatLng l1 = LatLng(28.599365, 77.074882);
                        num distance =
                            (geodesy.distanceBetweenTwoGeoPoints(l1, l2)) /
                                1000;
                        print('Distance From Store: ' +
                            distance.toStringAsFixed(2) +
                            ' Km');
                        if (distance >= 10) {
                          _services.showMyDialog(
                            title: 'Delivery Unavailable',
                            message: 'You Location is more than 10 km',
                            context: context,
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductScreen(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                " Order Now",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
              // Text('LAT : $_latitude'.toString()),
              // Text('LONG : $_longitude'.toString()),
              // OutlinedButton(
              //   onPressed: () async {
              //     final _val = await LocationAPI().fetchData();
              //     setState(() => _city = _val);
              //   },
              //   child: const Text('Location from API'),
              // ),
              // Text('CITY : $_city'),
            ],
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //     height: MediaQuery.of(context).size.width / 6,
        //     child: ListView(
        //       scrollDirection: Axis.horizontal,
        //       children: [
        //         Container(
        //           width: MediaQuery.of(context).size.width / 4,
        //           clipBehavior: Clip.antiAlias,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.all(Radius.circular(8)),
        //               color: Colors.red),
        //           child: Image(
        //             image: AssetImage("images/a.jpg"),
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //         SizedBox(
        //           width: 20,
        //         ),
        //         Container(
        //           width: MediaQuery.of(context).size.width / 4,
        //           clipBehavior: Clip.antiAlias,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.all(Radius.circular(8)),
        //               color: Colors.red),
        //           child: Image(
        //             image: AssetImage("images/grapesbanner.jpg"),
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //         SizedBox(
        //           width: 20,
        //         ),
        //         Container(
        //           width: MediaQuery.of(context).size.width / 4,
        //           clipBehavior: Clip.antiAlias,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.all(Radius.circular(8)),
        //               color: Colors.red),
        //           child: Image(
        //             image: AssetImage("images/lycheebanner.jpg"),
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //         SizedBox(
        //           width: 20,
        //         ),
        //         Container(
        //           width: MediaQuery.of(context).size.width / 4,
        //           clipBehavior: Clip.antiAlias,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.all(Radius.circular(8)),
        //               color: Colors.red),
        //           child: Image(
        //             image: AssetImage("images/pearsbanner.jpg"),
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),

        // Container(
        //   width: 1000,
        //   height: 400,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(15),
        //     color: Colors.white,
        //   ),
        //   child: Carousel(
        //     boxFit: BoxFit.cover,
        //     images: [
        //       AssetImage('images/a.jpg'),
        //       AssetImage('images/grapesbanner.jpg'),
        //       AssetImage('images/lycheebanner.jpg'),
        //       AssetImage('images/pearsbanner.jpg'),
        //       AssetImage('images/vegetablesbanner.jpg'),
        //     ],
        //     dotSize: 4.0,
        //     borderRadius: true,
        //     // dotSpacing: 15.0,
        //     dotColor: Colors.pink[300],
        //     indicatorBgPadding: 5.0,
        //     autoplay: true,
        //     autoplayDuration: Duration(seconds: 8),
        //     animationCurve: Curves.easeIn,
        //     animationDuration: Duration(seconds: 2),
        //   ),
        // ),
      ],
    );
  }

  void getLat() {
    getCurrentPosition(allowInterop((pos) {
      setState(() {
        _latitude = pos.coords.latitude;
        _longitude = pos.coords.longitude;
      });
      return;
    }));
  }

  // void calculateDistance() {
  //   Geodesy geodesy = Geodesy();

  //   LatLng l1 = LatLng(28.599365, 77.074882);
  //   LatLng l2 = LatLng(_latitude, _longitude);

  //   num distance = geodesy.distanceBetweenTwoGeoPoints(l1, l2);
  //   print("Distance: " + (distance / 1000).toString());
  //   print(_latitude);
  //   print(_longitude);
  // }
}
