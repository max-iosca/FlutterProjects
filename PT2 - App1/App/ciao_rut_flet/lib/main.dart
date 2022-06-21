import 'package:flutter/material.dart';
//material.io per info

void main() => runApp(RutApp());
//runApp è un metodo, dentro ha il nome di una classe che creeremo..
//ma che è semplicemente il NOME DEL WIDGET da cui l'app partirà

//N.B. LE PROPRIETA' (come home: ,ecc... sono scritte in camel case
//N.B. I WIDGET (Text o Scaffold) sono scritti in Pascal Case

/**
 * 2 Tipi di widget: Stateless E StateFul
 * - StatelessWidget dove il contenuto del widget NON CAMBIA durante il ciclo di vita
 * ovvero, dopo che hai creato il widget, non ti serve cambiarlo.
 * - StateFul invece dove il contenuto PUO' CAMBIARE durante il ciclo di vita
 */
class RutApp extends StatelessWidget {
  /**
   * perchè st'override? perchè nella classe StatelessWidget EREDITATA ne è già presente uno
   * che NOI vogliamo "sovrascrivere"....metodo build(che indovina un po'? ritorna un widget).
   * Questo metodo indica a Flutter che/cosa interfaccia grafica dovrà visualizzare
   * infatti il parametro passato è "BuildContext context"
   */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rut Flet',//Questo si vede quando scorri tra le app aperte del device
      theme: ThemeData(primarySwatch: Colors.brown),
      //è il widget RADICE o di partenza di una app
      //home: Text('Gelateria da Rut Flet'), // home è una proprietà che contiene un widget Text
      home: Scaffold(
          //Il BODY di uno SCAFFOLD accetta UN SOLO WIDGET
          appBar: AppBar(
            title: Text('Gelateria da Rut Flet'),//questo si vede in alto quando la app è aperta
          ),
          body: Builder(builder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(height: 50,),
                  Text('Il gelato migliore del mondo',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),),
                  Container(height: 50,),
                  Image.network('https://bit.ly/flutgelato'),
                  Container(height: 100,),
                  ElevatedButton(
                      onPressed: () {
                        SnackBar snackBar = SnackBar(
                          content: Text('La mail di info è: rut@flet.dev'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      //quando viene premuto, si aspetta un metodo richiamato quando l'utente preme il pulsante
                      child: Text('!Informazioni!',
                      style: TextStyle(
                        color:Colors.white,
                        fontSize: 20,
                      ),))
                ],
              ),
            );
          })),
    );
  }
}

//Conteiner è il widget più flessibile, con altezza e larghezza

// SHORTCUT PER INDENTARE : CTRL+ALT+L
//SETTINGS->LANGUAGES&fRAMEWORK->FLUTTER and check FORMAT CODE ON SAVE.
// ALMENO INDENTA DA SOLO AD OGNI AUTO-SALVATAGGIO. VERY NICE!
