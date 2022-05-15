import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mail_room/Home_student.dart';

import 'Home_admin.dart';
import 'Login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    _navigateToHome();
  }

  _navigateToHome()async{
    await Future.delayed(const Duration(milliseconds: 5000));
    user =FirebaseAuth.instance.currentUser;
    if(user !=null)
      {
    late String role;
    var collection = FirebaseFirestore.instance.collection('User');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      var data = queryDocumentSnapshot.data();
      if(data["uid"]==user?.uid) {
        role = data['type'].toString();
      }
    }
    print(role);
    if (role=="Student") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
    else if (user != null && role=="Admin") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home_admin()),
      );
    }}else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(
                padding: const EdgeInsets.only(top:350,bottom:75),
                child:FaIcon(
                  FontAwesomeIcons.envelope,
                  color: Colors.deepPurpleAccent,
                  size: 150,
                )
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child:SpinKitFadingCube(
                color: Colors.yellow.shade300,
                size: 30.0,
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.deepPurple.shade200,
    );
  }
}
