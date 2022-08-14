import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../Edit_detail.dart';
import '../Login.dart';
import '../model.dart';
List roll_no=[];
String did="";
String p_batch="";
List<FlSpot> chart1=[];
List<FlSpot> chart2=[];
String day=DateTime.now().toString().substring(8, 10);
int maxy1_1=0;
int maxy1_2=0;
int maxy1=0;
rolls() async {
  late String role;
  var collection = FirebaseFirestore.instance.collection('User');
  var querySnapshot = await collection.get();
  for (var queryDocumentSnapshot in querySnapshot.docs) {
    int i=0;
    var data = queryDocumentSnapshot.data();
      role = data['uid'].toString();
      roll_no.insert(i, role);
      i=i+1;
  }

  print(roll_no);
}
List<Package> token = [Package("","","","","","","")];
package() {
  String? uid=user?.uid;
  return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('User').doc(uid).collection('Package').orderBy("Day",descending: true).get(),
      builder: (context, snapshot) {
        if(snapshot.data != null){
          for (var element in snapshot.data!.docs) {
            try{
              token.add(Package(element['Name'],element['Roll'], element['Evendor'],
                  element['type'],element["Day"],element["id"],element["Batch"]));
            }catch (e){
              continue;
            }
          }
          int i=token.length;
          if(i>=1)
          token.removeAt(0);
        }

        return  Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: (token.length<=11)?token.length:11,
                  itemBuilder: (context, index) {
                    return Column(
                      children: (snapshot.data != null) ? ([Package(
                        token[index].student,
                        token[index].roll,
                        token[index].ecom,
                        token[index].status,
                        token[index].date,
                        token[index].id,
                        token[index].batch
                      ),
                        const SizedBox(height: 10,)
                      ]) : ([const CircularProgressIndicator()]),
                    );
                  },
                ),
                const SizedBox(height: 80),
              ],
            )
        );
      });
}
List<Package> parcel = [Package("Name","Status","Vendor","Type","Date","","")];
Package_list(String batch) {
  if(parcel.length>=1){
    List<Package> parcel = [Package("Name","Status","Vendor","Type","Date","","")];
  }
  String? uid = user?.uid;
  return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('User').doc(uid).collection('Package').doc("list").collection(batch).get(),
      builder: (context, snapshot) {
        if(snapshot.data != null){
          for (var element in snapshot.data!.docs) {
            try{
              parcel.add(Package(element['Name'],element['Roll'], element['Evendor'],
                  element['type'],element["Day"],element["id"],element["Batch"]));
            }catch (e){
              continue;
            }
          }
            int i = parcel.length;
          print(parcel);
          }else if(snapshot.data==null){
            print("hgcghfghj");
          }
  if (snapshot.hasError) {
    print("error");
  }
          return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: (parcel.length <= 11) ? parcel.length : 11,
                    itemBuilder: (context, index) {
                      return Column(
                        children: (snapshot.data != null) ? ([Package(
                            parcel[index].student,
                            parcel[index].roll,
                            parcel[index].ecom,
                            parcel[index].status,
                            parcel[index].date,
                          parcel[index].id,
                          parcel[index].batch,
                        ),
                          const SizedBox(height: 10,)
                        ]) : ([const Text("Choose Batch",
                        style: TextStyle(
                          fontSize: 25,
                        ),),
                          CircularProgressIndicator()]),
                      );
                    },
                  ),
                  const SizedBox(height: 80),
                ],
              )
          );
        });
  }
