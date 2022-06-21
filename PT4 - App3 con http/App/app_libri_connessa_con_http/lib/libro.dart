class Libro {
  String id = '';
  String titolo = '';
  String autori = '';
  String descrizione = '';
  String editore = '';
  String immagineCopertina = '';

  /// ESISTONO 2 TIPOLOGIE DI COSTRUTTORI, IN FLUTTER
  /// UNNAMED E NAMED CONSTRUCTOR
  /// - UNNAMED: SOLO IL "NOME" DELLA CLASSE SENZA ALTRI FRONZOLI, COME IN JAVA.
  /// - NAMED: NOME CLASSE + FRONZOLO
  Libro(this.id, this.titolo, this.autori, this.descrizione, this.editore,
      this.immagineCopertina);

  /// QUESTO QUI SOTTO INVECE, E' UN COSTRUTTORE 'NAMED' CHE CREA IL LIBRO A PARTIRE DAL FILE JASON
  /// quando si recupera un json da un servizio web(web API), dart permette di trasformarlo direttamente
  /// in un oggetto di tipo 'map', a sua volta facilmente trasformabile in un 'oggetto'
//PERCHE' STA MAPPA String/dynamic?! perchè le chiavi son di tipo String, i valori posso essere di qualunque tipo.
  Libro.fromMap(Map<String, dynamic> mappa) {
    this.id = mappa['id'];
    //contiene il valore dell'oggetto map, si piglia la chiave che si identifica con 'id'

    this.titolo = mappa['volumeInfo']['title'];
    //il nostro amato json contiene un campo che si chiama volumeInfo con dentro un oggetto titolo ed un autore, ci pigliamo solo il title.

    this.autori = (mappa['volumeInfo']['authors'] == null)
        ? ''
        : mappa['volumInfo']['authors'].toString();
    this.descrizione = (mappa['volumeInfo']['description'] == null)
    ? ''
    : mappa['volumeInfo']['description'].toString();
    this.editore = (mappa['volumeInfo']['publisher'] == null)
        ? ''
        : mappa['volumeInfo']['publisher'].toString();
    try {
    this.immagineCopertina = (mappa['volumeInfo']['imageLinks']['smallThumbnail'] == null)
        ? ''
        : mappa['volumeInfo']['imageLinks']['smallThumbnail'].toString();
    }
    catch (errore) {
      this.immagineCopertina = '';
    }
  }
}
