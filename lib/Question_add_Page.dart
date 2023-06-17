import 'Ques_model.dart';
import 'package:flutter/material.dart';
import 'main.dart';

int _index_ques_add = 0;

class Ques_add extends StatefulWidget {
  Ques_add(int _index) {
    _index_ques_add = _index;
  }

  @override
  State<Ques_add> createState() => _Ques_addState();
}

class _Ques_addState extends State<Ques_add> {
  int answr_index = 0;
  String ques = "";
  String level = "";
  List<String> choices_ques_add = ["", "", "", ""];
  List<String> choices = [];
  int? current_radio;
  String? current_level;
  Color color_lvl=Colors.white;
  @override
  Widget build(BuildContext context) {
    int? current_active;
    return WillPopScope(
      onWillPop: () async => false,
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
                                level=current_level!;
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
                                level=current_level!;

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
                                level=current_level!;
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
                          onPressed: () {
                            checkcolor();
                            ques_dtl_lst[_index_ques_add] = Question_model(
                                ques, choices_ques_add,level,current_radio!,color_lvl);
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return HomePage();
                            }), (r) {
                              return false;
                            });
                            print(ques_dtl_lst
                                .elementAt(_index_ques_add)
                                .question);
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
    if(level=="Easy"){
      color_lvl=Colors.green.shade200;
    }
    else if(level=="Hard"){
      color_lvl=Colors.red.shade200;
    }
    else if(level=="Medium"){
      color_lvl=Colors.blue.shade200;
    }
  }
}
