import 'dart:async';
import 'main.dart';
import 'package:flutter/material.dart';
import 'Ques_model.dart';
import 'Result_Page.dart';
List<Question_model> list_main = [];
int _score = 0;
int _correct=0;
class Quiz_Page extends StatefulWidget {
  Quiz_Page(List<Question_model> list) {
    print(list.length);
    list_main = list;
  }
  @override
  State<Quiz_Page> createState() => _Quiz_PageState();
}

class _Quiz_PageState extends State<Quiz_Page> {
  List<bool> tile_state = [false, false, false, false];
  int? usr_answr;
  var butn_color = Color(0xFFBABABA);
  int ques_nmbr = 0;
  Timer? countdownTimer;
  Duration myDuration = Duration(minutes:2);

  void calculate_result() {
    if (list_main.elementAt(ques_nmbr).answr_indx == usr_answr) {
      _correct++;
      _score += 4;
    } else {
      _score -= 1;
    }
  }

  void startTimer() {
    countdownTimer?.cancel();
    countdownTimer=Timer(Duration(seconds: 1), () => setCountDown());
  }
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      var seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) {
              int score=_score;
              int correct=_correct;
              _score=0;
              _correct=0;
              return Rslt_pg(score,correct);
            }), (r) {
              return false;
            });
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    String strDigits(int n) => n.toString().padLeft(2, '0');
    var hours = strDigits(myDuration.inHours.remainder(60));
    var minutes = strDigits(myDuration.inMinutes.remainder(60));
    var seconds = strDigits(myDuration.inSeconds.remainder(60));
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          color: Color(0xFFFAFAFF),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 50,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 30, 20),
                    child: Card(
                      child: Row(
                        children: [
                          Icon(
                            Icons.star_border_rounded,
                            size: 30,
                          ),
                          Text(_score.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      '$hours:$minutes:$seconds',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 40),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context, main);
                          },
                          icon: Icon(Icons.cancel)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,

                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: LinearProgressIndicator(
                  minHeight: 20,
                  backgroundColor: Color(0xFFF4F3F6),
                  color: Color(0xFF376996),
                  value:((ques_nmbr+1)/5),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${ques_nmbr + 1}/5",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(
                          "Format: +4 for  _correct answer,-1 for in_correct",
                          softWrap: true,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(15, 20, 15, 20),
                elevation: 2,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        child: Text(
                          list_main.elementAt(ques_nmbr).question,
                          style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFF191D63),
                              fontWeight: FontWeight.bold),
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            color: tile_state[0]
                                ? Color(0xFF1F487E)
                                : Color(0xFFF4F3F6)),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              if (tile_state[0] == true) {
                              } else {
                                tile_state[0] = true;
                                tile_state[1] = false;
                                tile_state[2] = false;
                                tile_state[3] = false;
                              }
                              usr_answr = 0;
                            });
                          },
                          leading: CircleAvatar(
                            backgroundColor: Color(0xFFEDE8E3),
                            child: tile_state[0]
                                ? Icon(
                                    Icons.check,
                                    color: Color(0xFF191D63),
                                  )
                                : Text(
                                    "A",
                                    style: TextStyle(color: Colors.black),
                                  ),
                          ),
                          title: Text(
                            list_main.elementAt(ques_nmbr).choices_model[0],
                            style: TextStyle(
                                color:
                                    tile_state[0] ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            color: tile_state[1]
                                ? Color(0xFF1F487E)
                                : Color(0xFFF4F3F6)),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              if (tile_state[1] == true) {
                              } else {
                                tile_state[1] = true;
                                tile_state[0] = false;
                                tile_state[2] = false;
                                tile_state[3] = false;
                              }
                              usr_answr = 1;
                            });
                          },
                          leading: CircleAvatar(
                            backgroundColor: Color(0xFFEDE8E3),
                            child: tile_state[1]
                                ? Icon(
                                    Icons.check,
                                    color: Color(0xFF191D63),
                                  )
                                : Text(
                                    "B",
                                    style: TextStyle(color: Colors.black),
                                  ),
                          ),
                          title: Text(
                            list_main.elementAt(ques_nmbr).choices_model[1],
                            style: TextStyle(
                                color:
                                    tile_state[1] ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            color: tile_state[2]
                                ? Color(0xFF1F487E)
                                : Color(0xFFF4F3F6)),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              if (tile_state[2] == true) {
                              } else {
                                tile_state[2] = true;
                                tile_state[1] = false;
                                tile_state[0] = false;
                                tile_state[3] = false;
                              }
                              usr_answr = 2;
                            });
                          },
                          leading: CircleAvatar(
                            backgroundColor: Color(0xFFEDE8E3),
                            child: tile_state[2]
                                ? Icon(
                                    Icons.check,
                                    color: Color(0xFF191D63),
                                  )
                                : Text(
                                    "C",
                                    style: TextStyle(color: Colors.black),
                                  ),
                          ),
                          title: Text(
                            list_main.elementAt(ques_nmbr).choices_model[2],
                            style: TextStyle(
                              color: tile_state[2] ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            color: tile_state[3]
                                ? Color(0xFF1F487E)
                                : Color(0xFFF4F3F6)),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              if (tile_state[3] == true) {
                              } else {
                                tile_state[3] = true;
                                tile_state[1] = false;
                                tile_state[2] = false;
                                tile_state[0] = false;
                              }
                              usr_answr = 3;
                            });
                          },
                          leading: CircleAvatar(
                            backgroundColor: Color(0xFFEDE8E3),
                            child: tile_state[3]
                                ? Icon(
                                    Icons.check,
                                    color: Color(0xFF191D63),
                                  )
                                : Text(
                                    "D",
                                    style: TextStyle(color: Colors.black),
                                  ),
                          ),
                          title: Text(
                            list_main.elementAt(ques_nmbr).choices_model[3],
                            style: TextStyle(
                                color:
                                    tile_state[3] ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            if (usr_answr != null) {
                              calculate_result();
                              print(_score);
                              BuildContext context_ = context;
                              showDialog(
                                context: context,
                                builder: (context) {
                                  context_ = context;
                                  return Container(
                                    alignment: Alignment.center,
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                      strokeWidth: 5,
                                      color: Color(0xFF191D63),
                                    ),
                                  );
                                },
                              );
                              new Future.delayed(
                                Duration(seconds: 1),
                                () {
                                  setState(() {
                                    Navigator.pop(context_);
                                    if (ques_nmbr == list_main.length - 1) {
                                      int score=_score;
                                      int correct=_correct;
                                      _score=0;
                                      _correct=0;
                                      Navigator.pushAndRemoveUntil(context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return Rslt_pg(score,correct);
                                      }), (r) {
                                        return false;
                                      });
                                    } else {
                                      ques_nmbr++;
                                    }
                                  });
                                  ;
                                },
                              );
                            }
                          },
                          label:ques_nmbr==list_main.length-1?Text("FINISH"):Text("CONTINUE"),
                          backgroundColor: usr_answr == null
                              ? Color(0xFFBABABA)
                              : Color(0xFF1F487E),
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4))),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
