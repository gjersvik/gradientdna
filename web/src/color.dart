part of gradientdna;

class Color{
  int r = 0;
  int g = 0;
  int b = 0;
  double a = 1.0;
  
  Color();
  Color.ddna(Iterable<double> ddna){
    var rgb = hslToRgb(ddna.elementAt(0) * 360, ddna.elementAt(1) * 100, ddna.elementAt(2) *100);
    r = (ddna.elementAt(0) * 256).floor();
    g = (ddna.elementAt(1) * 256).floor();
    b = (ddna.elementAt(2) * 256).floor();
    
    if(ddna.length == 4){
      a = ddna.elementAt(3)/2;
    }
  }
  
  String toString(){
    return 'rgba($r,$g,$b,${a.toStringAsFixed(5)})';
  }
  
  static List<int> hslToRgb(num hue, num saturation, num luminance) {
    var rgb = [0, 0, 0];

    hue = hue / 360 % 1;
    saturation /= 100;
    luminance /= 100;

    if (hue < 1 / 6) {
      rgb[0] = 1;
      rgb[1] = hue * 6;
    } else if (hue < 2 / 6) {
      rgb[0] = 2 - hue * 6;
      rgb[1] = 1;
    } else if (hue < 3 / 6) {
      rgb[1] = 1;
      rgb[2] = hue * 6 - 2;
    } else if (hue < 4 / 6) {
      rgb[1] = 4 - hue * 6;
      rgb[2] = 1;
    } else if (hue < 5 / 6) {
      rgb[0] = hue * 6 - 4;
      rgb[2] = 1;
    } else {
      rgb[0] = 1;
      rgb[2] = 6 - hue * 6;
    }

    rgb = rgb.map((val) => val + (1 - saturation) * (0.5 - val));

    if (luminance < 0.5) {
      rgb = rgb.map((val) => luminance * 2 * val);
    } else {
      rgb = rgb.map((val) => luminance * 2 * (1 - val) + 2 * val - 1);
    }

    rgb = rgb.map((val) => (val * 255).round());

    return rgb.toList();
  }
}