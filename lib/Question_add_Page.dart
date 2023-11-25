import 'dart:convert';
import 'Login_Page.dart';
import 'Ques_model.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

int _index_ques_add = 0;
String ques = "";

class Ques_add extends StatefulWidget {
  // Ques_add(int _index) {
  //   _index_ques_add = _index;
  //   ques = ques_dtl_lst.elementAt(_index_ques_add).question;
  // }

  @override
  State<Ques_add> createState() => _Ques_addState();
}

class _Ques_addState extends State<Ques_add> {
  List<String> choices_ques_add = ["", "", "", ""];
  int answr_index = 0;
  String level = "";
  List<String> choices = [];
  int? current_radio;
  String? current_level;
  Color color_lvl = Colors.white;
  String txt_ques = ques_dtl_lst.elementAt(0).question;

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController_ques =
        TextEditingController(text: (ques));
    int? current_active;
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 40,
                ),
                Align(
                  child: Container(
                    child: Text(
                      "QUESTION DETAILS",
                      style: TextStyle(
                        color: Color(0xFF191D63),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  ),
                  alignment: Alignment.topCenter,
                ),
                SizedBox(
                  height: 30,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Ask",
                              style: TextStyle(
                                color: Color(0xFF191D63),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: TextField(
                            controller: textEditingController_ques,
                            enabled: true,
                            cursorColor: Color(0xFF191D63),
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF191D63),
                            ),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        style: BorderStyle.solid,
                                        color: Color(0xFF191D63)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            onChanged: (String text) {
                              ques = text;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Choices",
                              style: TextStyle(
                                color: Color(0xFF191D63),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        Container(
                          child: Column(children: [
                            TextField(
                              onChanged: (String text) {
                                choices_ques_add[0] = text;
                              },
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF191D63),
                              ),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          style: BorderStyle.solid,
                                          color: Color(0xFF191D63)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextField(
                              onChanged: (String text) {
                                choices_ques_add[1] = text;
                              },
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF191D63),
                              ),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          style: BorderStyle.solid,
                                          color: Color(0xFF191D63)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextField(
                              onChanged: (String text) {
                                choices_ques_add[2] = text;
                              },
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF191D63),
                              ),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          style: BorderStyle.solid,
                                          color: Color(0xFF191D63)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextField(
                              onChanged: (String text) {
                                choices_ques_add[3] = text;
                              },
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF191D63),
                              ),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          style: BorderStyle.solid,
                                          color: Color(0xFF191D63)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                            )
                          ]),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Answer",
                              style: TextStyle(
                                color: Color(0xFF191D63),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        RadioListTile(
                          value: 0,
                          groupValue: current_radio,
                          onChanged: (value) {
                            setState(() {
                              current_radio = value;
                            });
                          },
                          title: Text("1"),
                        ),
                        RadioListTile(
                          value: 1,
                          groupValue: current_radio,
                          onChanged: (value) {
                            setState(() {
                              current_radio = value;
                            });
                          },
                          title: Text("2"),
                        ),
                        RadioListTile(
                          value: 2,
                          groupValue: current_radio,
                          onChanged: (value) {
                            setState(() {
                              current_radio = value;
                            });
                          },
                          title: Text("3"),
                        ),
                        RadioListTile(
                          value: 3,
                          groupValue: current_radio,
                          onChanged: (value) {
                            setState(() {
                              current_radio = value;
                            });
                          },
                          title: Text("4"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Level",
                              style: TextStyle(
                                color: Color(0xFF191D63),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: RadioListTile(
                            activeColor: Colors.red.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            value: "Hard",
                            groupValue: current_level,
                            onChanged: (value) {
                              setState(() {
                                current_level = value;
                                level = current_level!;
                              });
                            },
                            title: Text("Hard"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: RadioListTile(
                            activeColor: Colors.blue.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            value: "Medium",
                            groupValue: current_level,
                            onChanged: (value) {
                              setState(() {
                                current_level = value;
                                level = current_level!;
                              });
                            },
                            title: Text("Medium"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: RadioListTile(
                            activeColor: Colors.green.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            value: "Easy",
                            groupValue: current_level,
                            onChanged: (value) {
                              setState(() {
                                current_level = value;
                                level = current_level!;
                              });
                            },
                            title: Text("Easy"),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        FloatingActionButton.extended(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          backgroundColor: Color(0xFF1F487E),
                          onPressed: () async {
                            if (ques.isNotEmpty &&
                                choices_ques_add[0].isNotEmpty &&
                                choices_ques_add[1].isNotEmpty &&
                                choices_ques_add[2].isNotEmpty &
                                    choices_ques_add[3].isNotEmpty &&
                                level.isNotEmpty) {
                              checkcolor();
                              // ques_dtl_lst[_index_ques_add] = Question_model(
                              //     ques,
                              //     choices_ques_add,
                              //     level,
                              //     current_radio!,
                              //     color_lvl);
                              final r = await http.post(
                                Uri.parse(
                                    'http://192.168.26.43:3000/add_question/' +
                                        email_main +
                                        '/' +
                                        password_main),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                                body: jsonEncode(<String, dynamic>{
                                  "question": ques,
                                  "answer": current_radio!,
                                  "level": level,
                                  "options": choices_ques_add
                                }),
                              );
                              if (r.statusCode == 200) {
                                const snackBar = SnackBar(
                                  content: Text('Questions successfully saved'),
                                );
// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                    (route) => false);
                                // }
                                // Navigator.pushAndRemoveUntil(context,
                                //     MaterialPageRoute(
                                //         builder: (BuildContext context) {
                                //           return HomePage();
                                //         }), (r) {
                                //       return false;
                                //     });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Fields cannot be empty")));
                              }
                            }
                          },
                          label: Text("Save"),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkcolor() {
    if (level == "Easy") {
      color_lvl = Colors.green.shade200;
    } else if (level == "Hard") {
      color_lvl = Colors.red.shade200;
    } else if (level == "Medium") {
      color_lvl = Colors.blue.shade200;
    }
  }
}
