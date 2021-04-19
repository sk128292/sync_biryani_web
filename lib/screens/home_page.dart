import 'package:flutter/material.dart';
import 'package:sync_biryani_web/widgets/navbar.dart';
import 'package:sync_biryani_web/widgets/promise.dart';
import 'package:sync_biryani_web/widgets/search.dart';
import 'package:sync_biryani_web/widgets/stories.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Navbar(),
        SearchBox(),
        Promise(),
        Story(),
      ],
    );
  }
}
