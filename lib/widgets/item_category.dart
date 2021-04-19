import 'package:flutter/material.dart';

class ItemCategory extends StatefulWidget {
  @override
  _ItemCategoryState createState() => _ItemCategoryState();
}

class _ItemCategoryState extends State<ItemCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width / 5.5,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Container(
              height: MediaQuery.of(context).size.width / 40,
              width: MediaQuery.of(context).size.width / 5.5,
              child: InkWell(
                hoverColor: Colors.grey,
                onTap: () {},
                child: Text(
                  "HYDERABAD-E-KHAS",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              height: MediaQuery.of(context).size.width / 40,
              width: MediaQuery.of(context).size.width / 5.5,
              child: InkWell(
                hoverColor: Colors.red,
                onTap: () {},
                child: Text(
                  "HYDERABAD-E-KHAS",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              height: MediaQuery.of(context).size.width / 40,
              width: MediaQuery.of(context).size.width / 5.5,
              child: InkWell(
                hoverColor: Colors.red,
                onTap: () {},
                child: Text(
                  "HYDERABAD-E-KHAS",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              height: MediaQuery.of(context).size.width / 40,
              width: MediaQuery.of(context).size.width / 5.5,
              child: InkWell(
                hoverColor: Colors.red,
                onTap: () {},
                child: Text(
                  "HYDERABAD-E-KHAS",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              height: MediaQuery.of(context).size.width / 40,
              width: MediaQuery.of(context).size.width / 5.5,
              child: InkWell(
                hoverColor: Colors.red,
                onTap: () {},
                child: Text(
                  "HYDERABAD-E-KHAS",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              height: MediaQuery.of(context).size.width / 35,
              width: MediaQuery.of(context).size.width / 5.5,
              child: InkWell(
                hoverColor: Colors.red,
                onTap: () {},
                child: Text(
                  "HYDERABAD-E-KHAS",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          // Divider(),
          // FlatButton(
          //   onPressed: () {},
          //   child: Text("HYDERABAD-E-KHAS"),
          // ),
          // Divider(),
          // FlatButton(
          //   onPressed: () {},
          //   child: Text("HYDERABAD-E-KHAS"),
          // ),
          // Divider(),
          // FlatButton(
          //   onPressed: () {},
          //   child: Text("HYDERABAD-E-KHAS"),
          // ),
          // Divider(),
        ],
      ),
    );
  }
}
