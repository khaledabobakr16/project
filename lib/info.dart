import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/orders.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';
import 'package:image_card/image_card.dart';

var count = 0;

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
        actions: [
          Stack(
            children: [
              Positioned(
                  left: 20,
                  bottom: 37,
                  child: Container(
                    child: Center(child: Text("$count")),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50)),
                    height: 18,
                    width: 20,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Orders()),
                        (Route<dynamic> route) => false,
                      );
                    });
                  },
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    size: 28,
                    color: Colors.grey[50],
                  )),
            ],
          )
        ],
        title: Column(
          children: [
            Text(
              "Let's find your Car ",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.blue.shade900),
                            height: 170,
                            width: context.width,
                            child: Stack(
                              children: [
                                Positioned(
                                    right: 70,
                                    child: Container(
                                      height: 50,
                                      width: 30,
                                      color: Colors.red,
                                      child: Center(
                                        child: Text(
                                          data["discount"].toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 170,
                                          width: 130,
                                          child: Image(
                                            fit: BoxFit.fill,
                                            height: 50,
                                            width: 30,
                                            image: NetworkImage(
                                                data["url"].toString()),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Divider(
                                              color: Colors.white,
                                              indent: 15,
                                              thickness: 2,
                                            ),
                                            Container(
                                              width: 190,
                                              child: Column(children: [
                                                Center(
                                                  child: Container(
                                                    child: Text(
                                                      (data["proudctname"]
                                                          .toString()),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    child: Center(
                                                        child: Text(
                                                      "Model ${data["made"]}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    child: Center(
                                                        child: Text(
                                                      ("Price " +
                                                          data["price"]
                                                              .toString()),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                  ),
                                                ),
                                                Divider(
                                                  color: Colors.white,
                                                  indent: 15,
                                                  thickness: 2,
                                                ),
                                                Center(
                                                  child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          final docs = snapshot
                                                              .data?.docs;
                                                          String price =
                                                              data["price"]
                                                                  .toString();
                                                          String discount =
                                                              data["discount"]
                                                                  .toString();
                                                          String productname =
                                                              data["proudctname"]
                                                                  .toString();
                                                          String made =
                                                              data["made"]
                                                                  .toString();
                                                          String url =
                                                              data["url"]
                                                                  .toString();
                                                          String id = document
                                                              .id
                                                              .toString();
                                                          print(
                                                              "${document.id.toString()}");

                                                          uploadFile(
                                                            price,
                                                            productname,
                                                            made,
                                                            url,
                                                            id,
                                                            discount,
                                                          );
                                                          showDialog(
                                                            context: context,
                                                            builder: (ctx) =>
                                                                AlertDialog(
                                                              backgroundColor:
                                                                  Colors.blue
                                                                      .shade900,
                                                              title: Text('',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                              content: Text(
                                                                  "Look at the shopping cart to confirm the order",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        count++;
                                                                      });
                                                                      Navigator.of(
                                                                              ctx)
                                                                          .pop();
                                                                    },
                                                                    child: Container(
                                                                        child: const Text(
                                                                            "okay",
                                                                            style:
                                                                                TextStyle(color: Colors.white)))),
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                      },
                                                      child: Container(
                                                        child: Center(
                                                            child: Text(
                                                                "Buy Now",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue
                                                                        .shade900,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                        height: 18,
                                                        width: 130,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                      )),
                                                )
                                              ]),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Future uploadFile(var price, var proudctname, var made, var url, var id,
      var discount) async {
    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'price': price, // John Doe
        'proudctname': proudctname, // Stokes and Sons
        'made': made,
        'url': url,
        "id": id,
        "discount": discount
      });
    } catch (e) {
      print('error occured');
    }
  }
}
