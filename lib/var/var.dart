import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Login.dart';
import '../model.dart';


int? in_hand=0;
int? in_bank =0;
int? income=0;
int? expenditure =0;
List<Package> token = [Package( 0,"", " ","","","RECENT TRANSACTIONS")];
package() {
  String? uid=user?.uid;
  return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('User').doc(uid).collection('Transaction').orderBy("Day",descending: true).get(),
      builder: (context, snapshot) {
        if(snapshot.data != null){
          for (var element in snapshot.data!.docs) {
            try{
              token.add(Package(element['Amount'],element['Day'], element['Mode'],
                  element['Remark'],element['Source'], element['type']));
            }catch (e){
              continue;
            }
          }
          token.removeAt(0);
          print(token.length);
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
                        token[index].amount,
                        token[index].date,
                        token[index].mode,
                        token[index].remark,
                        token[index].source,
                        token[index].type,

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