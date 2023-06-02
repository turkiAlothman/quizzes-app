import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'userprofile.dart';
import 'categoryUserPage.dart';

class userPage extends StatefulWidget {
  const userPage({super.key});

  @override
  State<userPage> createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  int index = 0;
  final Screens = [userProfile(), categoryUserPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all(TextStyle(fontSize: 15))),
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (index) {
            setState(() {
              this.index = index;
            });
          },
          height: MediaQuery.of(context).size.height * 0.090,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.account_circle_rounded),
              label: "profile",
            ),
            NavigationDestination(
              icon: Icon(Icons.quiz),
              label: "quizes",
            ),
          ],
        ),
      ),
      body: Screens[index],
    );
  }
}
