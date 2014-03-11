part of gradientdna;

class Ddna{
  List<double> ddna;
  Color bgColor;
  List<Gradiant> gradiants;
  
  Ddna(this.ddna){
    bgColor = new Color.ddna(ddna.take(3));
    gradiants = new List.generate(10, (i){
          var skip = 3 + i * 58;
          return new Gradiant(ddna.skip(skip).take(58));
        });
  }
  
  factory Ddna.random(){
    var random = new Random();
    return new Ddna(new List.generate(583,(_) => random.nextDouble()));
  }
}

class Step{
  double offset;
  Color color;
  
  Step(Iterable<double> ddna){
    offset = ddna.first;
    color = new Color.ddna(ddna.skip(1));
  }
}

class Gradiant{
  double x0;
  double x1;
  double y0;
  double y1;
  double r0;
  double r1;
  bool radial;
  
  List<Step> steps;
  
  Gradiant(Iterable<double> ddna){
    var local = ddna.take(8);
    x0 = ddna.elementAt(0) * 256;
    x1 = ddna.elementAt(1) * 256;
    y0 = ddna.elementAt(2) * 256;
    y1 = ddna.elementAt(3) * 256;
    r0 = ddna.elementAt(4) * 256;
    r1 = ddna.elementAt(5) * 256;
    radial = ddna.elementAt(6) >= 0.5;
    var stepcount = (ddna.elementAt(7) * 9).floor() + 2;
    steps = new List.generate(stepcount, (i){
      var skip = 8 + i * 5;
      return new Step(ddna.skip(skip).take(5));
    });
  }
}