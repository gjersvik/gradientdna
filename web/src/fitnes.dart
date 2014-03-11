part of gradientdna;

class Fitnes{
  CanvasElement canvas;
  var p;
  
  ImageData _data;
  int _size;
  
  Fitnes([size = 32]){
    _size = size;
    canvas = new CanvasElement(width: size,height: size);
    p = canvas.getContext('2d');
    
    var img = querySelector('#image');
    p.drawImage(img, size, size);
    _data = p.getImageData(0, 0, size, size);
    
  }
  
  run(List<Ddna> ddna){
    ddna.forEach((d){
      if(d.fitnes == null){
        paint(p,d,_size);
        d.fitnes = test(p.getImageData(0, 0, _size, _size));
      }
    });
  }
  
  double test(ImageData data){
    var length = data.data.length;
    var pix = new Iterable.generate(length,(i){
      return 1 - ((data.data[i] - _data.data[i]).abs() / 256);
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