import 'package:flutter/material.dart';
import 'package:mail_room/var/var.dart';
class delivered extends StatefulWidget {
  const delivered({Key? key}) : super(key: key);

  @override
  State<delivered> createState() => _deliveredState();
}

class _deliveredState extends State<delivered> {
  String dropdownvalue_ecom = '___Select Evendor___';
  String dropdownvalue_class = '___Select Batch___';
  var Evendor =  ["___Select Evendor___","Amazon","Flipkart","Meesho","Mytra","Courier","Others"];
  var batch =  ["___Select Batch___","CSE","AIE","EEE","ELC","ECE","ME"];


  @override
  void initState() {
    super.initState();
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
          'PACKAGE ',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
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
              child: Package_list(dropdownvalue_class),
            ),
          ],
        ),
      ),
      
    );
  }

}
