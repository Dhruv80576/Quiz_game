import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spider_task/main.dart';

class Splash_screen extends StatelessWidget {
  const Splash_screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    initState(context);
    return Scaffold(
      body: Container(
        child: SvgPicture.asset('assets/images/main_bg.jpg'),

      ),
    );
  }
  void initState(BuildContext context){
    Timer(Duration(seconds: 5),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    },);
  }

}
