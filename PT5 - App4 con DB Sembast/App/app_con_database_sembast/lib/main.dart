import 'package:app_con_database_sembast/dati/articolo_db.dart';
import 'package:app_con_database_sembast/pagine/lista_articoli.dart';
import 'package:flutter/material.dart';
import 'dati/articolo.dart';

/**
 * SEMBAST: SIMPLE EMBEDDED APPLICATION STORE DATABASE. E' un DB NOSQL basato su documenti in formato JSON
 * e caricato in memoria su un singolo file
 */
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaArticoli(),
    );
  }
}

class ProvaDb extends StatefulWidget {
  const ProvaDb({Key? key}) : super(key: key);

  @override
  _ProvaDbState createState() => _ProvaDbState();
}

class _ProvaDbState extends State<ProvaDb> {

  //int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM table_name'));
  var id = 0; //=  Sqflite.firstIntValue(await articoloDb.rawQuery('SEKECT COUNT(*) FROM id')) ;


  @override
  void initState(){
    provaDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('SpesApp'),),
      body: Center(
        child: Container(
          child: Text(id.toString()),
        ),
      )
    );
  }

  Future provaDb() async {
    ArticoloDb articoloDb = ArticoloDb();
    Articolo articolo1 = Articolo('arance', '2kg','da spremuta');
    id = await articoloDb.inserisciArticolo(articolo1);
    /*
    Articolo articolo2 = Articolo('mele', '3kg', 'per frullati');
    id = await articoloDb.inserisciArticolo(articolo2);
    */
    setState(() {
      id = id;
    });
  }
}

