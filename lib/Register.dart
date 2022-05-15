import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mail_room/Login.dart';

import 'Home_admin.dart';
import 'Home_student.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  @override
  Widget build(BuildContext context) {


    //TODO update what details you want
    //test feild state
    String mode="Admin";
    var items =  ["___Select Role___","STUDENT","ADMIN"];
    String? email;
    String? password;
    String cllgname = "";
    String city = "";
    String rollnumber = "";

    //for showing loading
    bool loading = false;

    // this below line is used to make notification bar transparent
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            //TODO update this
            'assets/images/background.png',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(.9),
                      Colors.black.withOpacity(.1),
                    ])),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 27.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Stack(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              height: 22,
                              width: 22,
                              child: Icon(
                                Icons.email,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        )),
                    Container(
                        height: 50,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.white70
                              )
                          ),
                          style: TextStyle(fontSize: 16,
                              color: Colors.white),
                          onChanged: (value)=>email=value,
                        )),
                  ],
                ),
                //city
                SizedBox(
                  height: 16,
                ),
                //TODO remove unwanted containers
                Stack(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              height: 22,
                              width: 22,
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        )),
                    Container(
                        height: 50,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'Roll Number',
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.white70
                              )
                          ),
                          style: TextStyle(fontSize: 16,
                              color: Colors.white),
                          onChanged: (value)=>rollnumber=value,
                        )),
                  ],
                ),
                //college
                SizedBox(
                  height: 16,
                ),
                Stack(
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.only(left:16,right:16),
                      child:CustomRadioButton(
                        width: 170,
                        unSelectedBorderColor: Colors.black,
                        selectedBorderColor: Colors.white,
                        buttonTextStyle: ButtonTextStyle(
                          selectedColor: Colors.white,
                          unSelectedColor: Colors.black,
                          textStyle: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        autoWidth: false,
                        enableButtonWrap: true,
                        wrapAlignment: WrapAlignment.center,
                        unSelectedColor: Colors.transparent,
                        buttonLables: const [
                          "ADMIN",
                          "STUDENT",
                        ],
                        buttonValues: const [
                          "Admin",
                          "Student"
                        ],
                        radioButtonValue: (values) {
                          mode=values.toString();
                        },
                        defaultSelected: "Admin",
                        horizontal: false,
                        //width: 120,
                        // hight: 50,
                        selectedColor: Colors.transparent,
                        padding: 2,
                        enableShape: true,
                      ),
                    ),

                    ]
                    ),
                SizedBox(
                  height: 16,
                ),
                Stack(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              height: 22,
                              width: 22,
                              child: Icon(
                                Icons.vpn_key,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        )),
                    Container(
                        height: 50,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: TextField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.white70
                            ),
                          ),
                          style: TextStyle(fontSize: 16,
                              color: Colors.white),
                          onChanged: (value)=>password=value,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap :()  {
                    print(email);
  print(mode);
                    _signupUser(email, password,mode,rollnumber);


                  },
                  child:Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Center(
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black),
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Center(
                      child: Text(
                        "Already have an account",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white),
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50)
                    ),
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Future<String?> _signupUser(emailid,passwordid,dropdown,roll ) async {
    String? email_id = emailid;
    String? password_id = passwordid;

      try {
        await _auth.createUserWithEmailAndPassword(
            email: email_id!, password: password_id!);
        user = _auth.currentUser;
      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          final snackbar = SnackBar(
            content: const Text('email-already-in-use'),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .hideCurrentSnackBar();
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
        if (e.code == 'invalid-email') {
          final snackbar = SnackBar(
            content: const Text('invalid-email'),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .hideCurrentSnackBar();
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
        if (e.code == 'operation-not-allowed') {
          final snackbar = SnackBar(
            content: const Text('operation-not-allowed'),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .hideCurrentSnackBar();
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
        if (e.code == 'weak-password') {
          final snackbar = SnackBar(
            content: const Text('weak-password'),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .hideCurrentSnackBar();
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      }
      String date = DateTime.now().toString().substring(0, 9);
      String year = DateTime.now().toString().substring(0, 4);
      String? id = user?.uid;
      if (user != null && dropdown == "Student" && roll != "") {
        DocumentReference ref = FirebaseFirestore.instance
            .collection('User').doc(id);
        ref.set({
          'email': email_id,
          'uid': id,
          'roll': roll,
          'type': dropdown,
        });
        DocumentReference ref1 = FirebaseFirestore.instance
            .collection('User').doc(user?.uid).collection("Package").doc(
            year);
        ref1.set({
          "Package": 0,
          "Delivered": 0,
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
      if (user != null && dropdown == "Admin") {
        DocumentReference ref = FirebaseFirestore.instance
            .collection('User').doc(id);
        ref.set({
          'email': email_id,
          'uid': id,
          'type': dropdown,
        });
        DocumentReference ref1 = FirebaseFirestore.instance
            .collection('User').doc(user?.uid).collection("Package").doc(
            year);
        ref1.set({
          "Package": 0,
          "Delivered": 0,
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home_admin()),
        );
      }


  }
  }