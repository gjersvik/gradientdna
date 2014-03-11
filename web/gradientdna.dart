library gradientdna;

import 'dart:html';
import 'dart:math';

part 'src/color.dart';
part 'src/ddna.dart';
part 'src/image.dart';
part 'src/mutate.dart';

void main() {
  var image = new Image();
  var ddna = new Ddna.random();
  var score = querySelector('#score');
  
  CanvasElement canvas = querySelector('#gradient');
  CanvasRenderingContext2D paint = canvas.getContext('2d');
  
  paintDdna(paint, ddna);
  
  score.text = image.test(paint.getImageData(0, 0, 256, 256)).toString();
}

paintDdna(paint, ddna){
  paint.fillStyle = ddna.bgColor.toString();
  paint.fillRect(0,0,256,256);
  
  ddna.gradiants.forEach((Gradiant g){
    CanvasGradient gradient;
    if(g.radial){
      gradient = paint.createRadialGradient(g.x0, g.y0, g.r0, g.x1, g.y1, g.r1);
    }else{
      gradient = paint.createLinearGradient(g.x0, g.y0, g.x1, g.y1);
    }
    
    g.steps.forEach((Step s){
      gradient.addColorStop(s.offset, s.color.toString());
    });
    
    paint.fillStyle = gradient;
    paint.fillRect(0,0,256,256);
  });
}