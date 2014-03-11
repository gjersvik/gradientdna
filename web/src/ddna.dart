part of gradientdna;

class Ddna{
  List<double> ddna;
  
  Ddna(){
    var random = new Random();
    ddna = new List.generate(3,(_) => random.nextDouble());
  }
  
  Color bgColor(){
    return new Color.ddna(ddna.take(3));
  }
}