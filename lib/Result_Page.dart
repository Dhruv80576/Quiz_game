import 'package:flutter/material.dart';
import 'main.dart';
import 'Quiz_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Rslt_pg extends StatelessWidget {
  int _score = 0;
  int _correct = 0;
  int quiz_nmbr=0;
  Rslt_pg(this._score, this._correct);

  void save_score() async {
    final pref = await SharedPreferences.getInstance();
    quiz_nmbr = 0;
    if (pref.getInt('quiz_nmbr') == null) {
      quiz_nmbr = 1;
    } else {
      quiz_nmbr = (pref.getInt('quiz_nmbr')! + 1);
    }
    pref.setInt('quiz_nmbr', quiz_nmbr);
    pref.setInt('quiz$quiz_nmbr', _score);
    print("Quiz-nmbr:${pref.get('quiz_nmbr')}");
  }

  @override
  Widget build(BuildContext context) {
    save_score();
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 100,
            ),
            Align(
                alignment: Alignment.center,
                child: Container(
                    child: Icon(
                  Icons.library_books_outlined,
                  size: 100,
                  color: Color(0xFF1F487E),
                ))),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  "Result of Quiz",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF191D63),
                    fontWeight: FontWeight.bold,
                  ),
                )),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFFEDE8E3),
                  child: Icon(
                    Icons.star_border_rounded,
                    color: Color(0xFF1F487E),
                  ),
                ),
                title: Text(
                  "Score Gained",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: Text(_score.toString()),
              ),
            ),
            Divider(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFFEDE8E3),
                  child: Icon(
                    Icons.star_border_rounded,
                    color: Color(0xFF1F487E),
                  ),
                ),
                title: Text(
                  "Correct Predictions",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: Text(_correct.toString()),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return HomePage();
                  }), (r) {
                    return false;
                  });
                },
                label: Text(
                  "OKAY",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: Color(0xFF1F487E),
              ),
            )
          ],
        ),
      ),
    );
  }
}
