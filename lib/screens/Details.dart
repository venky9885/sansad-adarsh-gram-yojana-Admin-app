import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> addUser(String name, String mpname, String developement) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'villagename': name, // John Doe
          'mpname': mpname, // Stokes and Sons
          'developement': developement,
          'rating': 0,
          'ratingpeople': 0, // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addMpUser(
      String name, String mpname, String developement, String mail) {
    // Call the user's CollectionReference to add a new user
    return mpusers.add({
      'villageadpt': name, // John Doe
      'name': mpname, // Stokes and Sons
      'mail': mail,
      // 42
    }).then((value) {
      showToast("Uploaded Successfully");
    }).catchError((error) {
      showToast("Error occoured, Failed !");
    });
  }

  void showToast(String mg) {
    Fluttertoast.showToast(
        msg: mg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_LEFT,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.grey,
        textColor: Colors.black);
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference mpusers =
      FirebaseFirestore.instance.collection('adaption');
  CollectionReference users = FirebaseFirestore.instance.collection('village');

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      addUser(nameController.text, regnoController.text, secController.text);
      addMpUser(nameController.text, regnoController.text, secController.text,
          issController.text);
      nameController.clear();
      regnoController.clear();
      secController.clear();
      issController.clear();
    }
  }

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  //TextEditingController emailController = TextEditingController();
  TextEditingController regnoController = TextEditingController();
  TextEditingController secController = TextEditingController();
  TextEditingController issController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Container(
                          alignment: Alignment.center,
                          height: 450,
                          width: 350,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                controller: nameController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Valid Name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: 16, right: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    labelText: 'Village Name'),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                controller: issController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Valid mail';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: 16, right: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    labelText: 'Email'),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                controller: regnoController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Valid Name';
                                  }
                                  return null;
                                },
                                // validator: (value) {
                                //   if (value.trim().length != 10) {
                                //     return 'Enter Phone Number';
                                //   }
                                //   return null;
                                // },
                                // keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 16, right: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  labelText: 'Mp Name',
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                controller: secController,
                                //textInputAction: ,
                                maxLines: 6,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Correctly';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: 16, right: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    labelText:
                                        'Enter the field names that \n are taken for developement'),
                              ),
                              // TextFormField(
                              //   controller: issController,
                              //   //textInputAction: ,
                              //   maxLines: 6,
                              //   validator: (value) {
                              //     if (value.isEmpty) {
                              //       return 'Enter any issue';
                              //     }
                              //     return null;
                              //   },
                              //   keyboardType: TextInputType.multiline,
                              //   decoration:
                              //       InputDecoration(labelText: 'Request a service'),
                              // ),
                            ],
                          ),
                        ),
                      )),
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      _submitForm();
                      FocusScope.of(context).unfocus();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

// Future<void> addUser(int ct, int mp) {
//     return users
//         .doc('info')
//         .update({'count': ct, 'mpCount': mp})
//         .then((value) => showToast("Updated Successfully") //{
//             //print("count Updated");
//             // Fluttertoast.showToast(
//             //     msg: "Successfully Updated",
//             //     toastLength: Toast.LENGTH_SHORT,
//             //     gravity: ToastGravity.CENTER,
//             //     //timeInSecForIosWeb: 1,
//             //     backgroundColor: Colors.red,
//             //     textColor: Colors.white,
//             //     fontSize: 16.0);
//             //}
//             )
//         .catchError((error) {
//           Fluttertoast.showToast(
//               msg: "Failed to update",
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.CENTER,
//               timeInSecForIosWeb: 1,
//               backgroundColor: Colors.grey,
//               textColor: Colors.black,
//               fontSize: 16.0);
//         });
//     // return users
//     //     .add({'ct': 23})
//     //     .then((value) => print("User Added"))
//     //     .catchError((error) => print("Failed to add user: $error"));
//   }
