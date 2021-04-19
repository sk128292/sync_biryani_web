import 'package:flutter/material.dart';

class Promise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Our Promises",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 4.5,
                height: MediaQuery.of(context).size.width / 4,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  children: [
                    Image(
                      height: MediaQuery.of(context).size.width / 6.5,
                      image: AssetImage("images/HighQualityFresh.png"),
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "High Quality Fresh Ingredients",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 75,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      "Synchrotron Foods prides itself in using the freshest and handpicked ingredients",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 90,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: MediaQuery.of(context).size.width / 4.5,
                height: MediaQuery.of(context).size.width / 4,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  children: [
                    Image(
                      height: MediaQuery.of(context).size.width / 6.5,
                      image: AssetImage("images/DumCooked.png"),
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Dum cooked fresh on every order",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 75,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      "Each biryani is individually prepared in the traditional dum style with distinct layers by our khansamas in natural clay handis",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 90,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: MediaQuery.of(context).size.width / 4.5,
                height: MediaQuery.of(context).size.width / 4,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  children: [
                    Image(
                      height: MediaQuery.of(context).size.width / 6.5,
                      image: AssetImage("images/Authentic.png"),
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Authentic recipes with traditional khansama style of cooking",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 75,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      "Synchrotro Foods brings the Royal Biryani to you, prepared in the traditional dum style, slow cooked to perfection by our khansama",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 95,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
