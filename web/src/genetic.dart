part of gradientdna;

class Genetic{
  int pop = 20;
  List<Ddna> population;
  List<double> fitnes;
  Image image = new Image();
  Mutate mutate = new Mutate();
  
  init(){
    population = new List.generate(pop, (_) => new Ddna.random());
  }
  
  test(){
    fitnes = population.map(_testDna).toList();
  }
  
  selection(){
    population = new SplayTreeMap.fromIterables(fitnes, population)
            .values.toList().reversed.take(2).toList();
  }
  
  repopulate(){
    population = mutate.populate(population,pop - population.length);
  }
  
  paint(){
    var score = querySelector('#score');
    CanvasElement canvas = querySelector('#gradient');
    CanvasRenderingContext2D paint = canvas.getContext('2d');
    _paintDdna(paint,population.first);
    score.text = image.test(paint.getImageData(0, 0, 256, 256)).toString();
  }
  
  start(){
    timer(init, 'Generate 1000Ddna');
    new Timer.periodic(const Duration(milliseconds: 500), (t)=> timer(loop, 'Generation:'));
  }
  
  loop(){
    timer(test, 'Test');
    timer(selection, 'Selection');
    timer(repopulate, 'Populate');
    timer(paint, 'Paint');
  }
  
  timer(callback, String name){
    var start = new DateTime.now();
    var temp = callback();
    var dur = new DateTime.now().difference(start);
    print('$name:$dur');
  }
  
  _paintDdna(paint, ddna){
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
  
  double _testDna(Ddna ddna){
    var canvas = new CanvasElement(width: 256,height: 256);
    _paintDdna(canvas.getContext('2d'),ddna);
    var data = canvas.getContext('2d').getImageData(0, 0, 256, 256);
    return image.test(data);
  }
}