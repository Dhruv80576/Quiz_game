import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spider_task/Splash_page.dart';
import 'package:spider_task/Settings_pg.dart';
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
  int quiz_ques_nmbr=0;
  int esy_ques=0;
  int mdm_ques=0;
  int hrd_ques=0;
  void getvalue() async {
    final pref = await SharedPreferences.getInstance();
    if(pref.getInt('nmbr_ques')==null){
      quiz_ques_nmbr=2;
    }
    else{
      quiz_ques_nmbr=pref.getInt('nmbr_ques')!;
    }
  }
  @override
  Widget build(BuildContext context) {
    getvalue();
    return Scaffold(
      backgroundColor: Colors.white,
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
                SvgPicture.asset('assets/svg_main.svg'),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: FloatingActionButton(
                      onPressed: () {
                        if (ques_dtl_lst.length >=quiz_ques_nmbr) {
                          count_lvl_ques();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                backgroundColor: Color(0xFF1F487E),
                                title: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Select Level",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    )),
                                content: Text(
                                    "Select question level of which you want to take quiz.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if(esy_ques>=quiz_ques_nmbr){
                                        select_question(1);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Instrct_pg(quiz_list)));
                                      }
                                      else{
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Add ${quiz_ques_nmbr-esy_ques} easy level questions to continue.")));
                                      }
                                    },
                                    child: Text("EASY",
                                        style: TextStyle(
                                        )),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        if(mdm_ques>=quiz_ques_nmbr){
                                          select_question(2);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Instrct_pg(quiz_list)));
                                        }
                                        else{
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Add ${quiz_ques_nmbr-mdm_ques} medium level questions to continue.")));
                                        }
                                      },
                                      child: Text("MEDIUM")),
                                  ElevatedButton(
                                      onPressed: () {
                                        if(hrd_ques>=quiz_ques_nmbr){
                                          select_question(3);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Instrct_pg(quiz_list)));
                                        }
                                        else{
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Add ${quiz_ques_nmbr-hrd_ques} hard level questions to continue.")));
                                        }
                                      },
                                      child: Text("HARD")),
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
                                          "Add atleast ${quiz_ques_nmbr} questions of desired level to start quiz.",
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
            actions: [
              PopupMenuButton(
                color: Colors.white,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text("Settings"),
                      value: 0,
                    ),
                    PopupMenuItem(
                      child: Text("LeaderBoard"),
                      value: 1,
                    ),
                  ];
                },
                onSelected: (value) {
                  if (value == 0) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings_pg()));
                  } else if (value == 1) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Ldrbrd_pg()));
                  }
                },
              )
            ],
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: ques_dtl_lst.length == 0 ? 1 : ques_dtl_lst.length,
            (context, index) {
              return ques_dtl_lst.length == 0
                  ? Column(children: [
                      SizedBox(
                        height: 80,
                      ),
                      SvgPicture.asset(
                        'assets/no_message.svg',
                        width: 200,
                        height: 200,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ])
                  : Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 7),
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
                                color:
                                    ques_dtl_lst.elementAt(index).color_level,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: Text(
                                      ques_dtl_lst.elementAt(index).level))),
                        ),
                      ),
                    );
            },
          )),
        ],
      ),
      bottomSheet:Container(margin: EdgeInsets.fromLTRB(0, 0, 0, 2),height: 20,alignment: Alignment.bottomCenter,color:Colors.white,child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Made with Love in",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
          SvgPicture.asset('assets/india.svg',width: 50,height: 50,)
        ],
      )),
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

  void select_question(int level) {
    temp_quiz.clear();
    if (level == 1) {
      for (int i = 0; i < ques_dtl_lst.length; i++) {
        if (ques_dtl_lst.elementAt(i).level == "Easy") {
          temp_quiz.add(ques_dtl_lst.elementAt(i));
        }
      }
    } else if (level == 2) {
      temp_quiz.clear();
      for (int i = 0; i < ques_dtl_lst.length; i++) {
        if (ques_dtl_lst.elementAt(i).level == "Medium") {
          temp_quiz.add(ques_dtl_lst.elementAt(i));
        }
      }
    } else if (level == 3) {
      for (int i = 0; i < ques_dtl_lst.length; i++) {
        if (ques_dtl_lst.elementAt(i).level == "Hard") {
          temp_quiz.add(ques_dtl_lst.elementAt(i));
        }
      }
    }
    quiz_list.clear();
    Random random = new Random();
    while (quiz_list.length < quiz_ques_nmbr) {
      int temp = random.nextInt(temp_quiz.length);
      quiz_list.add(temp_quiz.elementAt(temp));
      temp_quiz.removeAt(temp);
    }
  }

  void count_lvl_ques() {
    for(int i=0;i<ques_dtl_lst.length;i++){
      if(ques_dtl_lst.elementAt(i).level=="Easy"){
        esy_ques++;
      }
      else if(ques_dtl_lst.elementAt(i).level=="Medium"){
        mdm_ques++;
      }
      else if(ques_dtl_lst.elementAt(i).level=="Hard"){
        hrd_ques++;
      }
    }
  }
}
