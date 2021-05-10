//import 'dart:html';
//https://medium.com/digital-tech-articles/firebase-storage-in-flutter-web-d0d223d2b51a
//import 'dart:html' as html;

import 'dart:typed_data';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:file_picker/file_picker.dart';
//import 'dart:async';
//import 'dart:html';

//import 'package:image_picker_web_redux/image_picker_web_redux.dart';
//import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as i;
//import 'upload.dart' as j;
// import 'package:image_picker_web/image_picker_web.dart';
// import 'package:mime_type/mime_type.dart';
// import 'package:path/path.dart' as path;

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  // DateTime timeKey = new DateTime();
  /*firebase_storage.FirebaseStorage storage =
  firebase_storage.FirebaseStorage.instance;
  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
    .ref(timeKey.toString() + ".jpg");*/
  // ignore: missing_return
  Future<String> uploadFile(String pt, Uint8List file) async {
    // String fl = timeKey.toString() + ".jpg";
    //String tc;
    //File file = File(filePath);

    // File img  = File(file)
    //
    // String mimeType = mime(path.basename(file.fileName));
    // final extension = extensionFromMime(mimeType);
    // var metadata = fb.UploadMetadata(
    //   contentType: mimeType,
    // );
    try {
      //print('ssssssssssssssssssssssssssssssssssssssssssssssssss');
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/$pt')
          .putData(file)
          //.putFile(file)
          .then((tc) {
        print(tc.toString().split('fullPath:').last);
        String str = tc.toString().split('fullPath:').last.toString();
        str = str.substring(0, str.length - 1);
        return str;
        // if (str != null && str.length > 0) {
        //   str = str.substring(0, str.length - 1);
        //   //tc = str;
        // }
      });
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
    // return tc;
    //return '${filePath.toString}';
  }

  //Image image;
  //var timeKey = new DateTime.now();
  Future<String> downloadURLExample() async {
    var timeKey = new DateTime.now();
    String fl = timeKey.toString() + ".jpg";
    // final _image = await FlutterWebImagePicker.getImage;
    // setState(() {
    //   image = _image;
    // });
    //
    // html.File imageFile =
    //     await ImagePickerWeb.getImage(outputType: ImageType.file);

    // if (imageFile != null) {
    //   debugPrint(imageFile.name.toString());
    // }
    // MediaInfo pickedImage;

    // final imageFile = await ImagePickerWeb.getImageInfo;
    // if (imageFile != null) {
    //   setState(() {
    //     pickedImage = imageFile;
    //   });
    // }
//await j.uploadImage(){}
    // ignore: missing_return
    Future<Uint8List> uplImg() async {
      FilePickerResult res;

      res = await FilePicker.platform
          .pickFiles(type: FileType.image, allowedExtensions: ['jpg', 'png']);
      if (res != null) {
        Uint8List fil = res.files.single.bytes;
        return fil;
      }
    }

    await uploadFile(fl, await uplImg());
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('uploads/$fl')
        .getDownloadURL();
    showToast('uploaded successfully');
    return downloadURL;
  }

  i.File sampleImage;

//   uploadImage() async {
//     // HTML input element
//     InputElement uploadInput = FileUploadInputElement();
//     uploadInput.click();

//     uploadInput.onChange.listen(
//       (changeEvent) {
//         final file = uploadInput.files.first;
//         final reader = FileReader();

//         reader.readAsDataUrl(file);

//         reader.onLoadEnd.listen(
//           // After file finiesh reading and loading, it will be uploaded to firebase storage
//           (loadEndEvent) async {
//             uploadToFirebase(file);
//           },
//         );
//       },
//     );
//   }
// }
  /*final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
    return pickedFile.path;
  }*/

  Future<void> uploadImage() async {
    //File img = await pickImage();
    String url = await downloadURLExample();
    CollectionReference notifi =
        FirebaseFirestore.instance.collection('notifications');
    return notifi.add({'url': url});
  }
  // firebase_storage.FirebaseStorage storage =
  //     firebase_storage.FirebaseStorage.instance;

  // ignore: unused_field
  i.File _imageFile;
  //var timeKey = new DateTime.now();

  void showToast(String mg) {
    Fluttertoast.showToast(
        msg: mg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_LEFT,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.grey,
        textColor: Colors.black);
  }

  final _formKey = GlobalKey<FormState>();

  final villageCount = TextEditingController();
  final mpCount = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users =
      FirebaseFirestore.instance.collection('statcount');

  Future<void> addUser(int ct, int mp) {
    return users
        .doc('info')
        .update({'count': ct, 'mpCount': mp})
        .then((value) => showToast("Updated Successfully") //{
            //print("count Updated");
            // Fluttertoast.showToast(
            //     msg: "Successfully Updated",
            //     toastLength: Toast.LENGTH_SHORT,
            //     gravity: ToastGravity.CENTER,
            //     //timeInSecForIosWeb: 1,
            //     backgroundColor: Colors.red,
            //     textColor: Colors.white,
            //     fontSize: 16.0);
            //}
            )
        .catchError((error) {
          Fluttertoast.showToast(
              msg: "Failed to update",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.black,
              fontSize: 16.0);
        });
    // return users
    //     .add({'ct': 23})
    //     .then((value) => print("User Added"))
    //     .catchError((error) => print("Failed to add user: $error"));
  }

  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    villageCount.dispose();
    mpCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              //padding: const EdgeInsets.only(left: 150.0, top: 40.0),
              child: ElevatedButton(
                child: Text('  Upload Notifications Pics  '),
                onPressed: () {
                  //_submitForm();
                  uploadImage();
                  FocusScope.of(context).unfocus();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Divider(
          color: Colors.black,
          height: 10,
          thickness: 1,
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: villageCount,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter integer';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: const Icon(Icons.add_circle),
                  hintText: 'Enter no of villages Adapted',
                  labelText: 'Village count',
                ),
              ),
              TextFormField(
                controller: mpCount,
                validator: (value) {
                  if (value.isEmpty | (int.parse(value) > 99)) {
                    return 'Enter Valid count';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    //contentPadding: EdgeInsets.only(left: 16, right: 16),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(16.0),
                    // ),
                    icon: const Icon(Icons.calendar_today),
                    hintText: 'Enter your date of birth',
                    labelText: 'Mp count'),
              ),
            ],
          ),
        ),
        /*TextFormField(
          controller: mpCount,
          validator: (value) {
            if (value.isEmpty | (int.parse(value) > 99)) {
              return 'Enter Valid count';
            }
            return null;
          },
          /*decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 16, right: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              labelText: 'Email'),*/
          decoration: const InputDecoration(
            icon: const Icon(Icons.add_alert),
            contentPadding:
                                  EdgeInsets.only(left: 16, right: 16),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                              /*border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),*/
            //hintText: 'Enter number of Mps',
            labelText: 'Mp count',
          ),
        ),*/
        // TextFormField(
        //   decoration: const InputDecoration(
        //     icon: const Icon(Icons.calendar_today),
        //     hintText: 'Enter your date of birth',
        //     labelText: 'Dob',
        //   ),
        // ),
        new Container(
            padding: const EdgeInsets.only(left: 150.0, top: 40.0),
            child: new ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                addUser(int.parse(villageCount.text), int.parse(mpCount.text));
                mpCount.clear();
                villageCount.clear();
                FocusScope.of(context).unfocus();
              },
            )),
      ],
    );
  }
}
