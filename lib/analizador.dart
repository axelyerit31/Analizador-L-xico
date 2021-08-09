import 'datos.dart';

//Declarando datos necesarios
List<String> digito = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
List<String> letras = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'ñ', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'Ñ', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

List<Map> tokens = [];

bool dentroDe(letra, lista){

  bool respuesta = false;

  for (var i = 0; i < lista.length; i++) {
    if(letra == lista[i]){
      respuesta = true;
    }
  }

  return respuesta;
}

bool esPalabraReservada(String componente){

  bool respuesta = false;

  for (var palabra in palabrasReservadas.keys) {
    if(componente == palabra){
      return true;
    }
  }

  return respuesta;
}

bool esSimbolo(String componente){

  bool respuesta = false;

  for (var operador in operadores) {
    for (var simbolo in operador.keys) {
      if(componente == simbolo){
        return true;
      }
    }
  }

  return respuesta;
}

Map<String, String> clasificarToken(String token){

  Map<String, String> respuesta = {
    "token": token,
    "nombre": "",
    "categoria": "",
  };

  for (var lista in componentesLexicos) {
    for (var componente in lista.keys) {
      if(componente == token){
        respuesta["nombre"] = lista[componente];
      }
    }
  }
}

void analizadorLexico(String codigo) {

  //Separando las lineas de codigo
  List<String> lineasCodigo = codigo.split("\n");

  //Cadena donde se almacenara lo recorrido hasta que coincida con un componente del lenguaje
  String componente = "";

  for (var linea in lineasCodigo) {
    for (var i = 0; i < linea.length; i++) {
      
      componente += linea[i];

      if(esPalabraReservada(componente) || esSimbolo(componente)){

        //Añadimos componente a la lista de tokens, y lo limpiamos
        tokens.add(clasificarToken(componente));
        componente = "";
        print(componente);

      }else{

      }
    }
  }
}