part of gradientdna;

class Mutate{
  var random = new Random();
  
  
  List<Ddna> populate(int childrencunt, Ddna select()){
    return new List.generate(childrencunt,(_) => mate(select(), select()));
  }
  
  Ddna mate(Ddna a, Ddna b){
    var cross = random.nextInt(583);
    var list = [];
    list.addAll(a.ddna.take(cross));
    list.addAll(b.ddna.skip(cross));
    return new Ddna(list);
  }
}