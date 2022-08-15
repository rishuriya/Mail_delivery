import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mail_room/Edit_detail.dart';
import 'package:mail_room/Home_student.dart';
import 'package:mail_room/var/var.dart';

class Package extends StatelessWidget {
  final String? student;
  final String? roll;
  final String? ecom;
  final String? status;
  final String? date;
  final String? id;
  final String? batch;

  Package(this.student,
      this.roll,
      this.ecom,
      this.status,
      this.date,
      this.id,
      this.batch,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          parcel.clear();
          did=id!;
          p_batch=batch!;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const edit_package()),
          );
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xf2C86733).withOpacity(0.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FutureBuilder(
              builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    isThreeLine: false,
                    title: Text(status!),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Padding(padding: EdgeInsets.only(top: 0),
                          child: Text(student!),),
                          Padding(padding: EdgeInsets.only(top: 0),
                            child: Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(top: 0, right: 12),
                                      child: Text(date!)
                                  ),
                                ]),)
                        ]),
                    trailing: Column(
                        children: [Padding(padding: EdgeInsets.only(top: 5),
                            child: Text(ecom!)),
                          Padding(padding: EdgeInsets.only(top: 5),
                            child: Text(
                              roll!,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black38),
                            ),),
                        ]),

                  ),
                );
              }
          ),
        )
    ); }



}