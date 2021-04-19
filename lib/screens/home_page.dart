import 'package:flutter/material.dart';
import 'package:sync_biryani_web/widgets/footer.dart';
import 'package:sync_biryani_web/widgets/promise.dart';
import 'package:sync_biryani_web/widgets/responsive.dart';
import 'package:sync_biryani_web/widgets/search.dart';
import 'package:sync_biryani_web/widgets/stories.dart';
import 'package:sync_biryani_web/widgets/synch_drawer.dart';
import 'package:sync_biryani_web/widgets/top_bar_content.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _opacity = 0.6;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
              preferredSize: Size(screenSize.width, 1000),
              child: TopBarContent(),
            ),
      drawer: SynchDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: SizedBox(
                height: screenSize.height * 0.45,
                width: screenSize.width,
                child: Image.asset(
                  'images/header.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                SearchBox(),
                Promise(),
                Story(),
                SizedBox(height: MediaQuery.of(context).size.width / 12),
                WidgetFooter(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
