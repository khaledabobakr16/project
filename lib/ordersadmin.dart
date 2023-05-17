import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/main.dart';
import 'settingscreen.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';
import 'package:image_card/image_card.dart';

import 'homescreen.dart';

class OrdersAdmin extends StatefulWidget {
  @override
  State<OrdersAdmin> createState() => _OrdersAdminState();
}

class _OrdersAdminState extends State<OrdersAdmin> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('ordersadmin').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            height: 200,
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
                                    Text(
                                      "From: ${data["email"]}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                      child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder: (ctx) =>
                                                                    AlertDialog(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black,
                                                                  title: Text(
                                                                      'Cancel Massage',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                  content: Text(
                                                                      "Are you sure to cancel?",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(ctx)
                                                                            .pop();
                                                                      },
                                                                      child: InkWell(
                                                                          onTap: () {
                                                                            setState(() {});
                                                                          },
                                                                          child: Container(child: const Text("No", style: TextStyle(color: Colors.white)))),
                                                                    ),
                                                                    InkWell(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        child:
                                                                            Container()),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(ctx)
                                                                            .pop();
                                                                      },
                                                                      child: InkWell(
                                                                          onTap: () {
                                                                            setState(() {
                                                                              FirebaseFirestore.instance.collection("ordersadmin").doc(document.id.toString()).delete().then(
                                                                                    (doc) => print(document.id.toString()),
                                                                                    onError: (e) => print("Error updating document $e"),
                                                                                  );
                                                                            });
                                                                          },
                                                                          child: Container(child: const Text("yes", style: TextStyle(color: Colors.white)))),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12),
                                                            child: Container(
                                                              child: Center(
                                                                  child: Text(
                                                                      "Cancel",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold))),
                                                              height: 20,
                                                              width: 80,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                            ),
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
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
}
