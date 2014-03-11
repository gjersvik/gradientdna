part of gradientdna;

class Genetic{
  int pop = 20;
  List<Ddna> population;
  List<double> fit;
  Mutate mutate = new Mutate();
  Fitnes fitnes = new Fitnes();
  
  init(){
    population = new List.generate(pop, (_) => new Ddna.random());
  }
  
  test(){
    fit = fitnes.run(population);
  }
  
  selection(){
    population = new SplayTreeMap.fromIterables(fit, population)
            .values.toList().reversed.take(2).toList();
  }
  
  repopulate(){
    population = mutate.populate(population,pop - population.length);
  }
  
  paint(){
    var score = querySelector('#score');
    CanvasElement canvas = querySelector('#gradient');
    CanvasRenderingContext2D paint = canvas.getContext('2d');
    fitnes.paint(paint,population.first);
    //score.text = image.test(paint.getImageData(0, 0, 256, 256)).toString();
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
}