import 'package:flutter/material.dart';

class WidgetFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 6,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                "Company",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 80,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
              Text(
                "Menu",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 90,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Column(
            children: [
              Text(
                "Company",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 80,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
              Text(
                "Menu",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 90,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Column(
            children: [
              Text(
                "Company",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 80,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
              Text(
                "Menu",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 90,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
