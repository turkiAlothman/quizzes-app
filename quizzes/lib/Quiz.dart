import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:quizzes/questions.dart';
import 'AddQuiz.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class Quiz extends StatefulWidget {
  const Quiz(
      {Key? key,
      required this.Url,
      required this.id,
      required this.questions,
      required this.Color,
      required this.Duration})
      : super(key: key);
  final String Url;
  final questions;
  final String id;
  final Color;
  final String Duration;

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  int timer = 0;

  final CountDownController _controller = CountDownController();

  List<List<Color>> handleColors = [];
  int current = 0;
  List<String> answers = [];

  void reset() {
    handleColors[current][0] = widget.Color;
    handleColors[current][1] = widget.Color;
    handleColors[current][2] = widget.Color;
    handleColors[current][3] = widget.Color;
  }

  void Change_color(int index) {
    setState(() {
      reset();
      handleColors[current][index] = widget.Color.withOpacity(0.5);
    });
  }

  Text text(String text, double size, Color color,
      {FontWeight? fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < widget.questions.length; i++) {
      handleColors
          .add([widget.Color, widget.Color, widget.Color, widget.Color]);
      answers.add("NoAnswer");
    }
  }

  InkWell chechNext() {
    if (current == widget.questions.length - 1) {
      return InkWell(
        onTap: () async {
          getOut();
        },
        child: Container(
          // green invest
          decoration: BoxDecoration(
            color: Colors.green[300],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)),
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
          width: MediaQuery.of(context).size.width * 0.18,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Submit",
                style: TextStyle(
                    color: HexColor.fromHex('FFFFFF'),
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontFamily: 'Cairo',
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    } else
      return InkWell(
        onTap: () {
          setState(() {
            current++;
          });
        },
        child: Container(
          // green invest
          decoration: BoxDecoration(
            color: Colors.green[300],
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
          width: MediaQuery.of(context).size.width * 0.18,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Next",
                style: TextStyle(
                    color: HexColor.fromHex('FFFFFF'),
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontFamily: 'Cairo',
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
  }

  void getOut() async {
    setState(() {
      _controller.pause();
    });

    timer = (double.parse(widget.Duration) * 60).round() -
        int.parse(_controller.getTime());
    int count = 0;
    for (var i = 0; i < widget.questions.length; i++) {
      if (answers[i] == widget.questions[i].get("correct")) count++;
    }
    int score = (count / widget.questions.length * 100).toInt();

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: text("your score is $score% !!", 22, Colors.green),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back),
                        SizedBox(
                          width: 9,
                        ),
                        text("back to Quizes page", 19, Colors.black)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
    _firestore.collection("submit").add({
      "userID": _auth.currentUser?.uid,
      "quizID": widget.id,
      "score": score,
      "duration": timer
    });
    Navigator.pop(context);
  }

  Container checkPrevious() {
    if (current == 0)
      return Container();
    else
      return Container(
        // green invest
        decoration: BoxDecoration(
          color: Colors.green[300],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13),
              topRight: Radius.circular(13),
              bottomLeft: Radius.circular(13),
              bottomRight: Radius.circular(13)),
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
        width: MediaQuery.of(context).size.width * 0.18,
        height: MediaQuery.of(context).size.height * 0.05,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Previous",
              style: TextStyle(
                  color: HexColor.fromHex('FFFFFF'),
                  fontSize: MediaQuery.of(context).size.width * 0.0345,
                  fontFamily: 'Cairo',
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final optionWidth = MediaQuery.of(context).size.width * 0.42;
    final optionHight = MediaQuery.of(context).size.height * 0.07;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.Url),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.login_outlined,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              // do something
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.3,
                      ),
                      Container(
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width * 0.95,
                        height:
                            MediaQuery.of(context).size.height * 0.54, //* 0.425
                        child: Column(children: [
                          SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: [
                              Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    widget.questions[current].get("Question"),
                                    style: TextStyle(
                                      color: HexColor.fromHex('1C1917'),
                                      fontSize: 19,
                                      fontFamily: 'Cairo',
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: optionHight,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    //first option
                                    onTap: () {
                                      Change_color(0);
                                      answers[current] = "A";
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(9),
                                      decoration: BoxDecoration(
                                        color: handleColors[current][0],
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
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      //margin: EdgeInsets.symmetric(vertical: 70, horizontal: 15),
                                      width: optionWidth,
                                      height: optionHight,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              widget.questions[current]
                                                  .get("option1"),
                                              style: TextStyle(
                                                  color: HexColor.fromHex(
                                                      'FFFFFF'),
                                                  fontSize: 20,
                                                  fontFamily: 'Cairo',
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    // second option
                                    onTap: () {
                                      Change_color(1);
                                      answers[current] = "B";
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(9),
                                      decoration: BoxDecoration(
                                        color: handleColors[current][1],
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
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      //margin: EdgeInsets.symmetric(vertical: 70, horizontal: 15),
                                      width: optionWidth,
                                      height: optionHight,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              widget.questions[current]
                                                  .get("option2"),
                                              style: TextStyle(
                                                  color: HexColor.fromHex(
                                                      'FFFFFF'),
                                                  fontSize: 20,
                                                  fontFamily: 'Cairo',
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    // third option
                                    onTap: () {
                                      Change_color(2);
                                      answers[current] = "C";
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(9),
                                      decoration: BoxDecoration(
                                        color: handleColors[current][2],
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
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      //margin: EdgeInsets.symmetric(vertical: 70, horizontal: 15),
                                      width: optionWidth,
                                      height: optionHight,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              widget.questions[current]
                                                  .get("option3"),
                                              style: TextStyle(
                                                  color: HexColor.fromHex(
                                                      'FFFFFF'),
                                                  fontSize: 20,
                                                  fontFamily: 'Cairo',
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    //forth option
                                    onTap: () {
                                      Change_color(3);
                                      answers[current] = "D";
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(9),
                                      decoration: BoxDecoration(
                                        color: handleColors[current][3],
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
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      //margin: EdgeInsets.symmetric(vertical: 70, horizontal: 15),
                                      width: optionWidth,
                                      height: optionHight,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              widget.questions[current]
                                                  .get("option4"),
                                              style: TextStyle(
                                                  color: HexColor.fromHex(
                                                      'FFFFFF'),
                                                  fontSize: 20,
                                                  fontFamily: 'Cairo',
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: optionHight,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          current--;
                                        });
                                      },
                                      child: checkPrevious()),
                                  chechNext()
                                ],
                              ),
                              Center(
                                child: CircularCountDownTimer(
                                  duration: (double.parse(widget.Duration) * 60)
                                      .round(),
                                  initialDuration: 0,
                                  controller: _controller,
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  ringColor: Colors.grey[300]!,
                                  ringGradient: null,
                                  fillColor: widget.Color.withOpacity(0.5),
                                  fillGradient: null,
                                  backgroundColor: widget.Color,
                                  backgroundGradient: null,
                                  strokeWidth: 5.0,
                                  strokeCap: StrokeCap.round,
                                  textStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textFormat: CountdownTextFormat.S,
                                  isReverse: true,
                                  isReverseAnimation: true,
                                  isTimerTextShown: true,
                                  autoStart: true,
                                  onComplete: () {
                                    getOut();
                                  },
                                ),
                              )
                            ],
                          ),
                        ]),
                      ),
                    ],
                  ),
                )),
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

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Delete Quiz"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete a Quiz"),
    content: Text("Are You Sure you want to delete the Quiz?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}




// await showDialog(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return AlertDialog(
              //         title: text("quiz added successfully !", 22,
              //             Colors.green),
              //         content: SingleChildScrollView(
              //           child: ListBody(
              //             children: [
              //               InkWell(
              //                 onTap: () {
              //                   Navigator.pop(context);
              //                 },
              //                 child: Row(
              //                   children: [
              //                     Icon(Icons.arrow_back),
              //                     SizedBox(
              //                       width: 9,
              //                     ),
              //                     text("back to Quizes page", 19,
              //                         Colors.black)
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     }
      
              //     );