import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Question_add_Page.dart';

class Ldrbrd_pg extends StatefulWidget {
  const Ldrbrd_pg({Key? key}) : super(key: key);

  @override
  State<Ldrbrd_pg> createState() => _Ldrbrd_pgState();
}

class _Ldrbrd_pgState extends State<Ldrbrd_pg> {
  int count=0;
  List<int?> prv_scr=[];
  void initdata() async{
    final pref=await SharedPreferences.getInstance();
    count=pref.getInt('quiz_nmbr')!;
    for(int i=1;i<=count;i++){
      prv_scr.add(pref.getInt('quiz$i'));
      print(prv_scr.elementAt(i));
    }setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    initdata();
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          collapsedHeight: 70,
          expandedHeight: 250,
          title: Container(
            alignment: Alignment.topCenter,
            child: Text(
              "LeaderBoard",
              style: TextStyle(
                color: Color(0xFF191D63),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverList(delegate: SliverChildBuilderDelegate(
          childCount: count,
          (context, index) {
            return Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey.shade200,
                  backgroundBlendMode: BlendMode.darken),
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 12, 5, 12),
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
                  title: Text("Score:${prv_scr.elementAt(index)==null?0:prv_scr.elementAt(index)}",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
              ),
            );
          },
        )),
      ],
    );
  }
}
