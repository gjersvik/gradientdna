part of gradientdna;

class Fitnes{
  List<Ddna> ddna;
  List<ImageData> data;
  List<double> fit;
  
  ImageData _data;
  
  List<double> run(List<Ddna> d){
    ddna = d;
    timer(paintAll,'PaintAll');
    timer(testAll,'TestAll');
    return fit;
  }
  
  paintAll(){
    var img = querySelector('#image');
    var canvas = new CanvasElement(width: 32,height: 32);
    var p = canvas.getContext('2d');
    p.drawImage(img, 32, 32);
    _data = p.getImageData(0, 0, 32, 32);
    data = ddna.map((d){
      paint(p,d,32);
      return p.getImageData(0, 0, 32, 32);
    }).toList();
  }
  
  testAll(){
    fit = data.map(test).toList();
  }
  
  double test(ImageData data){
    var length = data.data.length;
    var pix = new Iterable.generate(length,(i){
      return (256 - (data.data[i] - _data.data[i]).abs()) / 256;
    });
    
    return pix.map((d) => d / (length)).reduce((a,b) => a + b);
  }
  
  paint(CanvasRenderingContext2D paint, Ddna ddna,[int size = 256]){
    paint.fillStyle = ddna.bgColor.toString();
    paint.fillRect(0,0,size,size);
    
    ddna.gradiants.forEach((Gradiant g){
      CanvasGradient gradient;
      if(g.radial){
        gradient = paint.createRadialGradient(g.x0 * size, g.y0*size, g.r0*size, g.x1*size, g.y1*size, g.r1*size);
      }else{
        gradient = paint.createLinearGradient(g.x0 *size, g.y0*size, g.x1*size, g.y1*size);
      }
      
      g.steps.forEach((Step s){
        gradient.addColorStop(s.offset, s.color.toString());
      });
      
      paint.fillStyle = gradient;
      paint.fillRect(0,0,size,size);
    });
  }
}