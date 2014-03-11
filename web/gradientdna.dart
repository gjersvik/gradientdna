library gradientdna;

import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'dart:collection';

part 'src/color.dart';
part 'src/ddna.dart';
part 'src/image.dart';
part 'src/mutate.dart';

void main() {
  var image = new Image();
  var mutate = new Mutate();
  List<Ddna> ddna = new List.generate(100, (_) => new Ddna.random());
  
  double testDna(Ddna ddna){
    var canvas = new CanvasElement(width: 256,height: 256);
    paintDdna(canvas.getContext('2d'),ddna);
    var data = canvas.getContext('2d').getImageData(0, 0, 256, 256);
    return image.test(data);
  }

  var score = querySelector('#score');
  
  CanvasElement canvas = querySelector('#gradient');
  CanvasRenderingContext2D paint = canvas.getContext('2d');
  
  new Timer.periodic(new Duration(milliseconds: 100), (t){
    var survivors = new SplayTreeMap.fromIterables(ddna.map(testDna), ddna)
        .values.toList().reversed.take(2).toList();
    paintDdna(paint, survivors.first);
    score.text = image.test(paint.getImageData(0, 0, 256, 256)).toString();
    ddna = mutate.populate(survivors,23);
  });
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