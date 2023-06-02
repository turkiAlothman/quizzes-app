import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/services.dart';
import 'questions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

const List<String> Difficulties = <String>['Easy', 'Medium', 'Hard'];
const List<String> Answers = <String>['A', 'B', 'C', 'D'];
List<questions> ourQuestions = <questions>[];
late String name;
late String duration;
late String difficulty;
late int numberOfQuestion;
String url =
    "https://firebasestorage.googleapis.com/v0/b/quizzes-fa5c8.appspot.com/o/quizImages%2FQuizzyLogo.png?alt=media&token=f81e795f-63e6-4d9a-a49f-ee99ee885c33";

Column serve = Column();

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key, required this.category});
  final String category;

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  void reset() {
    url =
        "https://firebasestorage.googleapis.com/v0/b/quizzes-fa5c8.appspot.com/o/quizImages%2FQuizzyLogo.png?alt=media&token=f81e795f-63e6-4d9a-a49f-ee99ee885c33";
    ourQuestions = <questions>[];
    _pickedImage = null;
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  File? _pickedImage;

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
    // Build a Form widget using the _formKey created above.

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
              Center(
                child: Text(
                  "Add quiz",
                  style: TextStyle(
                      color: HexColor.fromHex('1C1917'),
                      fontSize: 30,
                      fontFamily: 'Cairo',
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Center(
                child: Container(
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(114, 96, 125, 139),
                    radius: MediaQuery.of(context).size.width * 0.3,
                    backgroundImage: _pickedImage == null
                        ? null
                        : FileImage(_pickedImage as File),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: text("choose the option", 22,
                                          Colors.black),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                final pick = ImagePicker();
                                                final pickedImage =
                                                    await pick.pickImage(
                                                        source:
                                                            ImageSource.camera,
                                                        imageQuality: 20);
                                                final pickeded =
                                                    File(pickedImage!.path);

                                                setState(() {
                                                  _pickedImage = pickeded;
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(Icons.camera_alt),
                                                  SizedBox(
                                                    width: 9,
                                                  ),
                                                  text("camera", 19,
                                                      Colors.black)
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                final pick = ImagePicker();
                                                final pickedImage =
                                                    await pick.getImage(
                                                        source:
                                                            ImageSource.gallery,
                                                        imageQuality: 20);
                                                final pickeded =
                                                    File(pickedImage!.path);
                                                setState(() {
                                                  _pickedImage = pickeded;
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(Icons.image),
                                                  SizedBox(
                                                    width: 9,
                                                  ),
                                                  text("gallery", 19,
                                                      Colors.black)
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(Icons.cancel_outlined),
                                                  SizedBox(
                                                    width: 9,
                                                  ),
                                                  text("cancel", 19,
                                                      Colors.black)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.101,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                radius: MediaQuery.of(context).size.width * 0.1,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.only(left: 30),
                width: MediaQuery.of(context).size.width - 70,
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
                      onChanged: (value) {
                        name = value;
                        difficulty = Difficulties[0];
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
                            onChanged: (value) {
                              duration = value;
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
                    DifficultyDropdownButton(),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Number of questions:",
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
                            onChanged: (valueString) {
                              int value = int.parse(valueString);

                              numberOfQuestion = value;
                              List<Question> wid = [];

                              for (var i = 0; i < value; i++)
                                wid.add(Question(
                                  index: i,
                                ));
                              List<questions> onchangQuestions = <questions>[];

                              for (var i = 0; i < value; i++) {
                                onchangQuestions.add(questions());
                              }

                              setState(() {
                                ourQuestions = onchangQuestions;
                                serve = Column(
                                  children: wid,
                                );
                              });
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              // for version 2 and greater youcan also use this
                              FilteringTextInputFormatter.digitsOnly
                            ],

                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter number of questions';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    serve,
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            if (_pickedImage != null) {
                              final ref = await FirebaseStorage.instance
                                  .ref()
                                  .child("quizImages")
                                  .child("$name.jpg");
                              await ref.putFile(_pickedImage as File);
                              url = await ref.getDownloadURL();
                            }
                            final document =
                                await _firestore.collection("quiz").add({
                              "NOquestions": numberOfQuestion,
                              "category": widget.category,
                              "difficulty": difficulty,
                              "duration": duration,
                              "quizName": name,
                              "url": url,
                            });
                            int i = 0;
                            for (var element in ourQuestions) {
                              await _firestore.collection("question").add({
                                "Question": element.name,
                                "correct": element.correct,
                                "index": i,
                                "option1": element.option1,
                                "option2": element.option2,
                                "option3": element.option3,
                                "option4": element.option4,
                                "quizID": document.id
                              });
                              i++;
                            }
                          }
                          reset();
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: text("quiz added successfully !", 22,
                                      Colors.green),
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
                                              text("back to Quizes page", 19,
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

class DifficultyDropdownButton extends StatefulWidget {
  const DifficultyDropdownButton({super.key});

  @override
  State<DifficultyDropdownButton> createState() =>
      _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DifficultyDropdownButton> {
  String dropdownValue = Difficulties.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
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
          difficulty = value;
        });
      },
      items: Difficulties.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class Question_Answer_DropdownButton extends StatefulWidget {
  const Question_Answer_DropdownButton({super.key, required this.index});
  final int index;

  @override
  State<Question_Answer_DropdownButton> createState() =>
      _Question_Answer_DropdownButton();
}

class _Question_Answer_DropdownButton
    extends State<Question_Answer_DropdownButton> {
  String dropdownValue = Answers.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
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
          ourQuestions[widget.index].correct = value as String;
          dropdownValue = value!;
        });
      },
      items: Answers.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class Question extends StatefulWidget {
  const Question({super.key, required this.index});
  final int index;

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Question (" + (widget.index + 1).toString() + ") :",
            style: TextStyle(
              color: HexColor.fromHex('1C1917'),
              fontSize: 15,
              fontFamily: 'Cairo',
              decoration: TextDecoration.none,
            ),
          ),
          TextFormField(
            onChanged: (value) {
              ourQuestions[widget.index].name = value;
              ourQuestions[widget.index].correct = Answers[0];
            },
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 13 * 4),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the question';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
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
              ourQuestions[widget.index].option1 = value;
            },
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 13 * 4),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter quiz name';
              }
              return null;
            },
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
              ourQuestions[widget.index].option2 = value;
            },
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 13 * 4),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter quiz name';
              }
              return null;
            },
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
              ourQuestions[widget.index].option3 = value;
            },
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 13 * 4),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter quiz name';
              }
              return null;
            },
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
              ourQuestions[widget.index].option4 = value;
            },
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 13 * 4),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter quiz name';
              }
              return null;
            },
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
          Question_Answer_DropdownButton(index: widget.index),
          SizedBox(
            height: 30,
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
