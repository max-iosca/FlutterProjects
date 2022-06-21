import 'package:flutter/material.dart';
import '../dati/articolo.dart';
import '../dati/articolo_db.dart';
import 'articolo.dart';

class ListaArticoli extends StatefulWidget {
  const ListaArticoli({Key? key}) : super(key: key);

  @override
  _ListaArticoliState createState() => _ListaArticoliState();
}

class _ListaArticoliState extends State<ListaArticoli> {
  late ArticoloDb db;
  List<Articolo> lista = [];
  bool isLoaded = false;
  @override
  void initState() {
    db = ArticoloDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Lista della spesa'),
        actions: [IconButton(
          icon: const Icon(Icons.delete_sweep),
          onPressed: cancellaTutto)],
      ),
      body: FutureBuilder(//crea l'interfaccia grafica in base al contenuto di un Future
        future: leggiArticoli(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot){
          /**
           *  L.A.T.
           */
          lista = snapShot.data;
          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (_, index) {
              return Dismissible(
                key: Key(lista[index].id.toString()),
                onDismissed: (_) {
                  db.eliminaArticolo(lista[index]);
                },
                child: ListTile(
//LA SINTASSI CON IL DOPPIO ?? CONTROLLA SE QUEL VALORE è NULL, IN TAL CASO RESTITUISCE QUEL CHE SEGUE DOPO I ??
                  title: Text(lista[index].nome ?? ''),
                  subtitle: Text('Quantità' + (lista[index].quantita ?? '')
                  + ' - Note ' + lista[index].note ?? ''),
                  onTap: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        PaginaArticolo(lista[index],false)));
                  }),
              );
            },);
        },),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                PaginaArticolo(Articolo('','',''), true)));
        }),
    );
  }
  Future leggiArticoli() async {
    Iterable<Articolo> articoli = await db.leggiArticoli();
    return articoli;
  }

  void cancellaTutto() {
    AlertDialog alert = AlertDialog(
      title: Text('SICURO di voler ELIMINARE TUTTI gli elementi dalla lista?'),
      content: Text('Questa azione è irreversibile'),
      actions: [
        FlatButton(
          child: Text('SI'),
          onPressed: () {
            db.eliminaDatiDb().then((value) {
              setState(() {
                db = ArticoloDb(); //riaggiorna lo stato del db ricaricando la lista
              });
            Navigator.pop(context);
            });
          },
        ),
        FlatButton(
          child: Text('NO'),
          onPressed: () {
            Navigator.pop(context);
          })],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        }
    );

  }

}
