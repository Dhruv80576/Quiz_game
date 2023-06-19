import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Question_add_Page.dart';

class Ldrbrd_pg extends StatefulWidget {
  const Ldrbrd_pg({Key? key}) : super(key: key);

  @override
  State<Ldrbrd_pg> createState() => _Ldrbrd_pgState();
}

class _Ldrbrd_pgState extends State<Ldrbrd_pg> {
  int count = 0;
  List<int?> prv_scr = [];

  void initdata() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      count = pref.getInt('quiz_nmbr')!;
      for(int i=1;i<=count;i++){
        prv_scr.add(pref.getInt('quiz$i'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initdata();
    return Scaffold(
      body:ListView.builder(itemBuilder:(context, index) {
        return
          ListTile(
            title: Text("Quiz #${index+1}"),
            trailing: Text("Score:${prv_scr.elementAt(index)}"),
          );
      },itemCount: count,)
    );
  }
}
