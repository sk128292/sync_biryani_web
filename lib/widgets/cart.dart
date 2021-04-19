import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        // color: Colors.grey[200],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cart",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text("Items " + " 2"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 2,
                width: MediaQuery.of(context).size.width / 3.5,
                color: Colors.black,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "HYDERABAD-E-KHAS",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  text:
                                      "Hyderabadi Dum Gosht [Mutton Biryani, Boneless - Serves 1]",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 85,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "kg" + " X " + "2",
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Text("Rs: " + (200 * 2).toString(),
                                      style: TextStyle(
                                          color: Colors.orange[700],
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.orange[500],
                            ),
                            onPressed: () {}),
                        Text(2.toString()),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.orange[500],
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 80,
                    ),
                    Row(
                      children: [
                        Text(
                          "Rs: " + (200 * 2).toString(),
                          style: TextStyle(
                              color: Colors.orange[700],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Column(
                            children: [
                              Text("HYDERABAD-E-KHAS"),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  text:
                                      "Hyderabadi Dum Gosht [Mutton Biryani, Boneless - Serves 1]",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 85,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "kg" + " X " + "2",
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Text("Rs: " + (200 * 2).toString(),
                                      style: TextStyle(
                                          color: Colors.orange[700],
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        // padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.remove_circle,
                          color: Colors.orange[500],
                        ),
                        onPressed: () {}),
                    Text(2.toString()),
                    IconButton(
                      // padding: EdgeInsets.all(0),
                      icon: Icon(
                        Icons.add_circle,
                        color: Colors.orange[500],
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Total: Rs. " + 400.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      color: Colors.green[500],
                      onPressed: () {},
                      child: Text(
                        "Checkout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
