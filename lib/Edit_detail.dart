import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mail_room/var/var.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'Login.dart';

class edit_package extends StatefulWidget {
  const edit_package({Key? key}) : super(key: key);

  @override
  State<edit_package> createState() => _edit_packageState();
}

class _edit_packageState extends State<edit_package> {
  String vendor = "";
  String digiid = '';
  String des = "";
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  CollectionReference users = FirebaseFirestore.instance
      .collection("User")
      .doc(user?.uid)
      .collection("Package")
      ;
  String date = DateTime.now().toString().substring(0, 10);
  String year = DateTime.now().toString().substring(0, 4);
  String day=DateTime.now().toString().substring(8, 10);
  String month=DateTime.now().toString().substring(5, 7);

  late DateTime _selectedDate;
  String Name = '';
  String roll = '';
  String croll = '';
  String dropdownvalue = '___Select___';
  String dropdownvalue_class = '___Select Batch___';
  var Evendor = [
    "___Select___",
    "Collected",
    "Returned",
  ];
  final _amount = TextEditingController();

  void clearText() {
    _amount.clear();
  }

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
    print(did);
    print(p_batch);
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
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
            stream: users.doc("list")
                .collection(p_batch).doc(did).snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
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
                vendor = data['Evendor'];
                digiid = data["id"];
                Name = data["Name"];
                roll = data["Roll"];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          labelText: 'Description',
                          hintText: 'Description',
                        ),
                        onChanged: (value) => des = value,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          labelText: 'Confirm Roll Number',
                          hintText: ' Confirm Roll Number',
                        ),
                        onChanged: (value) => croll = value,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                        ),
                        value: dropdownvalue,
                        hint: const Text("delivered"),
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: Evendor.map((String items) {
                          return DropdownMenuItem(
                              value: items, child: Text(items));
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            dropdownvalue = newValue.toString();
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                );
              }
              return const Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 245),
                child: CircularProgressIndicator(),
              ));
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () async {
          String? id = _selectedDate.toString() + DateTime.now().toString();
          if (croll == roll) {
            users.doc("list").collection(p_batch).doc(digiid).set({
              'Day': id.substring(0, 10),
              'Batch': p_batch,
              'Name': Name,
              'Roll': roll,
              'Evendor': vendor,
              'type': dropdownvalue,
              "description": des,
              "id": digiid,
            });
            late int? Delivered_admin = 0;
            late int? package_admin;
            var collection_admin = FirebaseFirestore.instance
                .collection('User')
                .doc(user?.uid)
                .collection("Package");
            var querySnapshot_admin = await collection_admin.get();
            for (var queryDocumentSnapshot in querySnapshot_admin.docs) {
              var data_admin = queryDocumentSnapshot.data();
              if(data_admin["Year"] == year) {
                package_admin = data_admin["Package"];
                Delivered_admin = data_admin['Delivered']!;
              }
            }
            Delivered_admin = Delivered_admin! + 1;
            users.doc(year).set({
              "Year":year,
              "Package": package_admin!,
              "Delivered": Delivered_admin,
            });
            package_admin;
            Delivered_admin=0;
            var querySnapshot_month_admin = await collection_admin.doc(year).collection("months").get();
            for (var queryDocumentSnapshot in querySnapshot_month_admin.docs) {
              var data_admin = queryDocumentSnapshot.data();
              if(data_admin["Month"] == month){
                package_admin = data_admin['Package']!;
                Delivered_admin=data_admin["Delivered"];
              }
            }
            Delivered_admin = Delivered_admin! + 1;
            users.doc(year).collection("months").doc(month)
                .set({
              "Month":month,
              "Package": package_admin,
              "Delivered": Delivered_admin,
            });
            package_admin;
            Delivered_admin=0;
            var querySnapshot_day_admin = await collection_admin.doc(year).collection("months").doc(month).collection("Days").get();
            for (var queryDocumentSnapshot in querySnapshot_day_admin.docs) {
              var data_admin = queryDocumentSnapshot.data();
              if(data_admin["Date"] == day){
                package_admin = data_admin['Package']!;
                Delivered_admin=data_admin["Delivered"];
              }
            }
            Delivered_admin = Delivered_admin! + 1;
            users.doc(year).collection("months").doc(month).collection("Days")
                .doc(day)
                .set({
              "Date":day,
              "Package": package_admin,
              "Delivered": Delivered_admin,
            });
            late String sid;
            late String email;
            var collection = FirebaseFirestore.instance.collection('User');
            var querySnapshot = await collection.get();
            for (var queryDocumentSnapshot in querySnapshot.docs) {
              var data = queryDocumentSnapshot.data();
              if (data["roll"] == roll) {
                sid = data['uid'];
                email=data['email'];
              }
            }

            if (sid == null) {
              final snackbar = SnackBar(
                content: const Text('Invalid Roll number'),
                action: SnackBarAction(
                  label: 'OK',
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            } else {
              DocumentReference ref = FirebaseFirestore.instance
                  .collection('User')
                  .doc(sid)
                  .collection('Package')
                  .doc(digiid);
              ref.set({
                'Day': id.substring(0, 10),
                'Batch': p_batch,
                'Name': Name,
                'Roll': roll,
                'Evendor': vendor,
                'type': dropdownvalue,
                "description": des,
                "id": digiid,
              });

              final Email send_email = Email(
                body: 'The Mail department want to inform ${roll} that your parcel is collected  ${des}',
                subject: 'Regarding Parcel',
                recipients: [email],
                isHTML: false,
              );

              await FlutterEmailSender.send(send_email);

              print(sid);
              late int? package_std;
              late int? Delivered_std;
              var collection_std = FirebaseFirestore.instance
                  .collection('User')
                  .doc(sid)
                  .collection("Package");
              var querySnapshot_std = await collection_std.get();
              for (var queryDocumentSnapshot in querySnapshot_std.docs) {
                var data_std = queryDocumentSnapshot.data();
                if (data_std['Package'] != null &&
                    data_std["Delivered"] != null) {
                  package_std = data_std['Package']!;
                  Delivered_std = data_std['Delivered']!;
                }
              }
              Delivered_std = Delivered_std! + 1;
              FirebaseFirestore.instance
                  .collection('User')
                  .doc(sid)
                  .collection('Package')
                  .doc(year)
                  .set({
                "Package": package_std,
                "Delivered": Delivered_std,
              });
              package_std=0;
              Delivered_std=0;
              querySnapshot_std = await collection_std.doc(year).collection("months").get();
              for (var queryDocumentSnapshot in querySnapshot_std.docs) {
                var data_std = queryDocumentSnapshot.data();
                if (data_std['Package'] != null && data_std["Delivered"] != null && data_std["Month"]==month) {
                  package_std = data_std['Package']!;
                  Delivered_std=data_std['Delivered']!;
                }

              }
              Delivered_std = Delivered_std! + 1;
              FirebaseFirestore.instance
                  .collection('User').doc(sid).collection('Package').doc(year).collection("months").doc(month)
                  .set({
                "Month":month,
                "Package": package_std,
                "Delivered": Delivered_std,
              });
              package_std=0;
              Delivered_std=0;
              querySnapshot_std = await collection_std.doc(year).collection("months").doc(month).collection("Days").get();
              for (var queryDocumentSnapshot in querySnapshot_std.docs) {
                var data_std = queryDocumentSnapshot.data();
                if (data_std['Package'] != null && data_std["Delivered"] != null && data_std["Date"]==day) {
                  package_std = data_std['Package']!;
                  Delivered_std=data_std['Delivered']!;
                }

              }
              Delivered_std = Delivered_std! + 1;
              FirebaseFirestore.instance
                  .collection('User').doc(sid).collection('Package').doc(year).collection("months").doc(month).collection("Days").doc(day)
                  .set({
                "Date":day,
                "Package": package_std,
                "Delivered": Delivered_std,
              });
            }
            final snackbar = SnackBar(
              content: const Text('Transaction Stored!'),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  Navigator.pop(context);
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          } else {
            final snackbar = SnackBar(
              content: const Text('Roll number not matched!'),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        },
        icon: const Icon(Icons.save),
        label: const Text("Save"),
      ),
    );
  }
}
