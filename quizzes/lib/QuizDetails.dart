import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:quizzes/questions.dart';
import 'AddQuiz.dart';
import 'Quiz.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizDetails extends StatefulWidget {
  const QuizDetails(
      {Key? key,
      required this.color1,
      required this.color2,
      required this.id,
      required this.NOF,
      required this.duration,
      required this.difficulty,
      required this.url})
      : super(key: key);
  final color1;
  final color2;
  final String id;
  final String duration;
  final int NOF;
  final String difficulty;
  final String url;

  @override
  State<QuizDetails> createState() => _QuizDetailsState();
}

class _QuizDetailsState extends State<QuizDetails> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Color selectColor(String difficulty) {
    if (difficulty == "Easy")
      return Colors.green;
    else if (difficulty == "Medium")
      return Colors.orange;
    else
      return Colors.red;
  }

  Container getPlayer(
      String playeName, int score, int Takenduration, String madel) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color(0XD6D3D1),
            spreadRadius: 0,
            blurRadius: 0,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      //margin: EdgeInsets.symmetric(vertical: 70, horizontal: 15),
      width: MediaQuery.of(context).size.width - 80,
      height: 60,
      // padding: EdgeInsets.only(left: 20),
      child: Stack(children: [
        SizedBox(
          height: 5,
        ),
        Positioned(child: getImage(madel)),
        Container(
          //width: MediaQuery.of(context).size.width - 80,
          //height: 60,
          padding: EdgeInsets.only(left: 36),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 70,
              ),
              Container(
                width: 100,
                child: Text(
                  playeName as String,
                  style: TextStyle(
                    color: HexColor.fromHex('1C1917'),
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontFamily: 'Cairo',
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              SizedBox(
                width: 35,
              ),
              Text(
                _printDuration(Duration(seconds: Takenduration)).substring(3),
                style: TextStyle(
                  color: HexColor.fromHex('1C1917'),
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  fontFamily: 'Cairo',
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(
                width: 35,
              ),
              Text(
                (score.toString() as String) + "%",
                style: TextStyle(
                  color: HexColor.fromHex('1C1917'),
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  fontFamily: 'Cairo',
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ]),
    );
  }

  var medals = {
    'Gold': "assets/goldM.png",
    "Silver": "assets/silver.png",
    "Bronze": "assets/bronze.png"
  };

  Image getImage(String medal) {
    if (medal == 'Gold' || medal == 'Silver' || medal == 'Bronze')
      return Image(
        image: AssetImage(medals[medal] as String),
      );
    else
      return Image(
        height: 0,
        width: 0,
        image: AssetImage(medals["Gold"] as String),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      resizeToAvoidBottomInset: false,
      appBar: NewGradientAppBar(
          gradient: LinearGradient(colors: [widget.color1, widget.color2])),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.93,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: HexColor.fromHex('D6D3D1'),
                      spreadRadius: 0,
                      blurRadius: 19,
                      blurStyle: BlurStyle.outer),
                ], borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Quiz details:",
                    style: TextStyle(
                        color: HexColor.fromHex('1C1917'),
                        fontSize: 16,
                        fontFamily: 'Cairo',
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    // Riyadh invesment info
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0XD6D3D1),
                          spreadRadius: 0,
                          blurRadius: 0,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    //margin: EdgeInsets.symmetric(vertical: 70, horizontal: 15),
                    width: MediaQuery.of(context).size.width - 50,
                    height: 80,
                    child: Column(children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Question(s): ",
                            style: TextStyle(
                              color: HexColor.fromHex('1C1917'),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                              fontFamily: 'Cairo',
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.17,
                          ),
                          Text(
                            "Duration:",
                            style: TextStyle(
                              color: HexColor.fromHex('1C1917'),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                              fontFamily: 'Cairo',
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.17,
                          ),
                          Text(
                            "Difficulty:",
                            style: TextStyle(
                              color: HexColor.fromHex('1C1917'),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                              fontFamily: 'Cairo',
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 45,
                          ),
                          Text(
                            widget.NOF.toString(),
                            style: TextStyle(
                              color: HexColor.fromHex('1C1917'),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                              fontFamily: 'Cairo',
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(
                            width: 105,
                          ),
                          Text(
                            widget.duration + " Minutes",
                            style: TextStyle(
                              color: HexColor.fromHex('1C1917'),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                              fontFamily: 'Cairo',
                              decoration: TextDecoration.none,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.13,
                          ),
                          Container(
                            // green invest
                            decoration: BoxDecoration(
                              color: selectColor(widget.difficulty),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0XD6D3D1),
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            //margin: EdgeInsets.symmetric(vertical: 70, horizontal: 15),
                            width: 50,
                            height: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.difficulty,
                                  style: TextStyle(
                                      color: HexColor.fromHex('FFFFFF'),
                                      fontSize: 8,
                                      fontFamily: 'Cairo',
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              "Leaderboard",
              style: TextStyle(
                  color: HexColor.fromHex('1C1917'),
                  fontSize: 19,
                  fontFamily: 'Cairo',
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Name",
                    style: TextStyle(
                      color: HexColor.fromHex('1C1917'),
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontFamily: 'Cairo',
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  Text(
                    "Duration (min:sec)",
                    style: TextStyle(
                      color: HexColor.fromHex('1C1917'),
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontFamily: 'Cairo',
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  Text(
                    "Score",
                    style: TextStyle(
                      color: HexColor.fromHex('1C1917'),
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontFamily: 'Cairo',
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              height: 430,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: HexColor.fromHex('D6D3D1'),
                    spreadRadius: 0,
                    blurRadius: 19,
                    blurStyle: BlurStyle.outer),
              ], borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection("user").snapshots(),
                      builder: (context, snapshot1) {
                        return StreamBuilder<QuerySnapshot>(
                            stream: _firestore
                                .collection("submit")
                                .where("quizID", isEqualTo: widget.id)
                                .orderBy("score", descending: true)
                                .orderBy("duration", descending: false)
                                .limit(5)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.blue), //choose your own color
                                ));
                              }

                              var madels = {
                                0: 'Gold',
                                1: "Silver",
                                2: "Bronze",
                                3: "others",
                                4: "others"
                              };
                              //////// List<player> top5 = [];
                              List<Container> top5 = [];
                              final data = snapshot.data!.docs;
                              final data1 = snapshot1.data!.docs;

                              int index = 0;

                              for (var element in data) {
                                if (index == 5) break;

                                String userID = element.get("userID");

                                top5.add(getPlayer(
                                    data1
                                        .firstWhere(
                                            (element1) => element1.id == userID)
                                        .get("firstName") as String,
                                    element.get("score"),
                                    element.get("duration"),
                                    madels[index] as String));
                                index++;
                              }

                              return Wrap(
                                  spacing: 10,
                                  direction: Axis.vertical,
                                  children: top5);
                            });
                      }),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection("submit")
                        .where("quizID", isEqualTo: widget.id)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.blue), //choose your own color
                        ));
                      }
                      final data = snapshot.data!.docs;
                      if (data.length > 0) {
                        double sumTime = 0;
                        double sumScore = 0;
                        for (var element in data) {
                          sumScore += element.get("score");
                          sumTime += element.get("duration");
                        }
                        String averageTime = _printDuration(Duration(
                                seconds: (sumTime / data.length).floor()))
                            .substring(3);
                        String averageScore =
                            (sumScore / data.length).toStringAsFixed(1);

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Average Duration:",
                              style: TextStyle(
                                  color: HexColor.fromHex('1C1917'),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.035,
                                  fontFamily: 'Cairo',
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "$averageTime ",
                              style: TextStyle(
                                color: HexColor.fromHex('1C1917'),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                fontFamily: 'Cairo',
                                decoration: TextDecoration.none,
                              ),
                            ),
                            Text(
                              "Average Score:",
                              style: TextStyle(
                                  color: HexColor.fromHex('1C1917'),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.035,
                                  fontFamily: 'Cairo',
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "$averageScore% ",
                              style: TextStyle(
                                color: HexColor.fromHex('1C1917'),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                fontFamily: 'Cairo',
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        );
                      }
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                          Text(
                            "this quiz has no submiters",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.045),
                          )
                        ],
                      );
                    }),
              ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: widget.color1,
        onPressed: () async {
          final data = await _firestore
              .collection("question")
              .where("quizID", isEqualTo: widget.id)
              .get();
          final questions = data.docs;

          Navigator.of(context).push(MaterialPageRoute(
              builder: (c) => Quiz(
                    Url: widget.url,
                    id: widget.id,
                    questions: questions,
                    Color: widget.color1,
                    Duration: widget.duration,
                  )));
        },
        label: const Text('Srart Quiz'),
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

class player extends StatefulWidget {
  const player(
      {Key? key,
      required this.madel,
      required this.duration,
      required this.name,
      required this.score})
      : super(key: key);
  final String name;
  final int score;
  final int duration;
  final String madel;
  @override
  State<player> createState() => _playerState();
}

class _playerState extends State<player> {
  @override
  // var player_info = {'Name': "Fahad", "Duration": "12:37", "Score": "97/100"};
  var medals = {
    'Gold': "assets/goldM.png",
    "Silver": "assets/silver.png",
    "Bronze": "assets/bronze.png"
  };

  Image getImage(String medal) {
    if (medal == 'Gold' || medal == 'Silver' || medal == 'Bronze')
      return Image(
        image: AssetImage(medals[medal] as String),
      );
    else
      return Image(
        height: 0,
        width: 0,
        image: AssetImage(medals["Gold"] as String),
      );
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Color(0XD6D3D1),
            spreadRadius: 0,
            blurRadius: 0,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      //margin: EdgeInsets.symmetric(vertical: 70, horizontal: 15),
      width: MediaQuery.of(context).size.width - 80,
      height: 60,
      // padding: EdgeInsets.only(left: 20),
      child: Stack(children: [
        SizedBox(
          height: 5,
        ),
        Positioned(child: getImage(widget.madel)),
        Container(
          //width: MediaQuery.of(context).size.width - 80,
          //height: 60,
          padding: EdgeInsets.only(left: 33),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 70,
              ),
              Container(
                width: 100,
                child: Text(
                  widget.name as String,
                  style: TextStyle(
                    color: HexColor.fromHex('1C1917'),
                    fontSize: 15,
                    fontFamily: 'Cairo',
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              SizedBox(
                width: 35,
              ),
              Text(
                widget.duration.toString() as String,
                style: TextStyle(
                  color: HexColor.fromHex('1C1917'),
                  fontSize: 15,
                  fontFamily: 'Cairo',
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(
                width: 35,
              ),
              Text(
                widget.score.toString() as String,
                style: TextStyle(
                  color: HexColor.fromHex('1C1917'),
                  fontSize: 15,
                  fontFamily: 'Cairo',
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ]),
    );
  }
}
