import 'package:flutter/material.dart';
import 'package:tutor_admin/src/screens/analytics.dart';
import 'package:tutor_admin/src/screens/students_view.dart';
import 'package:tutor_admin/src/screens/teachers_view.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  PageController pageController = PageController();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          children: const [
            TeachersView(),
            StudentView(),
            Analytics(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
              pageController.jumpToPage(selectedIndex);
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.analytics), label: ''),
          ]),
    );
  }
}
