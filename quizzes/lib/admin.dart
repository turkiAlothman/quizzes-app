import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'adminQuizes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class admin extends StatefulWidget {
  const admin({super.key});

  @override
  State<admin> createState() => _adminState();
}

class _adminState extends State<admin> {
  @override
  void initState() {
    super.initState();
  }

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            uperBarr(),
            SizedBox(
              height: 30,
            ),
            Text(
              "Categories",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Cairo',
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => adminQuizes(
                                category: "Movies",
                                color1: Colors.red,
                                color2: Colors.white,
                              )));
                    },
                    child: Container(
                        //margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: HexColor.fromHex('D6D3D1'),
                            //spreadRadius: 10,
                            blurRadius: 30,
                            blurStyle: BlurStyle.outer,

                            //offset: Offset(0, 10), // changes position of shadow
                          ),
                        ], borderRadius: BorderRadius.all(Radius.circular(10))),
                        //margin: EdgeInsets.symmetric(vertical: 70, horizontal: 15),
                        width: MediaQuery.of(context).size.width * 0.43,
                        height: MediaQuery.of(context).size.width * 0.390,
                        //color: Colors.grey[100],
                        child: Center(
                          child: Container(
                            // greens image
                            //margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/video.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                            //margin: EdgeInsets.symmetric(vertical: 70, horizontal: 15),
                            width: 110,
                            height: 110,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Movies",
                    style: TextStyle(
                        color: HexColor.fromHex('1C1917'),
                        fontSize: 18,
                        fontFamily: 'Cairo',
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
                Column(children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => adminQuizes(
                                category: "Sports",
                                color1: Colors.blue,
                                color2: Colors.white,
                              )));
                    },
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: HexColor.fromHex('D6D3D1'),
                          //spreadRadius: 10,
                          blurRadius: 19,
                          blurStyle: BlurStyle.outer,

                          //offset: Offset(0, 10), // changes position of shadow
                        ),
                      ], borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: MediaQuery.of(context).size.width * 0.43,
                      height: MediaQuery.of(context).size.width * 0.390,
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/football.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sports",
                    style: TextStyle(
                        color: HexColor.fromHex('1C1917'),
                        fontSize: 18,
                        fontFamily: 'Cairo',
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => adminQuizes(
                                category: "Travel",
                                color1: Color.fromARGB(186, 33, 149, 243),
                                color2: Colors.white,
                              )));
                    },
                    child: Container(
                        //margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: HexColor.fromHex('D6D3D1'),
                            //spreadRadius: 10,
                            blurRadius: 30,
                            blurStyle: BlurStyle.outer,

                            //offset: Offset(0, 10), // changes position of shadow
                          ),
                        ], borderRadius: BorderRadius.all(Radius.circular(10))),
                        //margin: EdgeInsets.symmetric(vertical: 70, horizontal: 15),
                        width: MediaQuery.of(context).size.width * 0.43,
                        height: MediaQuery.of(context).size.width * 0.390,
                        //color: Colors.grey[100],
                        child: Center(
                          child: Container(
                            // greens image
                            //margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              image: DecorationImage(
                                image: AssetImage('assets/world.png'),
                                fit: BoxFit.fill,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(1),
                                ),
                              ],
                            ),
                            //margin: EdgeInsets.symmetric(vertical: 70, horizontal: 15),
                            width: 110,
                            height: 110,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Travel",
                    style: TextStyle(
                        color: HexColor.fromHex('1C1917'),
                        fontSize: 18,
                        fontFamily: 'Cairo',
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
                Column(children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => adminQuizes(
                                category: "Video Games",
                                color2: Colors.red,
                                color1: Colors.purple,
                              )));
                    },
                    child: Container(
                        //margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: HexColor.fromHex('D6D3D1'),
                            //spreadRadius: 10,
                            blurRadius: 30,
                            blurStyle: BlurStyle.outer,

                            //offset: Offset(0, 10), // changes position of shadow
                          ),
                        ], borderRadius: BorderRadius.all(Radius.circular(10))),
                        //margin: EdgeInsets.symmetric(vertical: 70, horizontal: 15),
                        width: MediaQuery.of(context).size.width * 0.43,
                        height: MediaQuery.of(context).size.width * 0.390,
                        //color: Colors.grey[100],
                        child: Center(
                          child: Container(
                            // greens image
                            //margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              image: DecorationImage(
                                image: AssetImage('assets/console.png'),
                                fit: BoxFit.fill,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(1),
                                ),
                              ],
                            ),
                            //margin: EdgeInsets.symmetric(vertical: 70, horizontal: 15),
                            width: 130,
                            height: 130,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Video Games",
                    style: TextStyle(
                        color: HexColor.fromHex('1C1917'),
                        fontSize: 18,
                        fontFamily: 'Cairo',
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
              ],
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
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

class WaveShape1 extends CustomClipper<Path> {
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var p = Path();
    p.lineTo(0, height);
    //p.cubicTo(width * 1 / 2, 0, width * 2 / 4, height, width, 0);
    p.cubicTo(100, 140, 130, 70, 130, 60);
    p.lineTo(width, 0);

    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

class WaveShape2 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var p = Path();
    p.lineTo(0, 135);
    //p.cubicTo(width * 1 / 2, 0, width * 2 / 4, height, width, 0);
    p.cubicTo(150, 20, 250, 150, 360, 0);
    p.lineTo(width, 0);

    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

class WaveShape3 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var p = Path();
    p.lineTo(0, height);
    //p.cubicTo(width * 1 / 2, 0, width * 2 / 4, height, width, 0);
    p.cubicTo(100, 160, 140, 120, 110, 70);
    p.lineTo(width, 0);

    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

class WaveShape4 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var p = Path();
    p.lineTo(0, 100);
    //p.cubicTo(width * 1 / 2, 0, width * 2 / 4, height, width, 0);
    p.cubicTo(100, 80, 220, 160, 360, 0);
    p.lineTo(width, 0);

    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

class WaveShape5 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var p = Path();
    p.lineTo(0, height);
    //p.cubicTo(width * 1 / 2, 0, width * 2 / 4, height, width, 0);
    p.cubicTo(30, 10, 360, 120, 360, 0);
    p.lineTo(width, 0);

    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

class uperBarr extends StatelessWidget {
  uperBarr({
    Key? key,
  }) : super(key: key);
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 147,
      width: double.infinity,
      child: Stack(
        children: [
          ClipPath(
            clipper: WaveShape5(),
            child: Container(
              width: 360,
              height: 50,
              color: HexColor.fromHex('#f4ac47'),
            ),
          ),
          ClipPath(
            clipper: WaveShape4(),
            child: Container(
              width: 360,
              height: 125,
              color: HexColor.fromHex('#3a434d'),
            ),
          ),
          ClipPath(
            clipper: WaveShape3(),
            child: Container(
              width: 360,
              height: 145,
              color: HexColor.fromHex('#f4ac47'),
            ),
          ),
          ClipPath(
            clipper: WaveShape1(),
            child: Container(
              width: 360,
              height: 145,
              color: HexColor.fromHex('#59bee6'),
            ),
          ),
          ClipPath(
            clipper: WaveShape2(),
            child: Container(
              width: 360,
              height: 125,
              color: HexColor.fromHex('#59bee6'),
            ),
          ),
          Positioned(
            left: 15,
            top: 30,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/QuizzyLogo.png'),
              radius: 40,
            ),
          ),
          Positioned(
            top: 25,
            right: 145,
            child: Text(
              "admin page",
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Positioned(
              top: 40,
              right: 0,
              child: IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 30,
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
              )),
        ],
      ),
    );
  }
}
