import 'package:carousel_pro/carousel_pro.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:sync_biryani_web/widgets/cart.dart';
import 'package:sync_biryani_web/widgets/footer.dart';
import 'package:sync_biryani_web/widgets/responsive.dart';
import 'package:sync_biryani_web/widgets/second_screen_widget/product_show.dart';
import 'package:sync_biryani_web/widgets/synch_drawer.dart';
import 'package:sync_biryani_web/widgets/top_bar_content.dart';

class ProductScreen extends StatefulWidget {
  static const String id = 'product-screen';

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  double _opacity = 0.6;
  int tag = 0;
  List<String> options = ['All ', 'Veg Only', 'Non-Veg Only'];
  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        // physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
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
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(thickness: 1, color: Colors.black),
          ),
          Container(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Collection",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                Container(
                  height: 50,
                  child: ChipsChoice<int>.single(
                    choiceStyle: C2ChoiceStyle(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    value: tag,
                    onChanged: (val) {
                      if (val == 0) {
                        setState(() {
                          // _orderProvider.status = null;
                        });
                      }
                      setState(() {
                        tag = val;
                        // _orderProvider.status = options[val];
                      });
                    },
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: options,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(thickness: 1, color: Colors.black),
          ),
          Padding(
              padding: const EdgeInsets.all(25.0),
              child: Responsive.isDesktop(context)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductDisplay(),
                        Cart(),
                      ],
                    )
                  : ProductDisplay()),
          WidgetFooter(),
        ],
      ),
    );
  }
}
