import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class editQuizInfo extends StatefulWidget {
  const editQuizInfo(
      {super.key,
      required this.name,
      required this.duration,
      required this.difficulty,
      required this.quizID});
  final String name;

  final String duration;
  final String difficulty;
  final String quizID;

  @override
  State<editQuizInfo> createState() => _editQuizInfoState();
}

class _editQuizInfoState extends State<editQuizInfo> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late String nameNew;

  late String durationNew;
  late String quizIDNew;
  late String difficultyNew;

  final List<String> Difficulties = <String>['Easy', 'Medium', 'Hard'];
  late String dropdownValue = widget.difficulty;

  @override
  void initState() {
    super.initState();

    this.nameNew = widget.name;

    this.durationNew = widget.duration;
    this.difficultyNew = widget.difficulty;
    String dropdownValue = widget.difficulty;
  }

  Text text(String text, double size, Color color,
      {FontWeight? fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
    );
  }

  final _formKey = GlobalKey<FormState>();

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
                    Text(
                      "Quiz name:",
                      style: TextStyle(
                        color: HexColor.fromHex('1C1917'),
                        fontSize: 15,
                        fontFamily: 'Cairo',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    TextFormField(
                      initialValue: widget.name,
                      onChanged: (value) {
                        nameNew = value;
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
                      height: 30,
                    ),
                    Text(
                      "Duration in minutes:",
                      style: TextStyle(
                        color: HexColor.fromHex('1C1917'),
                        fontSize: 15,
                        fontFamily: 'Cairo',
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 300,
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: widget.duration,
                            onChanged: (value) {
                              durationNew = value;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              // for version 2 and greater youcan also use this
                              FilteringTextInputFormatter.digitsOnly
                            ],

                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter duration';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Difficulty:",
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
                          dropdownValue = value!;
                          difficultyNew = value;
                        });
                      },
                      items: Difficulties.map<DropdownMenuItem<String>>(
                          (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 30,
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
                            _firestore
                                .collection("quiz")
                                .doc(widget.quizID)
                                .update({
                              "quizName": nameNew,
                              "duration": durationNew,
                              "difficulty": difficultyNew,
                            });
                            ;
                          }

                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: text("quiz info edited successfully !",
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
                                              text("back to edit page", 19,
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
                        child: const Text('edit'),
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
