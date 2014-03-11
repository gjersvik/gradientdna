part of gradientdna;

class Selection{
  var random = new Random();
  Map<double,Ddna> _base;
  Ddna topDog;
  
  update(List<Ddna> d){
    var fitnes = d.map((d)=> d.fitnes);
    var sum = fitnes.reduce((a, b) => a + b);
    var normal = fitnes.map((f) => (f / sum)).toList();
    var ac = 0.0;
    var acumilate = normal.map((f){
      var temp = ac;
      ac += f;
      return temp;
    }).toList();
    _base = new Map.fromIterables(acumilate, d);
    
    topDog = d.reduce((a, b){
      if(a.fitnes > b.fitnes){
        return a;
      }
      return b;
    });
  }
  
  Ddna select(){
    var r = random.nextDouble();
    var i = _base.keys.lastWhere((i) => r > i);
    return _base[i];
  }
}