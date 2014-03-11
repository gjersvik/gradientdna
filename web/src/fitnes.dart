part of gradientdna;

class Fitnes{
  Image image = new Image();
  List<Ddna> ddna;
  List<ImageData> data;
  List<double> fit;
  
  List<double> run(List<Ddna> d){
    ddna = d;
    timer(paintAll,'PaintAll');
    timer(testAll,'TestAll');
    return fit;
  }
  
  paintAll(){
    var canvas = new CanvasElement(width: 256,height: 256);
    var p = canvas.getContext('2d');
    data = ddna.map((d){
      paint(p,d);
      return p.getImageData(0, 0, 256, 256);
    }).toList();
  }
  
  testAll(){
    fit = data.map(image.test).toList();
  }
  
  paint(CanvasRenderingContext2D paint, Ddna ddna){
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
}