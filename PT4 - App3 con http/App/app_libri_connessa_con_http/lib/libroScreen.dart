import 'package:flutter/material.dart';
import 'libro.dart';

class LibroScreen extends StatelessWidget {
  final Libro libro;
  LibroScreen(this.libro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(libro.titolo),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: Image.network(libro.immagineCopertina),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Scritto da: '+ libro.autori,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary
                  ),
                ),
              ),
              Padding(
                padding:EdgeInsets.all(8),
                child: Text('Editore: ' + libro.editore,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(libro.descrizione),
              ),
          ],
          ),
        ),
      )
    );
  }
}
/**
 * COME SI NAVIGA TRA LE PAGINE DI UN'APP? CON IL NAVIGATOR, e già lo sapevamo..
 * E' un oggetto! le varie pagine si chiamano ROUTE, inserite in uno STACK.
 *
 * il metodo push() inserisce una nuova pagina in cima a questo stack, tale metodo richiede un percorso...
 * ossia la pagina che voglio caricare, ed un contesto corrente...il solito Buildcontext context
 * Per il percorso si utilizza la CLASSE materialPageRoute, dove si spcifica il nome della classe da caricare.
 *
 *
 */
