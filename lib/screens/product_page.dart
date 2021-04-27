import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sync_biryani_web/models/category_model.dart';
import 'package:sync_biryani_web/widgets/cart.dart';
import 'package:sync_biryani_web/widgets/footer.dart';
import 'package:sync_biryani_web/widgets/product.dart';
import 'package:sync_biryani_web/widgets/responsive.dart';
import 'package:sync_biryani_web/widgets/synch_drawer.dart';
import 'package:sync_biryani_web/widgets/top_bar_content.dart';

class Items extends StatefulWidget {
  final CategoryModel categoryModel;

  const Items({Key key, this.categoryModel}) : super(key: key);

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  double _opacity = 0.6;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
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
              preferredSize: Size(screenSize.width, 1000),
              child: TopBarContent(),
            ),
      drawer: SynchDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.bottomCenter,
                color: Colors.blueGrey,
                height: MediaQuery.of(context).size.width / 3,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.width / 5.5,
                        child: Carousel(
                          boxFit: BoxFit.cover,
                          borderRadius: true,
                          images: [
                            AssetImage('images/a.jpg'),
                            AssetImage('images/grapesbanner.jpg'),
                            AssetImage('images/lycheebanner.jpg'),
                            AssetImage('images/pearsbanner.jpg'),
                            AssetImage('images/vegetablesbanner.jpg'),
                          ],
                          dotSize: 4.0,
                          // dotSpacing: 15.0,
                          dotColor: Colors.pink[300],
                          indicatorBgPadding: 5.0,
                          autoplay: true,
                          autoplayDuration: Duration(seconds: 8),
                          animationCurve: Curves.easeIn,
                          animationDuration: Duration(seconds: 2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50),
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Collection",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        color: Colors.blueGrey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Veg Only",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Checkbox(
                              activeColor: Colors.green,
                              checkColor: Colors.white,
                              value: timeDilation != 1,
                              onChanged: (bool value) {
                                setState(() {
                                  timeDilation = value ? 2 : 1;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 140,
                        color: Colors.blueGrey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Non-Veg Only",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Checkbox(
                              activeColor: Colors.green,
                              checkColor: Colors.white,
                              value: timeDilation != 3,
                              onChanged: (bool value) {
                                setState(() {
                                  timeDilation = value ? 4.0 : 3.0;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width / 1.05,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Responsive.isDesktop(context)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Products(),
                        Cart(),
                      ],
                    )
                  : Products(),
            ),
            WidgetFooter(),
          ],
        ),
      ),
    );
  }
}
