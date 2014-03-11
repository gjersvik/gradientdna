part of gradientdna;

class Image{
  
  ImageData _data;
  
  Image(){
    var img = querySelector('#image');
    var canvas = new CanvasElement(width: 256,height: 256);
    canvas.getContext('2d').drawImage(img, 256, 256);
    _data = canvas.getContext('2d').getImageData(0, 0, 256, 256);
  }
  
  double test(ImageData data){
    var pix = new Iterable.generate(256*256*4,(i){
      return (256 - (data.data[i] - _data.data[i]).abs()) / 256;
    });
    
    return pix.map((d) => d / (256*256*4)).reduce((a,b) => a + b);
  }
}