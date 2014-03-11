part of gradientdna;

class Genetic{
  int pop = 1000;
  List<Ddna> population;
  Mutate mutate = new Mutate();
  Fitnes fitnes = new Fitnes();
  Selection select = new Selection();
  int gen = 0;
  
  init(){
    population = new List.generate(pop, (_) => new Ddna.random());
  }
  
  test(){
    fitnes.run(population);
  }
  
  selection(){
    select.update(population);
  }
  
  repopulate(){
    population = mutate.populate(pop,select.select);
  }
  
  paint(){
    gen += 1;
    CanvasElement canvas = querySelector('#gradient');
    CanvasRenderingContext2D paint = canvas.getContext('2d');
    fitnes.paint(paint,select.topDog);
    querySelector('#score').text = (select.topDog.fitnes*100).toString();
    querySelector('#gen').text = gen.toString();
  }
  
  start(){
    timer(init, 'Generate 1000Ddna');
    new Timer.periodic(const Duration(milliseconds: 100), (t)=> timer(loop, 'Generation:'));
  }
  
  loop(){
    timer(test, 'Test');
    timer(selection, 'Selection');
    timer(repopulate, 'Populate');
    timer(paint, 'Paint');
  }
}