import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Complaints extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('complaints');

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return Container(
              width: 290,
              height: 100,
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: new ListTile(
                  title: new Text(
                    'Action Required : ' + document.data()['actionreq'],
                    style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                  ),
                  subtitle: new Text(
                    'Village      :  ' +
                        document.data()['village'] +
                        '\n' +
                        'Ph name :   ' +
                        document.data()['phnum'],
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
