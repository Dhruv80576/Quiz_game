import 'dart:async';

import 'package:flutter/material.dart';
import 'Quiz_Page.dart';
import 'Ques_model.dart';

Widget _dialogContent = CircularProgressIndicator();

class Instrct_pg extends StatefulWidget {
  List<Question_model> list;

  Instrct_pg(this.list) {}

  @override
  State<Instrct_pg> createState() => _Instrct_pgState();
}

class _Instrct_pgState extends State<Instrct_pg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(250, 250, 255, 100),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                "Instructions",
                style: TextStyle(
                  color: Color(0xFF191D63),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
              elevation: 5,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 30, 15, 50),
                    child: Text(
                      "1. Do not invovle in any mode of unfair methods.\n\n"
                      "2. Keep view on timer.\n\n"
                      "3. You can move to next question only after answering current question.\n\n"
                      "4. +4 will be awarded for right answer.-1 for wrong answer.\n\n"
                      "5. After time limit is achieved quiz will automatically submit.\n\n"
                      "6. Result will be displayed after the quiz ends.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF191D63),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: FloatingActionButton.extended(
                      backgroundColor: Color(0xFF191D63),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      elevation: 0,
                      onPressed: () {
                        BuildContext context_=context;
                        showDialog(context: context, builder:(context) {
                          context_=context;
                          return Container(
                            alignment: Alignment.center,
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              strokeWidth:5,
                              color: Color(0xFF191D63),
                            ),
                          );
                        },);
                        new Future.delayed(Duration(seconds: 2),() {
                          Navigator.pop(context_);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Quiz_Page(widget.list)));
                        },);
                      },
                      label: Text(
                        "Start Quiz",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      icon: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
