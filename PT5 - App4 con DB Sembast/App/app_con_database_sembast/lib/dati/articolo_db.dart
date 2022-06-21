// ignore_for_file: unnecessary_null_comparison

import 'dart:async'; //Metodi asincroni, con async e await
import 'package:path_provider/path_provider.dart'; //per trovre il percorso del db
import 'package:path/path.dart'; //concatenamento con il percorso
import 'package:sembast/sembast.dart'; //il nostro DB!
import 'package:sembast/sembast_io.dart'; //contiene alcuni oggetti disembast che ci permettono di effettuare azioni lettura/scrittura di un db
import 'articolo.dart';

class ArticoloDb {
  DatabaseFactory dbFactory = databaseFactoryIo;
  late Database _db; // quindi è privato!
  final store = intMapStoreFactory.store('articoli');

  //STATICA perchè la variabile sarà valida durante l'intero ciclo di vita del programma
  static final ArticoloDb _singleton = ArticoloDb._internal();

  ArticoloDb._internal();

  //CON UN FACTORY CONSTRUCTOR POSSO DECIDERE COSA RESTITUISCE IL COSTRUTTORE,
  //INVECE DI CREARE UNA NUOVA ISTANZA, RESTITUISCE SEMPRE LA STESSA!
  factory ArticoloDb() {
    return _singleton;
  }

  Future<Database> init() async {
    if (_db == null) {
      _openDb().then((db) {
        _db = db;
      });
    }
    return _db;
  }

  Future _openDb() async{
    //restituisce il percorso della cartella documenti sul sistema in uso
    final percorsoDocumenti= await getApplicationDocumentsDirectory();
    final percorsoDb = join(percorsoDocumenti.path, 'articoli.db');
    final db = await dbFactory.openDatabase(percorsoDb);
    return db;
  }

  Future inserisciArticolo(Articolo articolo) async{

    //il metodo .add restituisce un intero al chiamante, rappresenta un identificativo univoco!
    int id = await store.add(_db, articolo.trasformaInMap());
    return id;
  }

  Future<Iterable<Articolo>> leggiArticoli() async {
    if (_db == null) {
      await init();
    }

    final finder = Finder(sortOrders: [
      SortOrder('id')
    ]);
    final articoliSnapshot = await store.find(_db, finder:finder);
    return articoliSnapshot.map((elemento){
      final articolo = Articolo.daMap(elemento.value);
      articolo.id = elemento.key;
      return articolo;
    }).toList();
  }

  Future aggiornaArticolo(Articolo articolo) async {
  //Istruzione temporanea, poi RICORDATI di commentarla  
  //Database db = await _openDb();
  final finder = Finder (filter: Filter.byKey(articolo.id));
  await store.update(_db, articolo.trasformaInMap(), finder:finder);
  }

  Future eliminaArticolo(Articolo articolo) async {

    final finder = Finder (filter: Filter.byKey(articolo.id));
    await store.delete(_db, finder:finder);
  }

  Future eliminaDatiDb() async {
    await store.delete(_db);
  }
}
