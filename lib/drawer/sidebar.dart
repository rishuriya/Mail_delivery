import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mail_room/Delivered_package.dart';
import 'package:mail_room/Edit_detail.dart';
import 'package:mail_room/Home_admin.dart';
import 'package:mail_room/Home_student.dart';
import 'package:mail_room/charts/check.dart';
import 'package:sidebarx/sidebarx.dart';

import '../package_add.dart';
class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.black.withOpacity(1)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white38.withOpacity(1),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.black,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 180,
          child:Column( children:[Padding(
            padding: const EdgeInsets.only(top:40,bottom: 0,left: 16,right: 16),
            child: CircleAvatar(child:Image.asset('assets/images/avtar.png'),
            radius: 62,)
          ),
          const Divider(),])
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
      onTap: () =>Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const Home_admin()),
      ),
        ),
        const SidebarXItem(
          icon: Icons.search,
          label: 'Search',
        ),
        SidebarXItem(
          icon: Icons.question_answer_rounded,
          label: 'Query',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Home()),
          ),
        ),
        SidebarXItem(
          icon: Icons.add_box,
          label: 'Add Package',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const add_package()),
          ),
        ),SidebarXItem(
          icon: Icons.read_more,
          label: 'Change Status',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const delivered()),
          ),
        ),
        const SidebarXItem(
          icon: Icons.print,
          label: 'Report',
        ),
      ],
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemBuilder: (context, index) => Container(
                height: 100,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).canvasColor,
                  boxShadow: const [BoxShadow()],
                ),
              ),
            );
          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headline5,
            );
        }
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Search';
    case 2:
      return 'Query';
    case 3:
      return 'Add Package';
    case 4:
      return 'Change Status';
    case 5:
      return 'Report';
    default:
      return 'Not found page';
  }
}

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xF9FFCBA4);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xF9C86733);
const borderColor=Color(0xF94169e1);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);