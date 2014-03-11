part of gradientdna;

class Mutate{
  var random = new Random();
  
  List<Ddna> populate(List<Ddna> parent, int childrencunt){
    var children = new List.generate(childrencunt,(_){
      parent.shuffle(random);
      return mate(parent.first, parent.last);
    });
    parent.add(children);
    return parent;
  }
  
  Ddna mate(Ddna a, Ddna b){
    var list = new List.generate(583,(i){
      var mn = min(a.ddna[i],b.ddna[i]);
      var delta = max(a.ddna[i],b.ddna[i]) - mn;
      return mn + delta * random.nextDouble();
    });
    return new Ddna(list);
  }
}