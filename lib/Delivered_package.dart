import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mail_room/var/var.dart';
import 'package:sidebarx/sidebarx.dart';

import 'charts/check.dart';
import 'drawer/sidebar.dart';
class delivered extends StatefulWidget {
  const delivered({Key? key}) : super(key: key);

  @override
  State<delivered> createState() => _deliveredState();
}

class _deliveredState extends State<delivered> {
  final _controller = SidebarXController(selectedIndex: 3, extended: true);
  final _key = GlobalKey<ScaffoldState>();

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
      key: _key,
      backgroundColor: Color(0xffC86733),
      appBar: AppBar(
        backgroundColor: Color(0xf2C86733),
        bottomOpacity: 0,
        elevation: 0,
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: () {
            _controller.setExtended(true);
            _key.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                  colors: [Color(0xf2C86733),Color(0xf2FFE5B4)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      drawer: ExampleSidebarX(controller: _controller),
      body: SingleChildScrollView(
        child:  Stack(
            children: <Widget>[SizedBox(
            height: 120,
            child: Stack(
                children: [
                  Positioned(
                      bottom: 10,
                      left: 0,
                      right: -2,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/curve.png'),
                              fit: BoxFit.cover,
                            )),
                      )),
                  Positioned(
                    bottom: 8,
                    right: 50,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet<dynamic>(
                            backgroundColor: Colors.transparent,
                            barrierColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height - 150,
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height - 130,
                                        color: const Color(0xffeef1f4).withOpacity(0.7),
                                      ),
                                    ),
                                    Positioned(
                                      top: 4,
                                      right: 50,
                                      child: Container(
                                        width: 60,
                                        height: 250,
                                        padding: const EdgeInsets.only(top: 5, bottom: 25),
                                        decoration: BoxDecoration(
                                          color: Color(0xffC86733),
                                          borderRadius: BorderRadius.circular(29),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppButton(
                                                backgroundColor: Colors.white,
                                                iconColor: ColorPalette.mainColor,
                                                textColor: Colors.white,
                                                iconData: Icons.cancel,
                                                onTap: () {
                                                  Navigator.pop(context);
                                                }),
                                            AppButton(
                                                text: 'Clear',
                                                backgroundColor: Colors.white,
                                                iconColor: ColorPalette.mainColor,
                                                textColor: Colors.white,
                                                iconData: Icons.delete,
                                                onTap: () {
                                                  parcel.clear();
                                                  Package_list(dropdownvalue_class);
                                                  Navigator.pop(context);
                                                }),
                                            AppButton(
                                                text: 'History',
                                                backgroundColor: Colors.white,
                                                iconColor: ColorPalette.mainColor,
                                                textColor: Colors.white,
                                                iconData: Icons.history_rounded,
                                                onTap: () {
                                                  Navigator.pop(context);
                                                })
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            image:
                            const DecorationImage(image: AssetImage('assets/images/lines.png')),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 9,
                                offset: const Offset(0, 1),
                                color: const Color(0xffC86733).withOpacity(0.2),
                              )
                            ]),
                      ),
                    ),
                  ),
                  Stack(
                    children: const [
                      Positioned(
                        left: 40,
                        top: 10,
                        child: Text(
                          'Packages',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                      ),
                      Positioned(
                        left: 17,
                        top: 30,
                        child: Text(
                          'Packages',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff293952),
                          ),
                        ),
                      ),
                    ],
                  )]
            )
        ),Column(children:[
        const SizedBox(height: 110),
        SingleChildScrollView(
            child:Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 214,
              ),
          decoration: const BoxDecoration(
            color: Color(0xf2FFE5B4),
          ),
          child: Column(
              children:[
                SizedBox(
                  height: 20,
                ),Padding(
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
      ),)

      ])])));
  }

}
