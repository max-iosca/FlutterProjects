class Articolo {
  late int id;
  late String nome;
  late String quantita;
  late String note;

  //COSTRUTTORE CLASSICO, NONAMED
  Articolo(this.nome, this.quantita, this.note);

  //METODO
  Map<String, dynamic> trasformaInMap() {
    return {
      'id': id,// ?? null, ma è un tipo int ergo potrebbe essere un warning inutile in Run!
      'nome' : nome,
      'quantita' : quantita,
      'note' : note
    };
  }
  //COSTRUTTORE NO.NAMED
  Articolo.daMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map ['nome'];
    quantita = map['quantita'];
    note = map['note'];
  }
}