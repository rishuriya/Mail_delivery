import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';


import 'Login.dart';
class add_package extends StatefulWidget {
  const add_package({Key? key}) : super(key: key);

  @override
  State<add_package> createState() => _add_packageState();
}

class _add_packageState extends State<add_package> {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  CollectionReference users = FirebaseFirestore.instance.collection("User").doc(user?.uid).collection("Package");
  String date=DateTime.now().toString().substring(0, 10);
  String day=DateTime.now().toString().substring(8, 10);
  String month=DateTime.now().toString().substring(5, 7);
  String year=DateTime.now().toString().substring(0, 4);
  late DateTime _selectedDate;
  String Name='' ;
  String roll='';
  String dropdownvalue_ecom = '___Select Evendor___';
  String dropdownvalue_class = '___Select Batch___';
  var Evendor =  ["___Select Evendor___","Amazon","Flipkart","Meesho","Mytra","Courier","Others"];
  var batch =  ["___Select Batch___","CSE","AIE","EEE","ELC","ECE","ME"];
  final _amount = TextEditingController();

  void clearText() {
    _amount.clear();
  }

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'ADD PACKAGE',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                          width: 400.0,
                          height: 200.0,
                          child: Card(
                              elevation: 2,
                              shadowColor: Colors.black,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: CalendarTimeline(
                                    showYears: true,
                                    initialDate: _selectedDate,
                                    firstDate:
                                    DateTime.now().subtract(Duration(days: 7)),
                                    lastDate: DateTime.now().add(Duration(days: 1095)),
                                    onDateSelected: (date) {
                                      setState(() {
                                        _selectedDate = date!;
                                      });
                                    },
                                    leftMargin: 0,
                                    monthColor: Colors.black87,
                                    dayColor: Colors.black,
                                    dayNameColor: Colors.white,
                                    activeDayColor: Colors.white,
                                    activeBackgroundDayColor: Colors.deepPurpleAccent,
                                    dotsColor: Colors.white,
                                    selectableDayPredicate: (date) => date.day != 23,
                                    locale: 'en',
                                  ),
                                ),
                              ))),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16,),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        ),
                        value: dropdownvalue_class,
                        hint: const Text("Source"),
                        icon: Icon(Icons.keyboard_arrow_down),

                        items: batch.map((String items) {
                          return DropdownMenuItem(
                              value: items,
                              child: Text(items)
                          );
                        }
                        ).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            dropdownvalue_class = newValue.toString();
                          });
                        },

                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16,),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        ),
                        value: dropdownvalue_ecom,
                        hint: const Text("Source"),
                        icon: Icon(Icons.keyboard_arrow_down),

                        items: Evendor.map((String items) {
                          return DropdownMenuItem(
                              value: items,
                              child: Text(items)
                          );
                        }
                        ).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            dropdownvalue_ecom = newValue.toString();
                          });
                        },

                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16,),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0))),
                          labelText: 'Name',
                          hintText: 'Name',
                        ),
                        onChanged: (value) => Name = value,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16,),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0))),
                          labelText: 'Roll Number',
                          hintText: 'Roll Number',
                        ),
                        onChanged: (value) => roll = value,
                      ),
                    ),
                  ],
                ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () async {


          //List data=users.doc("amount").collection(year).doc(date).get() as List;

          if(Name!='' && roll!="" && dropdownvalue_class!='___Select Batch___') {
            String? id = DateTime.now().toString()+roll;
            users.doc("list").collection(dropdownvalue_class).doc(id)
            .set({
              'Day': id.substring(0, 10),
              'Batch': dropdownvalue_class,
              'Name': Name,
              'Roll': roll,
              'Evendor': dropdownvalue_ecom,
              'type': 'ARRIVED',
              "id":id,
            });
            late int? package_admin=0;
            late int? Delivered_admin=0;
            var collection_admin = FirebaseFirestore.instance.collection('User').doc(user?.uid).collection("Package");
            var querySnapshot_admin = await collection_admin.get();
            for (var queryDocumentSnapshot in querySnapshot_admin.docs) {
              var data_admin = queryDocumentSnapshot.data();
              if(data_admin["Year"] == year){
          package_admin = data_admin['Package']!;
          Delivered_admin=data_admin["Delivered"];
          }
            }
            package_admin=package_admin!+1;
            users.doc(year)
                .set({
              "Year":year,
              "Package": package_admin,
              "Delivered": Delivered_admin,
            });
            package_admin=0;
            Delivered_admin;
            var querySnapshot_month_admin = await collection_admin.doc(year).collection("months").get();
            for (var queryDocumentSnapshot in querySnapshot_month_admin.docs) {
              var data_admin = queryDocumentSnapshot.data();
              if(data_admin["Month"] == month){
                package_admin = data_admin['Package']!;
                Delivered_admin=data_admin["Delivered"];
              }
            }
            package_admin=package_admin!+1;
            print(package_admin);
            users.doc(year).collection("months").doc(month)
                .set({
              "Month":month,
              "Package": package_admin,
              "Delivered": Delivered_admin,
            });
            package_admin=0;
            Delivered_admin;
            var querySnapshot_day_admin = await collection_admin.doc(year).collection("months").doc(month).collection("Days").get();
            for (var queryDocumentSnapshot in querySnapshot_day_admin.docs) {
              var data_admin = queryDocumentSnapshot.data();
              if(data_admin["Date"] == day){
                package_admin = data_admin['Package']!;
                Delivered_admin=data_admin["Delivered"];
              }
            }
            package_admin=package_admin!+1;
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
              if(data["roll"]==roll) {
                sid = data['uid'];
                email=data['email'];
              }
            }
            if(sid==null){
              final snackbar = SnackBar(
                content: const Text('Invalid Roll number'),
                action: SnackBarAction(
                  label: 'OK',
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .hideCurrentSnackBar();
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }else{
              DocumentReference ref = FirebaseFirestore.instance
                  .collection('User').doc(sid).collection('Package').doc(id);
              ref.set({
                'Day': id.substring(0, 10),
                'Batch': dropdownvalue_class,
                'Name': Name,
                'Roll': roll,
                'Evendor': dropdownvalue_ecom,
                'type': 'ARRIVED',
                "id":id,
              });
              final Email send_email = Email(
                body: 'The Mail department want to inform ${roll} that your parcel by Vendor ${dropdownvalue_ecom} is received at mail department, Kindly come and receive your parcel.',
                subject: 'Regarding Parcel',
                recipients: [email],
                isHTML: false,
              );

              await FlutterEmailSender.send(send_email);
              print(sid);
              late int? package_std=0;
              late int? Delivered_std=0;
              var collection_std = FirebaseFirestore.instance.collection('User').doc(sid).collection("Package");
              var querySnapshot_std = await collection_std.get();
              for (var queryDocumentSnapshot in querySnapshot_std.docs) {
                var data_std = queryDocumentSnapshot.data();
                if (data_std['Package'] != null && data_std["Delivered"] != null && data_std["Year"]==year) {
                  package_std = data_std['Package']!;
                  Delivered_std=data_std['Delivered']!;
                }

              }
              package_std=package_std!+1;
              FirebaseFirestore.instance
                  .collection('User').doc(sid).collection('Package').doc(year)
                  .set({
                "Year":year,
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
              package_std=package_std!+1;
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
              package_std=package_std!+1;
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
                  ScaffoldMessenger.of(context)
                      .hideCurrentSnackBar();
                  Navigator.pop(
                      context);
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }else{
            final snackbar = SnackBar(
              content: const Text('All field are mandatory!'),
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

          print("refresh done ");

        },
        icon: const Icon(Icons.save),
        label: const Text("Save"),
      ),
    );
  }
}
