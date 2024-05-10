import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseintro/screens/loginpage.dart';
import 'package:firebaseintro/models/user_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    _requestNotificationPermission();
    super.initState();
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _updateUserAvatar() async {
    User? loggedInUser = FirebaseAuth.instance.currentUser;

    if (loggedInUser != null && _image != null) {
      
      String imageUrl = await uploadImageToStorage(loggedInUser.uid, _image!);
      

      
      FirebaseFirestore.instance
          .collection('users')
          .doc(loggedInUser.uid)
          .update({'avatarUrl': imageUrl})
          .then((value) => print("Avatar güncellendi"))
          .catchError((error) => print("Hata: $error"));

    }
  }

  Future<String> uploadImageToStorage(String userId, File imageFile) async {
    final storageReference =
        FirebaseStorage.instance.ref().child('avatars/$userId/avatar.jpg');
    final uploadTask = storageReference.putFile(imageFile);
    await uploadTask;
    final downloadURL = await storageReference.getDownloadURL();
    return downloadURL;
  }

  Future<UserModel> _getUser() async {
    User? loggedInUser = FirebaseAuth.instance.currentUser;

    if (loggedInUser != null) {
      final db = FirebaseFirestore.instance;

      final userInfo = await db.collection("users").doc(loggedInUser.uid).get();
      final userJson = userInfo.data();
      final userModel = UserModel.fromMap(userJson!);

      // if(userJson.containsKey('avatarURL')) {
      //   userModel.avatarURL = userJson['avatarURL'];
      // }

      return userModel;
    }
    throw Exception("");
  }

  void _requestNotificationPermission() async {
    FirebaseMessaging fcm = FirebaseMessaging.instance;
   final permisson = await fcm.requestPermission();

   if(permisson.authorizationStatus == AuthorizationStatus.authorized) {

    //FCM TOKEN ALMAM LAZIM
    final token = await fcm.getToken();

    await fcm.subscribeToTopic("mobil1a");

    User? loggedInUser = FirebaseAuth.instance.currentUser;

    if(loggedInUser != null) {
      FirebaseFirestore.instance
      .collection('users')
      .doc(loggedInUser.uid)
      .update({'token' : token})
      .then((value) => print("Token Guncellendi"))
      .catchError((error) => print("Token güncellenirken hata: $error"));
    }

    fcm.onTokenRefresh.listen((token) {
      //update token in db.
     });
    print("Firebase tokennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn: $token" );
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Ana Sayfa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? const Text('Resim Seçilmedi')
                : CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(_image!),
                  ),
            ElevatedButton(
              onPressed: getImage,
              child: const Text('Resim Seç'),
            ),
            ElevatedButton(
              onPressed: _updateUserAvatar,
              child: const Text('Güncelle'),
            ),
            FutureBuilder(
              future: _getUser(),
              builder: (context, AsyncSnapshot<UserModel> snapshot) {
                if (!snapshot.hasData) {
                  return const Text("Veri Yükleniyor..");
                } else {
                  return Text(
                    "Hoşgeldiniz ${snapshot.data!.name} ${snapshot.data!.lname} !!!",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
