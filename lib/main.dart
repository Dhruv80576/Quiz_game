import 'package:flutter/cupertino.dart';
import 'package:spider_task/Splash_page.dart';

import 'Instructions_Page.dart';
import 'package:flutter/material.dart';
import 'Quiz_Page.dart';
import 'dart:math';
import 'Ques_model.dart';
import 'Question_add_Page.dart';
import 'Leaderboard_pg.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<Question_model> ques_dtl_lst = [];
List<Question_model> quiz_list = [];
List<Question_model> temp_quiz = [];
List<Question_model> easy_ques_lst = [];
List<Question_model> medium_ques_lst = [];
List<Question_model> hard_ques_lst = [];
List<bool> a = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int list_count = ques_dtl_lst.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            snap: true,
            floating: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            backgroundColor: Color(0xFF1F487E),
            collapsedHeight: 70,
            expandedHeight: 300,
            flexibleSpace: Stack(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        margin: EdgeInsets.all(20),
                        child: GestureDetector(
                          child: Icon(Icons.leaderboard),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Ldrbrd_pg()));
                          },
                        ))),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: FloatingActionButton(
                      onPressed: () {
                        if (ques_dtl_lst.length >= 5) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                backgroundColor: Color(0xFF1F487E),
                                title: Align(alignment: Alignment.center,child: Text("Select Level",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)),
                                content:  Text(
                                      "Select question level of which you want to take quiz.",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        select_question();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Instrct_pg(quiz_list)));
                                      }, child: Text("EASY")),
                                  ElevatedButton(
                                      onPressed: () {
                                        select_question();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Instrct_pg(quiz_list)));
                                      }, child: Text("MEDIUM")),
                                  ElevatedButton(
                                      onPressed: () {
                                        select_question();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Instrct_pg(quiz_list)));
                                      }, child: Text("HARD")),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Container(
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                  backgroundColor: Color(0xFF1F487E),
                                  title: Icon(Icons.error_outline_rounded,
                                      color: Colors.white, size: 50),
                                  actions: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 0, 15, 0),
                                        child: Text(
                                          "Add atleast 5 questions in the list to start quiz.",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: FloatingActionButton.extended(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25))),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        label: Text(
                                          "OKAY",
                                          style: TextStyle(
                                            color: Color(0xFF1F487E),
                                            fontSize: 20,
                                          ),
                                        ),
                                        isExtended: true,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.play_arrow_rounded,
                        size: 50,
                        color: Color(0xFF1F487E),
                      ),
                    ),
                  ),
                )
              ],
            ),
            title: Text(
              "Abhyas",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: ques_dtl_lst.length,
            (context, index) {
              return Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey.shade200,
                    backgroundBlendMode: BlendMode.darken),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  child: ListTile(
                    enableFeedback: true,
                    dense: true,
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFFEDE8E3),
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                            color: Color(0xFF1F487E),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    title: Text(
                      softWrap: true,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      ques_dtl_lst.elementAt(index).question,
                      style: TextStyle(color: Colors.black, fontSize: 19),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Ques_add(index)));
                    },
                    trailing: Container(
                        decoration: BoxDecoration(
                          color: ques_dtl_lst.elementAt(index).color_level,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Text(ques_dtl_lst.elementAt(index).level))),
                  ),
                ),
              );
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            ques_dtl_lst
                .add(Question_model("", ["", "", "", ""], "", 0, Colors.white));
            list_count++;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Ques_add(ques_dtl_lst.length - 1)));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(("Add deltails about question.").toString()),
          ));
        },
        child: Icon(
          Icons.add,
          size: 25,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF1F487E),
      ),
    );
  }

  void select_question() {
    temp_quiz.clear();
    for (int i = 0; i < ques_dtl_lst.length; i++) {
      temp_quiz.add(ques_dtl_lst.elementAt(i));
    }
    quiz_list.clear();
    Random random = new Random();
    while (quiz_list.length < 5) {
      int temp = random.nextInt(temp_quiz.length);
      quiz_list.add(temp_quiz.elementAt(temp));
      temp_quiz.removeAt(temp);
    }
  }
}
