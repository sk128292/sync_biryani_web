import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_biryani_web/helpers/commans.dart';
import 'package:sync_biryani_web/helpers/screen_navigation.dart';
import 'package:sync_biryani_web/provider/category_provider.dart';
import 'package:sync_biryani_web/provider/product_provider.dart';
import 'package:sync_biryani_web/screens/product_page.dart';
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
    // final user = Provider.of<UserProvider>(context);
    // final app = Provider.of<AppProvider>(context);
    // final authProvider = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
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
      // drawer: SynchDrawer(),
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
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
                SearchBox(),
              ],
            ),
            Container(
              color: red,
              height: screenSize.width / 6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryProvider.categories.length,
                  itemBuilder: (_, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width / 4,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.red),
                      child: Image(
                        image: AssetImage("images/a.jpg"),
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                  // children: [
                  //   Container(
                  //     width: MediaQuery.of(context).size.width / 4,
                  //     clipBehavior: Clip.antiAlias,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.all(Radius.circular(8)),
                  //         color: Colors.red),
                  //     child: Image(
                  //       image: AssetImage("images/a.jpg"),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  //   SizedBox(
                  //     width: 20,
                  //   ),
                  //   Container(
                  //     width: MediaQuery.of(context).size.width / 4,
                  //     clipBehavior: Clip.antiAlias,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.all(Radius.circular(8)),
                  //         color: Colors.red),
                  //     child: Image(
                  //       image: AssetImage("images/grapesbanner.jpg"),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  //   SizedBox(
                  //     width: 20,
                  //   ),
                  //   Container(
                  //     width: MediaQuery.of(context).size.width / 4,
                  //     clipBehavior: Clip.antiAlias,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.all(Radius.circular(8)),
                  //         color: Colors.red),
                  //     child: Image(
                  //       image: AssetImage("images/lycheebanner.jpg"),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  //   SizedBox(
                  //     width: 20,
                  //   ),
                  //   Container(
                  //     width: MediaQuery.of(context).size.width / 4,
                  //     clipBehavior: Clip.antiAlias,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.all(Radius.circular(8)),
                  //         color: Colors.red),
                  //     child: Image(
                  //       image: AssetImage("images/pearsbanner.jpg"),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ],
                  ),
              // ListView.builder(
              //   scrollDirection: Axis.horizontal,
              //   itemCount: categoryProvider.categories.length,
              //   itemBuilder: (_, index) {
              //     return GestureDetector(
              //       onTap: () async {
              //         await productProvider.loadProductsByCategory(
              //             categoryName:
              //                 categoryProvider.categories[index].name);
              //         changeScreen(
              //           context,
              //           Items(
              //             categoryModel: categoryProvider.categories[index],
              //           ),
              //         );
              //       },
              //       child: Text(productProvider.products.length.toString()),
              //     );
              //   },
              // ),
            ),
            Promise(),
            Story(),
            SizedBox(height: MediaQuery.of(context).size.width / 12),
            WidgetFooter(),
          ],
        ),
      ),
    );
  }
}
