import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mail_room/var/var.dart';
import '../Home_student.dart';
import 'Login.dart';

class Home_admin extends StatefulWidget {
  const Home_admin({Key? key}) : super(key: key);

  @override
  State<Home_admin> createState() => _Home_adminState();
}

class _Home_adminState extends State<Home_admin> {
  CollectionReference usersdata = FirebaseFirestore.instance
      .collection("User")
      .doc(user?.uid)
      .collection("Package");
  String date = DateTime.now().toString().substring(5, 7);
  String year = DateTime.now().toString().substring(0, 4);
  final String? kYellowColor = "lol";
  final String? pColor = "nothing";

  // Fetch content from the json file

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.deepPurple.shade200,
          title: const Text(
            'For You',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: SingleChildScrollView(
            child: StreamBuilder<DocumentSnapshot>(
                stream: usersdata
                    .doc("amount")
                    .collection(year)
                    .doc(int.parse(date).toString())
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasData) {
                    Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                    return Column(children: [
                      Stack(children: [
                        //stack overlaps widgets
                        Opacity(
                          //semi red clippath with more height and with 0.5 opacity
                          opacity: 0.5,
                          child: ClipPath(
                            clipper:
                            WaveClipper(), //set our custom wave clipper
                            child: Container(
                              color: Colors.deepPurple.shade400,
                              height: 350,
                            ),
                          ),
                        ),

                        ClipPath(
                          //upper clippath with less height

                            child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Container(
                                  height: 250,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 0, right: 6),
                                          child: SizedBox(
                                              width: 180.0,
                                              height: 250.0,
                                              child:Card(
                                                elevation: 2,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(24),
                                                  child: InkWell(
                                                    onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Home()),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        RichText(
                                                            text: TextSpan(
                                                              children: [
                                                                WidgetSpan(
                                                                    child: FaIcon(
                                                                      FontAwesomeIcons
                                                                          .boxesPacking,
                                                                      color: Colors.red,
                                                                      size: 30,
                                                                    )),
                                                              ],
                                                            )),
                                                        SizedBox(height: 25),
                                                        RichText(
                                                            text: TextSpan(
                                                                text:
                                                                'Total Package',
                                                                style: TextStyle(
                                                                  color:
                                                                  Colors.black,
                                                                  fontSize: 19,
                                                                ))),
                                                        SizedBox(height: 10),
                                                        Divider(
                                                          thickness: 1,
                                                        ),
                                                        RichText(
                                                            text: TextSpan(
                                                                text: '0',
                                                                style: TextStyle(
                                                                  color:
                                                                  Colors.black,
                                                                  fontSize: 30,
                                                                ))),
                                                        SizedBox(height: 10),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ))),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 6, right: 6),
                                          child:SizedBox(
                                              width: 180.0,
                                              height: 250.0,
                                              child: Card(
                                                elevation: 2,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(24),
                                                  child: InkWell(
                                                    onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Home()),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        RichText(
                                                            text: TextSpan(
                                                              children: [
                                                                WidgetSpan(
                                                                    child: FaIcon(
                                                                      FontAwesomeIcons
                                                                          .hand,
                                                                      color: Colors.red,
                                                                      size: 30,
                                                                    )),
                                                              ],
                                                            )),
                                                        SizedBox(height: 25),
                                                        RichText(
                                                            text: TextSpan(
                                                                text:
                                                                'Collected',
                                                                style: TextStyle(
                                                                  color:
                                                                  Colors.black,
                                                                  fontSize: 19,
                                                                ))),
                                                        SizedBox(height: 10),
                                                        Divider(
                                                          thickness: 1,
                                                        ),
                                                        RichText(
                                                            text: TextSpan(
                                                                text: '0',
                                                                style: TextStyle(
                                                                  color:
                                                                  Colors.black,
                                                                  fontSize: 30,
                                                                ))),
                                                        SizedBox(height: 10),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ) ))
                                    ],
                                  ),
                                ))),
                      ]),
                      Column(children: [
                        Padding(
                            padding: const EdgeInsets.all(12),
                            child: Container(
                                height: 175,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: SizedBox(
                                            width: 170.0,
                                            height: 175.0,
                                            child: Card(
                                              elevation: 2,
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(20),

                                                child: InkWell(
                                                  onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => const Home()),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      RichText(
                                                          text: const TextSpan(
                                                            children: [
                                                              WidgetSpan(
                                                                child: Center(
                                                                    child:FaIcon(
                                                                      FontAwesomeIcons.plus,
                                                                      color: Colors.deepPurpleAccent,
                                                                      size: 30,
                                                                    )),),
                                                            ],
                                                          )),
                                                      const Divider(
                                                        thickness: 1,
                                                      ),
                                                      const SizedBox(height: 10),
                                                      Center(
                                                        child:RichText(
                                                          text: const TextSpan(
                                                              text: 'INCOME',
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 19,
                                                              )),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ), //Center
                                              ),
                                            ) //Card
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: SizedBox(
                                            width: 170.0,
                                            height: 175.0,
                                            child: Card(
                                              elevation: 2,
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(20),

                                                child: InkWell(
                                                  onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => const Home()),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      RichText(
                                                          text: const TextSpan(
                                                            children: [
                                                              WidgetSpan(
                                                                child: Center(
                                                                    child:FaIcon(
                                                                      FontAwesomeIcons.minus,
                                                                      color: Colors.deepPurpleAccent,
                                                                      size: 30,
                                                                    )),),
                                                            ],
                                                          )),
                                                      const Divider(
                                                        thickness: 1,
                                                      ),
                                                      SizedBox(height: 10),
                                                      Center(
                                                        child:RichText(
                                                          text: const TextSpan(
                                                              text: 'EXPENSE',
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 19,
                                                              )),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ), //Center
                                              ),
                                            ) //Card
                                        ),
                                      ),
                                    ]))),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: package(),
                        ),
                      ])
                    ]);
                  }
                  return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 245),
                        child: CircularProgressIndicator(),
                      ));
                })));
  }

}

//Costom CLipper class with Path
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
    Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
