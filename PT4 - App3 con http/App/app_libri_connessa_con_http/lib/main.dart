import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'libro.dart';
import 'libroScreen.dart';

//https://www.googleapis.com/books/v1/volumes/?q=oceano%20mare

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const LibriScreen(),
    );
  }
}

class LibriScreen extends StatefulWidget {
  const LibriScreen({Key? key}) : super(key: key);

  @override
  State<LibriScreen> createState() => _LibriScreenState();
}

class _LibriScreenState extends State<LibriScreen> {
  Icon icona = Icon(Icons.search);
  Widget widgetRicerca = Text('Libri');

  String risultato = '';
  List<Libro> libri = [];
  @override
  void initState() {
    cercaLibri('Oceano Mare');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: widgetRicerca,
        actions: [
          IconButton(
              icon: icona,
              onPressed: () {
                setState(() {
                  if(this.icona.icon == Icons.search) {
                    this.icona = Icon(Icons.cancel);
                    this.widgetRicerca = TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted:  (testoRicerca) => cercaLibri(testoRicerca),//Il metodo che inseriamo qui, verrà eseguito ogni volta che l'utente preme il search su tastierino
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      )
                    );
                  }
                  else {
                    setState(() {
                      this.icona = Icon(Icons.search);
                      this.widgetRicerca = Text('Libri');
                    });
                  }
                });
              },
          )
        ],
      ),
      body: ListView.builder(
          itemCount: libri.length,//lunghezza della List libri

          //interfaccia grafica del contenuto del listview. La funzione vuole come parametri un context e la posizione
          //all'interno della lista. E' come un ciclo, da 0 a itemCount!
          itemBuilder: ((BuildContext context, int posizione) {
               return Card(
                 child:ListTile(
                   onTap: (){
                     MaterialPageRoute route = MaterialPageRoute(
                         builder: (_) => LibroScreen(libri[posizione]));
                     Navigator.push(context, route);//E' lui che aggiunge la NUOVA pagina!
                   },
                   //leading inserisce a sinistra del Text, una immagine!
                   leading: Image.network(libri[posizione].immagineCopertina),
                   title: Text(libri[posizione].titolo),
                   subtitle: Text(libri[posizione].autori),
                 ),
               );
            // return Text(libri[posizione].titolo);
    })),
    );
  }

  Future cercaLibri(String ricerca) async {
    //URI: Universal resources Identify
    final String dominio = 'www.googleapis.com';
    final String percorso = '/books/v1/volumes';
    Map<String, dynamic> parametri = {'q': ricerca};
    final Uri url = Uri.https(dominio, percorso, parametri);
    try {
      http.get(url).then((res) {
        //questa è una chiamata GET che restituisce del testo!

        final resJson = json.decode(res.body);
        //dichiaro una variabile che prende il contenuto del risultato della richiesta del metodo get
        //la decodifica utilizzando il metodo json.decode, che prende una Stringa (il res.body) e la trasforma in un oggetto json
        //questo oggetto json può essere navigato e infatti navighiamo all'interno della chiave items che contiene i libri trovati....
        final libriMap = resJson['items']; //....con questa riga dicodice
        //questo mette il contenuto della chiave 'item' nella variabile libriMap

        libri = libriMap.map<Libro>((mappa) => Libro.fromMap(mappa)).toList();
        //Qui chiamiamo il metodo .map che permette di scorrere ciascun elemento all'interno di un insieme, per ciascuno di esso prendiamo l'oggetto
        // che qui chiamiamo mappa e per ciascuna mappa restituiamo un oggetto di tipo libro generato dal costruttore fromMap
        //alla fine trasformamiamo tutto in list col metodo .list. quindi alla fineeee c'hai un list di libro

        setState(() {
          risultato = res.body;
          libri = libri;
        });
      });
    } catch (errore){
      setState(() {
        risultato = 'NESSUN RISULTATO ALLA chiamata GET';
      });
    }


    setState(() {
        risultato = 'Richiesta in corso';
    });
  }
}
/**
 * LISTVIEW E' UN OGGETTO SCROLLING, UN PO' SIMILE A SINGLECHILDSCROLLVIEW. Ma la differenza è che Listview...
 * può contenere DIVERSI elementi e NON UNO SOLO. Listview permette lo scorrimento in orizzontalee in verticale(predefinito).
 * Listview ha diversi COSTRUTTORI, in questo caso il più indicato era Listview.builder che richiede di sapere in ANTICIPO il numero di elementi in lista
 * e richiede un ItemBuilder che visualizza ciascun elemento
 *
 * - Card è un material widget con angoli leggermente arrotondati, un ombra che lo alza rispetto al suo background.
 * si usa per raggruppare informazioni correlate tra loro, come un libro, un film, una ricetta...
 * - ListTile altro material widget che può contenere da 2 a 3 righe di testo più immagini all'inizio e alla fine.
 *
 * CONCETTO PROGRAMMAZIONE ASINCRONA CON FUTURE ED IL SUO METODO then
 *
 * INCLUDERE PACCHETTI DENTRO L'APP, COME IL PACCHETTO HTTP -> COLLEGAMENTO AL WEBAPI GOOGLEBOOKS
 *
 * IL RISULTATO IN FORMATO JSON -> TRASFORMATO IN OGGETTO CON jsonDecode e map
 *
 * MOSTRARE I RISULTATI CON LISTVIEW, WIDGET CHE SCORRE. ALL'INTERNO ABBIAMO USATO CARD E listTile
 * e prende uno degli ellementi della lista -> seconda schermata con NAVIGATOR, passando i dati al
 * costruttore della seconda schermata.
 *
 *
 */


