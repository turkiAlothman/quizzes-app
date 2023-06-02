import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'editQuestion.dart';
import 'addQuestion.dart';
import 'editQuizInfo.dart';

class adminEdit extends StatefulWidget {
  const adminEdit({super.key, required this.quizId});
  final String quizId;

  @override
  State<adminEdit> createState() => _adminEditState();
}

class _adminEditState extends State<adminEdit> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Text text(String text, double size, Color color,
      {FontWeight? fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
    );
  }

  Text TextOverflowed(String text, double size, Color color, int max,
      {FontWeight? fontWeight = FontWeight.normal}) {
    return Text(
      overflow: TextOverflow.ellipsis,
      maxLines: max,
      text,
      style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
    );
  }

  Text TextOverflowedCenter(String text, double size, Color color, int max,
      {FontWeight? fontWeight = FontWeight.normal}) {
    return Text(
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: max,
      text,
      style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
    );
  }

  Container questionContainer(String name, String option1, String option2,
      String option3, String option4, String correct, String id) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: HexColor.fromHex('D6D3D1'),
              spreadRadius: 0,
              blurRadius: 19,
              blurStyle: BlurStyle.outer),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            children: [
              Expanded(
                child: TextOverflowed(name, 19, Colors.black, 2,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Row(
            children: [
              Expanded(
                child: TextOverflowed("a) $option1 ", 17, Colors.black, 1),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            children: [
              Expanded(
                child: TextOverflowed("b) $option2 ", 17, Colors.black, 1),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            children: [
              Expanded(
                child: TextOverflowed("c) $option3", 17, Colors.black, 1),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            children: [
              Expanded(
                child: TextOverflowed("d) $option4 ", 17, Colors.black, 1),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Row(
            children: [
              Expanded(
                child: TextOverflowed("correct: $correct", 17, Colors.black, 1,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 25.0,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) => editQuestion(
                            name: name,
                            option1: option1,
                            option2: option2,
                            option3: option3,
                            option4: option4,
                            correct: correct,
                            id: id,
                          )));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.pink,
                  size: 25.0,
                  // semanticLabel: 'Text to announce in accessibility modes',
                ),
                onPressed: () {
                  showAlertDialog(context, id, widget.quizId);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Container infoContianer(
      String name, String duration, String difficulty, String id) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: HexColor.fromHex('D6D3D1'),
              spreadRadius: 0,
              blurRadius: 19,
              blurStyle: BlurStyle.outer),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Center(
            child: Expanded(
              child: TextOverflowed("quiz name:", 19, Colors.black, 2),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Center(
            child: Expanded(
              child: TextOverflowedCenter(name, 19, Colors.black, 2,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextOverflowed("duration: $duration Minutes",
                  MediaQuery.of(context).size.width * 0.037, Colors.black, 1),
              TextOverflowed("difficulty: $difficulty ",
                  MediaQuery.of(context).size.width * 0.037, Colors.black, 1)
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Center(
            child: IconButton(
              icon: Icon(
                Icons.edit_note,
                color: Colors.blue,
                size: 40.0,
                // semanticLabel: 'Text to announce in accessibility modes',
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (c) => editQuizInfo(
                        difficulty: difficulty,
                        duration: duration,
                        name: name,
                        quizID: id)));
              },
            ),
          )
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context, String id, String quizID) {
    // set up the buttons

    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Delete question"),
      onPressed: () async {
        var collection1 = _firestore.collection('question');
        collection1.doc(id).delete();
        _firestore
            .collection("quiz")
            .doc(quizID)
            .update({"NOquestions": FieldValue.increment(-1)});
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete a Quiz"),
      content: Text("Are You Sure you want to delete the Question?"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                text(" quiz info : ", 20, Colors.black,
                    fontWeight: FontWeight.bold)
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Center(
              child: StreamBuilder<DocumentSnapshot>(
                stream: _firestore
                    .collection("quiz")
                    .doc(widget.quizId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.blue), //choose your own color
                    ));
                  }

                  final quize = snapshot.data!;

                  return infoContianer(
                    quize.get("quizName"),
                    quize.get("duration"),
                    quize.get("difficulty"),
                    quize.id,
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Row(
              children: [
                text(" Questions : ", 20, Colors.black,
                    fontWeight: FontWeight.bold)
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Center(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection("question")
                    .where("quizID", isEqualTo: widget.quizId)
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
                    retarnedQuezes.add(questionContainer(
                      element.get("Question"),
                      element.get("option1"),
                      element.get("option2"),
                      element.get("option3"),
                      element.get("option4"),
                      element.get("correct"),
                      element.id,
                    ));
                  }

                  return Wrap(
                    spacing: 20,
                    direction: Axis.vertical,
                    children: retarnedQuezes,
                  );
                },
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (c) => addQuestion(
                    quizID: widget.quizId,
                  )));
        },
        label: const Text('Add Question'),
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
