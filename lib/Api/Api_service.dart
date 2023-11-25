import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Quiz_Model.dart';
class Api_serice{
  List<Quiz_Model> list=[];
  Future<List<Quiz_Model>> getques() async {
    try{
      var url=Uri.parse('http://192.168.26.43:3000/get_questions');
      var response= await http.get(url);
        var jsonList = jsonDecode(response.body) as List;
        for (var element in jsonList) {
          list.add(Quiz_Model.fromjson(element));
        }
        log("Success");
        return list;

    }
    catch (e){
      log("Failed"+e.toString());
    }
    return list;
  }
}