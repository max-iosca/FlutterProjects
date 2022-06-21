import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //LEVA L'ETICHETTA 'DEBUG' IN ALTO A DESTRA DELL'EMULATORE
      title: 'Calcola costi Viaggio', //NOME APP
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: CalcolaCostiScreen(), //NOME DELLA CLASSE CHE FARA' DA HOME AL NOSTRO PROGRAMMA
    );
  }
}

class CalcolaCostiScreen extends StatefulWidget {
//IN UNO STATEFULWIDGET, NON C'E' OVERRIDE DEL METODO BUILD, MA SI FA...
//DEL METODO CREATESTATE(). SI FA SEMPRE!!! RICORDATELO!!
//infatti, qui sotto faccio l'override del createState, fornendogli dopo la => il nome di una classe (privata) che conterrà TUTTO.
  @override
  _CalcolaCostiScreenState createState() => _CalcolaCostiScreenState();
//UNA CLASSE PRECEDUTA DALL'UNDERSCORE _ è SINONIMO DI CLASSE PRIVATA (tipo il private in Java)
}



//con CTRL+BCKS ti fa vedere quali PROPRIETA' e WIDGET puoi creare in quel punto
class _CalcolaCostiScreenState extends State<CalcolaCostiScreen> {
  String tipoPercorso = 'Nessun Percorso';
  String messaggio = '';
  final TextEditingController chilometriController = TextEditingController();
  final List<String> tipiPercorso = ['Urbano', 'Extraurbano', 'Misto','Nessun Percorso'];
//DAVA UN ERRORE IN CUI value NON POTEVA ESSERE NULL OPPURE is.Empty() e quindi ho dovuto inizializzare tipopercorso con un valore che sia ANCHE presente nella lista tipiPercorso. Così funge.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Calcola costo del Viaggio',
        style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(children: [
           TextField(
            controller: chilometriController,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey
            ),
            decoration: const InputDecoration(
                hintText: 'Inserisci il numero di Km', //suggerimento visibile a casella vuota
                hintStyle: TextStyle(
                  fontSize: 18
                )
                ),
          ),
          const Spacer(),
          DropdownButton<String>(
            value: tipoPercorso,
            items: tipiPercorso.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey
                ),),
              );
            }).toList(),
            onChanged: (String? nuovoValore) {
              setState(() {
                tipoPercorso = nuovoValore!;
              });
            },
          ),
          const Spacer(flex: 2,),
          ElevatedButton(
            onPressed: () {
              calcolaCosto();
            },
            child: const Text('Calcola Costo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),),
          ),
          const Spacer(flex: 2,),
          Text(messaggio,
          style: TextStyle(
            fontSize: 24,
            color: Colors.grey[800]
          ),),
        ]),
      ),
    );
  }
  void calcolaCosto(){
    double costoLitroCarburante = 1.4;
    double? numeroKilometri = double.tryParse(chilometriController.text);
    double kmTipoPercorso;
    double costo;

    if(tipoPercorso == 'Urbano'){
      kmTipoPercorso = 14;
    }
    else if (tipoPercorso == 'Extraurbano') {
      kmTipoPercorso = 18;
    }
    else {
      kmTipoPercorso = 16;
    }
    if(tipoPercorso == 'Nessun Percorso') {
      kmTipoPercorso = 0;
    }
    costo = (numeroKilometri!  * costoLitroCarburante) / kmTipoPercorso;

    setState(() {
      if( kmTipoPercorso == 0){
        messaggio = 'Nessun percorso selezionato, sceglierne uno per effettuare il calcolo';
      }
      else messaggio = 'Il costo previsto per il tuo viaggio è di €'+costo.toString();
    });
  }
}
// il ! davanti una variabile significa che...NON PUO' ESSERE NULL!

//COSA S'è VISTO IN QUESTO CODICE???
/**
 * Stateful Widget e State
 * Modo in cui flutter gestisce i dati che modificano dell'interfaccia grafica dentro l'app.
 *
 * setState()
 * per aggiornare lo stato di quel widget, occorre richiamare il metodo setState()
 * ed al so interno impostare il nuovo valore della variabile di stato.
 *
 * TextField e TextEditingController
 * il primo permette all'utente di inserire del testo
 * il secondo, leggere e scrivere i valori all'interno del textFiled associato
 *
 * dropDownButton
 * permette di selezionare un valore da una lista di...dropDownMenuItem
 *
 * gestione spazio con Padding e Spacer
 * abbiamo usato la proprietà flex dello spacer per gestire lo spazio all'interno di una Column in modo relativo
 * così che la dimensione dello SPacer dipenda dallo spazio disponibile sullo schermo.
 */