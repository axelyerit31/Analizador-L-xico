import 'datos.dart';

//Declarando datos necesarios
List<String> digito = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
List<String> letras = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'ñ', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'Ñ', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
List<String> subguion = ["_"];


List<Map> tokens = [];

bool dentroDe(caracter, lista){

  bool respuesta = false;

  for (var i = 0; i < lista.length; i++) {
    if(caracter == lista[i]){
      respuesta = true;
    }
  }

  return respuesta;
}

bool contiene(String contenedor, String contenido){

  bool respuesta = false;

  for (var i = 0; i < contenedor.length; i++) {
    if(contenedor.substring(i, contenedor.length) == contenido){
      if(contenedor == contenido){
        respuesta = true;
        print("${contenedor.substring(i, contenedor.length)} contiene a $contenido????");
      }
    }
  }

  return respuesta;
}

bool perteneceLenguaje(String componente){

  bool respuesta = false;

  for (var lista in componentesLexicos) {
    for (var palabra in lista.keys) {
      if(contiene(componente,palabra) || palabra == componente){
        return true;
      }
    }
  }

  return respuesta;
}

void anadirToken({String token, String nombre, String categoria}){
  bool existe = false;

  for (var t in tokens) {
    if(token == t["token"]){
      existe = true;
      print("Repetido $token");
    }
  }

  if(!existe){
    tokens.add(
      {
        "token": token,
        "nombre": nombre,
        "categoria": categoria
      }
    );
  }
}

void clasificarToken(String token){
  for (var i = 0; i < componentesLexicos.length; i++) {
    for (var componente in componentesLexicos[i].keys) {
      if(componente == token){
        anadirToken(
          token: token,
          nombre: componentesLexicos[i][componente],
          categoria: nombres[i]
        );
      }
    }
  }
}

//Analizador Lexico
void analizadorLexico(String codigo) {

  //Separando las lineas de codigo
  codigo = codigo.replaceAll(" ", "");
  List<String> lineasCodigo = codigo.split("\n");

  //Cadena donde se almacenara lo recorrido hasta que coincida con un componente del lenguaje
  String componente = "";

  for (var linea in lineasCodigo) {
    for (var i = 0; i < linea.length; i++) {
      
      componente += linea[i];
      print("Agregado: $componente");

      try{
        //Condicion cuando es un token del lenguaje
        if(perteneceLenguaje(componente)){

          //Añadimos componente a la lista de tokens, y lo limpiamos
          clasificarToken(componente);
          print("Pertenece al lenguaje: $componente");
          componente = "";
        }
        //Condicion cuando es identificador o cadena
        else if (!dentroDe(componente[0], digito)){

          //Condicion para ver si el sigueinte caracter es uno no de identificador
          if(!dentroDe(linea[i+1], letras+digito+subguion) && dentroDe(linea[i], letras+digito+subguion)){

            String nombre, categoria = "";

            //Condicion para encontrar cadena
            if( dentroDe(linea[i-componente.length], ['"', "'"]) && dentroDe(linea[i+1], ['"', "'"])){

              //Viendo si empieza y termina con la misma comilla
              if(linea[i-componente.length] == linea[i+1]){
                nombre = "Cadena";
                categoria = "Constante Cadena";
              }
            }else{
              nombre = "Identificador";
              categoria = "Identificador";
            }

            anadirToken(
              token: componente.toString(),
              nombre: nombre,
              categoria: categoria
            );

            componente = "";
          }
        }
        //Condicion para cuando es numero
        else if(dentroDe(componente, digito)){
          if(!dentroDe(linea[i+1], digito)){
            tokens.add(
              {
                "token": componente.toString(),
                "nombre": "Entero",
                "categoria": "Constante Numérica"
              }
            );
            componente = "";
          }
        }
        //Condicion para cuando no pertenece
        else{
          tokens.add(
            {
              "token": "El texto no coincide con nuestro lenguaje",
              "nombre": "Vacio",
              "categoria": "Vacio"
            }
          );
          componente = "";
        }
      }on RangeError {
        break;
      }
    }
    componente = "";
  }
}