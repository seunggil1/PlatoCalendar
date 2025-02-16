import 'package:flutter/material.dart';

final List<Color> themeSeedColors = <Color>{
  Colors.blueAccent,
  Colors.blueGrey,
  Colors.pinkAccent,
  Colors.orangeAccent,
  Colors.yellowAccent,
  Colors.greenAccent,
  Colors.tealAccent,
  Colors.deepPurpleAccent,
  Colors.purpleAccent,
}.map((Color color) {
  if (color.runtimeType == MaterialColor) {
    return (color as MaterialColor).shade100;
  } else if (color.runtimeType == MaterialAccentColor) {
    return (color as MaterialAccentColor).shade100;
  } else {
    return color;
  }
}).toList();
