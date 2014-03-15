part of gradientdna;

class Mutate{
  var random = new Random();
  
  List<Ddna> populate(int childrencunt, Ddna select()){
    List<Ddna> list = new List.generate((childrencunt ~/ 5) + 1, (_) => select());
    for(int i = 0; i < childrencunt ~/ 5; i += 1){
      list.addAll(mate2(list[i], list[i + 1]));
    }
    return list;
  }
  
  Ddna mutate(Ddna d){
    var point = random.nextInt(583);
    d.ddna[point] = random.nextDouble();
    return d;
  }
  
  Ddna mate(Ddna a, Ddna b){
    var cross = random.nextInt(583);
    var list = [];
    list.addAll(a.ddna.take(cross));
    list.addAll(b.ddna.skip(cross));
    return mutate(new Ddna(list));
  }
  
  List<Ddna> mate2(Ddna a, Ddna b){
    var list = [];
    var cross = random.nextInt(583);
    list.add(new Ddna(new List()
      ..addAll(a.ddna.take(cross))
      ..addAll(b.ddna.skip(cross))
    ));
    list.add(new Ddna(new List()
      ..addAll(b.ddna.take(cross))
      ..addAll(a.ddna.skip(cross))
    ));
    
    cross = random.nextInt(583);
    list.add(new Ddna(new List()
      ..addAll(a.ddna.take(cross))
      ..addAll(b.ddna.skip(cross))
    ));
    list.add(new Ddna(new List()
      ..addAll(b.ddna.take(cross))
      ..addAll(a.ddna.skip(cross))
    ));
    
    return list.map(mutate).toList();
  }
}