import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'adminAddQuiz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'adminEdit.dart';
import 'AddQuiz.dart';

class adminQuizes extends StatefulWidget {
  const adminQuizes(
      {super.key,
      required this.category,
      required this.color1,
      required this.color2});

  final String category;
  final Color color1;
  final Color color2;

  @override
  State<adminQuizes> createState() => _adminQuizesState();
}

class _adminQuizesState extends State<adminQuizes> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  showAlertDialog(BuildContext context, String id) {
    // set up the buttons

    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Delete Quiz"),
      onPressed: () async {
        var collection1 = _firestore.collection('quiz');
        collection1.doc(id).delete();

        var collection2 = FirebaseFirestore.instance.collection('question');
        var snapshot = await collection2.where('quizID', isEqualTo: id).get();
        for (var doc in snapshot.docs) {
          await doc.reference.delete();
        }

        Navigator.pop(context);
      },
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

  Container quizConntainer(String name, int NOquestions, String duration,
      String difficulty, String id, String url) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: HexColor.fromHex('D6D3D1'),
            spreadRadius: 0,
            blurRadius: 13,
            blurStyle: BlurStyle.outer),
      ], borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(children: [
        Container(
          // Roshan image

          decoration: BoxDecoration(
            //border: Border(bottom: BorderSide(width: 16.0, color: Colors.black),),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0)),
            image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.fill,
            ),
            boxShadow: [
              BoxShadow(
                color: HexColor.fromHex('D6D3D1'),
                spreadRadius: 0,
                blurRadius: 13,
                blurStyle: BlurStyle.outer,
                //offset: Offset(0, 3,), // changes position of shadow
              ),
            ],
          ),
          //margin: EdgeInsets.symmetric(vertical: 70, horizontal: 15),
          width: MediaQuery.of(context).size.width * 0.93,
          height: MediaQuery.of(context).size.height * 0.21,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
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
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontFamily: 'Cairo',
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                Text(
                  "Duration:",
                  style: TextStyle(
                    color: HexColor.fromHex('1C1917'),
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontFamily: 'Cairo',
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
                Container(
                  // green invest
                  decoration: BoxDecoration(
                    color: selectColor(difficulty),
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
                  width: 50,
                  height: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        difficulty,
                        style: TextStyle(
                            color: HexColor.fromHex('FFFFFF'),
                            fontSize: MediaQuery.of(context).size.width * 0.02,
                            fontFamily: 'Cairo',
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 45,
                ),
                Text(
                  NOquestions.toString(),
                  style: TextStyle(
                    color: HexColor.fromHex('1C1917'),
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontFamily: 'Cairo',
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
                Text(
                  duration + " Minutes",
                  style: TextStyle(
                    color: HexColor.fromHex('1C1917'),
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontFamily: 'Cairo',
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 17.0,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (c) => adminEdit(
                                  quizId: id,
                                )));
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.pink,
                        size: 17.0,
                        // semanticLabel: 'Text to announce in accessibility modes',
                      ),
                      onPressed: () {
                        showAlertDialog(context, id);
                      },
                    ),
                  ],
                )
              ],
            ),
          ]),
        ),
        SizedBox(
          height: 10,
        ),
      ]),
    );
  }

  Color selectColor(String difficulty) {
    if (difficulty == "Easy")
      return Colors.green;
    else if (difficulty == "Medium")
      return Colors.orange;
    else
      return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: NewGradientAppBar(
          gradient: LinearGradient(colors: [widget.color1, widget.color2])),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                widget.category,
                style: TextStyle(
                    color: HexColor.fromHex('1C1917'),
                    fontSize: 30,
                    fontFamily: 'Cairo',
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // Container(
            //   width: MediaQuery.of(context).size.width - 30,
            //   height: 220.0,
            //   decoration: BoxDecoration(
            //     boxShadow: [
            //       BoxShadow(
            //           color: Colors.black,
            //           spreadRadius: 0,
            //           blurRadius: 15,
            //           blurStyle: BlurStyle.outer
            //           //offset: Offset(0, 3), // changes position of shadow
            //           ),
            //     ],
            //     image: DecorationImage(
            //       image: AssetImage('assets/movies.jpg'),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection("quiz")
                  .where("category", isEqualTo: widget.category)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Colors.blue), //choose your own color
                  ));
                }
                List<Container> retarnedQuezes = [];

                final quizes = snapshot.data!.docs;
                for (var element in quizes) {
                  retarnedQuezes.add(quizConntainer(
                      element.get("quizName"),
                      element.get("NOquestions"),
                      element.get("duration"),
                      element.get("difficulty"),
                      element.id,
                      element.get("url")));
                }

                return Wrap(
                  spacing: 20,
                  direction: Axis.vertical,
                  children: retarnedQuezes,
                );
              },
            ),

            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: widget.color1,
        onPressed: () {
          // adminAddQuiz

          Navigator.of(context).push(MaterialPageRoute(
              builder: (c) => MyCustomForm(
                    category: widget.category,
                  )));
        },
        label: const Text('Add Quiz'),
        icon: const Icon(Icons.add),
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
