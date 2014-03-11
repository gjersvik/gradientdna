part of gradientdna;

class Genetic{
  int pop = 1000;
  List<Ddna> population;
  Mutate mutate = new Mutate();
  Fitnes fitnes = new Fitnes();
  
  init(){
    population = new List.generate(pop, (_) => new Ddna.random());
  }
  
  test(){
    fitnes.run(population);
  }
  
  selection(){
    population = new SplayTreeMap
        .fromIterables(population.map((d)=>d.fitnes), population)
        .values.toList().reversed.take(100).toList();
  }
  
  repopulate(){
    population = mutate.populate(population,pop - population.length);
  }
  
  paint(){
    var score = querySelector('#score');
    CanvasElement canvas = querySelector('#gradient');
    CanvasRenderingContext2D paint = canvas.getContext('2d');
    fitnes.paint(paint,population.first);
    score.text = (population.first.fitnes*100).toString();
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