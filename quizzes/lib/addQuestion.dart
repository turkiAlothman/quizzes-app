import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class addQuestion extends StatefulWidget {
  const addQuestion({super.key, required this.quizID});
  final String quizID;

  @override
  State<addQuestion> createState() => _addQuestionState();
}

class _addQuestionState extends State<addQuestion> {
  late String nameNew;
  late String option1New;
  late String option2New;
  late String option3New;
  late String option4New;
  late String correctNew;
  final List<String> Answers = <String>['A', 'B', 'C', 'D'];
  late String dropdownValue = Answers.first;

  final _formKey = GlobalKey<FormState>();

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Text text(String text, double size, Color color,
      {FontWeight? fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        gradient:
            LinearGradient(colors: [HexColor.fromHex('#59bee6'), Colors.white]),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        nameNew = value;
                      },
                      scrollPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom +
                              13 * 4),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the question';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                      "A)",
                      style: TextStyle(
                        color: HexColor.fromHex('1C1917'),
                        fontSize: 15,
                        fontFamily: 'Cairo',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        option1New = value;
                        correctNew = "A";
                      },
                      scrollPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom +
                              13 * 4),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter quiz name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      "B)",
                      style: TextStyle(
                        color: HexColor.fromHex('1C1917'),
                        fontSize: 15,
                        fontFamily: 'Cairo',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        option2New = value;
                      },
                      scrollPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom +
                              13 * 4),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter quiz name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      "C)",
                      style: TextStyle(
                        color: HexColor.fromHex('1C1917'),
                        fontSize: 15,
                        fontFamily: 'Cairo',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        option3New = value;
                      },
                      scrollPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom +
                              13 * 4),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter quiz name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      "D)",
                      style: TextStyle(
                        color: HexColor.fromHex('1C1917'),
                        fontSize: 15,
                        fontFamily: 'Cairo',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        option4New = value;
                      },
                      scrollPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom +
                              13 * 4),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter quiz name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      "The correct answer is: ",
                      style: TextStyle(
                        color: HexColor.fromHex('1C1917'),
                        fontSize: 15,
                        fontFamily: 'Cairo',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          correctNew = value as String;
                          dropdownValue = value!;
                        });
                      },
                      items:
                          Answers.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                margin: EdgeInsets.only(left: 30),
                width: MediaQuery.of(context).size.width - 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            _firestore.collection("question").add({
                              "Question": nameNew,
                              "option1": option1New,
                              "option2": option2New,
                              "option3": option3New,
                              "option4": option4New,
                              "correct": correctNew,
                              "quizID": widget.quizID
                            });
                            ;

                            _firestore
                                .collection("quiz")
                                .doc(widget.quizID)
                                .update(
                                    {"NOquestions": FieldValue.increment(1)});
                          }

                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: text("question added successfully !",
                                      22, Colors.green),
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
                                              text("back to questions page", 19,
                                                  Colors.black)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });

                          Navigator.pop(context);
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
