import 'package:flutter/material.dart';

class MyColor{
  int r;
  int g;
  int b;

  MyColor({@required this.r, @required this.g, @required this.b});

  factory MyColor.fromJson(Map<String, dynamic> parsedJson){
    return MyColor(
      r: parsedJson['r'],
      g: parsedJson['g'],
      b: parsedJson['b'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "r": this.r,
      "g": this.g,
      "b": this.b,
    };
  }

  // static List encodeToJson(List<MyColor> list){
  //   List jsonList = List();
  //   list.map((item) => 
  //     jsonList.add(item.toJson())
  //   ).toList();
  //   return jsonList;
  // }
}