library gradientdna;

import 'dart:html';
import 'dart:math';

part 'src/color.dart';
part 'src/ddna.dart';

void main() {
  var ddna = new Ddna();
  
  CanvasElement canvas = querySelector('#gradient');
  CanvasRenderingContext2D paint = canvas.getContext('2d');
  
  paint.fillStyle = ddna.bgColor().toString();
  paint.fillRect(0,0,256,256);
  
  print(ddna.ddna.length);
}