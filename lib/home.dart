// import 'package:cloud_firestore/cloud_firestore.dart';
// import'package:flutter/material.dart';
// class UserInformation extends StatefulWidget {
//   @override
//   _UserInformationState createState() => _UserInformationState();
// }
//
// class _UserInformationState extends State<UserInformation> {
//   final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
//
//   @override
//   Widget build(BuildContext context) {
//     bool isbool=false;
//     return Scaffold(
//
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _usersStream,
//
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Text('Something went wrong');
//           }
//
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Text("Loading");
//           }
//
//           return ListView(
//             children: snapshot.data!.docs.map((DocumentSnapshot document) {
//               Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//               return Container(
//               child:  Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     children: [
//                       Container(height: 200,width: double.infinity,color: Colors.black,),
//                       Container(alignment: Alignment.bottomLeft,height: 353,width: double.infinity,child: Image(image: AssetImage("images/c2.png")),),
//                       Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(40.0),
//                             child: Text("Let's find your products!",maxLines: 2,style: TextStyle(color: Colors.white,fontSize: 45,fontWeight: FontWeight.bold),),
//
//                           ),
//                           SizedBox(height: 20,),
//                           Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(25),
//                                   color: Colors.grey.shade300),
//                               height: 250,
//                               width: double.infinity,
//                               child: Image(
//                                   image: AssetImage("images/img6.jpg"),
//                                   fit: BoxFit.fitHeight),
//                             ),
//                           ),
//                           Center(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.black,),
//                                   height: 15,
//                                   width: 15,
//
//                                 ),
//                                 SizedBox(width: 5,),
//                                 Container(
//                                   height: 15,
//                                   width: 15,
//                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.grey.shade300,),
//                                 ),
//                                 SizedBox(width: 5,),
//                                 Container( height: 15,
//                                   width: 15,
//                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.grey.shade300,),),
//                               ],),
//                           ),
//                           SizedBox(height: 15,),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 12),
//                             child: Container(
//                               decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(15)),
//
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(" Latest Products",style:TextStyle(color:Colors.black,fontSize: 28,fontWeight: FontWeight.bold)),
//                                 ],
//                               ),
//                             ),
//                           ),
//
//                         ],
//                       ),
//                     ],
//                   )],
//
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<String> data2() async {
      var data1 = (await FirebaseFirestore.instance.collection('products').doc('ac1')
          .get())
          .data
          .toString();
      return data1;
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.black)),
                child: ListTile(
                  title: FutureBuilder(
                    future: data2(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      print(snapshot.data);
                      return Text(snapshot.data);
                    },
                  ), //ok no errors.
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}