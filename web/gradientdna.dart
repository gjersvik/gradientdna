import 'dart:html';
import 'dart:math';

void main() {
  var random = new Random();
  var ddna = new List.generate(3,(_) => random.nextDouble());
  
  CanvasElement canvas = querySelector('#gradient');
  CanvasRenderingContext2D paint = canvas.getContext('2d');
  
  paint.fillStyle = dnaToColor(ddna[0],ddna[1],ddna[1]);
  paint.fillRect(0,0,256,256);
}

String dnaToColor(double h,double s,double l,[double a = 1.0]){
  var rgb = hslToRgb(h * 360, s * 100, l *100);
  return 'rgba(${rgb[0]},${rgb[1]},${rgb[2]},$a)';
}

List<int> hslToRgb(num hue, num saturation, num luminance) {
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