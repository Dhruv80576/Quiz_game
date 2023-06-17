import 'package:flutter/material.dart';
class Question_model {
  String _question = "";
  List<String> _choices_model = [];
  String _level = "";
  int answr_indx = 0;
  var color_level=Colors.white;
  Question_model(
      this._question, this._choices_model, this._level, this.answr_indx,this.color_level);
  String get level => _level;
  List<String> get choices_model => _choices_model;
  set question(String value) {
    _question = value;
  }
  String get question => _question;

  set choices_model(List<String> value) {
    _choices_model = value;
  }

  set level(String value) {
    _level = value;
  }
}
