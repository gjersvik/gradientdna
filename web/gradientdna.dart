library gradientdna;

import 'dart:html';
import 'dart:math';

part 'src/color.dart';

void main() {
  var random = new Random();
  var ddna = new List.generate(3,(_) => random.nextDouble());
  
  CanvasElement canvas = querySelector('#gradient');
  CanvasRenderingContext2D paint = canvas.getContext('2d');
  
  var bgcolor = new Color.ddna(ddna);
  paint.fillStyle = bgcolor.toString();
  paint.fillRect(0,0,256,256);
}