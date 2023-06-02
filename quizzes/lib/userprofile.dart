import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'activeUser.dart';

class userProfile extends StatefulWidget {
  const userProfile({super.key});

  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Text text(String text, double size, Color color,
      {FontWeight? fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
    );
  }

  bool _loading = true;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  activeUser currentuser = activeUser();

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final data = await _firestore.collection("user").doc(user.uid).get();

        currentuser.email = user.email as String;
        setState(() {
          currentuser.firstName = data.get("firstName");
          currentuser.lastName = data.get("lastName");
          currentuser.score = data.get("score");
          setState(() {
            _loading = false;
          });
        });
      }
    } catch (e) {
      print("erroooor");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Hello !"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              _auth.signOut();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyHomePage(title: 'Flutter Demo Home Page')),
                (Route<dynamic> route) => false,
              );

              // do something
            },
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: text("profile", 25, Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          _loading
              ? Center(
                  child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Colors.blue), //choose your own color
                ))
              : Center(
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: HexColor.fromHex('D6D3D1'),
                          spreadRadius: 0,
                          blurRadius: 19,
                          blurStyle: BlurStyle.outer),
                    ], borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.31,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text(
                                " First name :",
                                MediaQuery.of(context).size.width * 0.045,
                                Colors.black),
                            text(
                                currentuser.firstName + " ",
                                MediaQuery.of(context).size.width * 0.045,
                                Colors.black),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text(
                                " Last name :",
                                MediaQuery.of(context).size.width * 0.045,
                                Colors.black),
                            text(
                                currentuser.lastName + " ",
                                MediaQuery.of(context).size.width * 0.045,
                                Colors.black),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text(
                                " email :",
                                MediaQuery.of(context).size.width * 0.045,
                                Colors.black),
                            text(
                                currentuser.email + " ",
                                MediaQuery.of(context).size.width * 0.045,
                                Colors.black),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text(
                                " quizzes taken :",
                                MediaQuery.of(context).size.width * 0.045,
                                Colors.black),
                            text(
                                "0 ",
                                MediaQuery.of(context).size.width * 0.045,
                                Colors.black),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
