import 'package:flutter/material.dart'; //sempre per i widget
import '../dati/articolo.dart'; 
import '../dati/articolo_db.dart'; //operazione scrittura/lettura su db
import 'lista_articoli.dart'; //ci serve per tornare alla pagina della lista articoli dovo aver salvato i dati

/**QUESTA CLASSE VERRA' RICHIAMATA SEMPRE DALLA PAGINA DELLA LISTA ARTICOLI
 * AL RICHIAMO, DOVREMMO PASSARE LA MODALITA' INSERIMENTO O MODIFICA, L'ARTICOLO CHE SARA' NUOVO O ESISTENTE.
 *
 */
class PaginaArticolo extends StatefulWidget {
  final Articolo articolo;
  final bool nuovo;
  PaginaArticolo(this.articolo, this.nuovo);
  @override
  _PaginaArticoloState createState() => _PaginaArticoloState();
}

class _PaginaArticoloState extends State<PaginaArticolo> {
  final TextEditingController txtNome = TextEditingController();
  final TextEditingController txtNote = TextEditingController();
  final TextEditingController txtQuantita = TextEditingController();

  @override
  void initState() {
    if (widget.nuovo) {
      txtNome.text = widget.articolo.nome ?? '';
      txtNote.text = widget.articolo.note ?? '';
      txtQuantita.text = widget.articolo.quantita ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dettaglio Articolo'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: salvaArticolo,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CasellaTesto(txtNome, 'Nome'),
            CasellaTesto(txtNote, 'Note'),
            CasellaTesto(txtQuantita, 'Quantità')
          ],),
      ),
    );
  }

  Future salvaArticolo() async {
    ArticoloDb db = ArticoloDb();
    widget.articolo.nome = txtNome.text;
    widget.articolo.note = txtNote.text;
    widget.articolo.quantita = txtQuantita.text;
    if (widget.nuovo) {
      await db.inserisciArticolo(widget.articolo);
    } else {
      await db.aggiornaArticolo(widget.articolo);
    }
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListaArticoli()),
    );
  }

}

class CasellaTesto extends StatelessWidget {
  late final TextEditingController controller;
  late final String titolo;


  CasellaTesto(this.controller, this.titolo);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: titolo,
        ),
      ),
    );
  }
}

