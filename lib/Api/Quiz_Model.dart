import 'package:flutter/material.dart';
class Quiz_Model {
  final String question;
  final List<dynamic> options;
  final int answer_indx;
  final String level;
  Quiz_Model({required this.question, required this.options, required this.answer_indx,required this.level});
  factory Quiz_Model.fromjson(Map<String,dynamic> json){
    return Quiz_Model(question: json["question"], options: json["options"], answer_indx: json["answer"],level: json["level"]);
  }
}