library gradientdna;

import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'dart:collection';

part 'src/color.dart';
part 'src/ddna.dart';
part 'src/fitnes.dart';
part 'src/genetic.dart';
part 'src/image.dart';
part 'src/mutate.dart';

void main() {
  var gen = new Genetic();
  gen.start();
}

timer(callback, String name){
  var start = new DateTime.now();
  var temp = callback();
  var dur = new DateTime.now().difference(start);
  print('$name:$dur');
}