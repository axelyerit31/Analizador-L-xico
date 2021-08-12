import 'datos.dart';

//Declarando datos necesarios
List<String> digito = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
List<String> letras = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'ñ', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'Ñ', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
List<String> subguion = ["_"];


List<Map> tokens = [];
List<String> tokensReg = [];
List<String> comillas = [];

bool dentroDe(caracter, lista){

  print("Entramos a funcion dentroDe");

  bool respuesta = false;

  for (var i = 0; i < lista.length; i++) {

    if(lista is List){
      if(caracter == lista[i]){
        respuesta = true;
      }
    }else if(lista is String){
      if(lista.substring(i, lista.length) == caracter){
        if(lista == caracter){
          respuesta = true;
          print("${lista.substring(i, lista.length)} contiene a $caracter????");
        }
      }
    }

    
  }

  return respuesta;
}

bool perteneceLenguaje(String componente){
  print("Entramos a comprobar si pertenece lenguaje");

  bool respuesta = false;

  for (var lista in componentesLexicos) {
    for (var palabra in lista.keys) {
      print("Comprobamos con el lexema $palabra");
      if(dentroDe(palabra, componente) || palabra == componente){
        return true;
      }
    }
  }
  print(respuesta);
  return respuesta;
}

void anadirToken({String token, String nombre, String categoria}){

  //Comprobamos que token no este en el registro de tokens
  if(!dentroDe(token, tokensReg)){

    //Comprobamos si hay nombre y categoria, si no la hay los busca
    if(nombre == null && categoria == null){
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
    }else{
      tokensReg.add(token);
      tokens.add(
        {
          "token": token,
          "nombre": nombre,
          "categoria": categoria
        }
      );
      print("Pertenece al lenguaje: $token");
    }

  }
}

//Analizador Lexico
void analizadorLexico(String codigo) {

  //Borrando los espacio y separando las lineas de codigo
  codigo = codigo.replaceAll(" ", "");
  List<String> lineasCodigo = codigo.split("\n");

  //Cadena donde se almacenara lo recorrido hasta que coincida con un componente del lenguaje
  String componente = "";

  for (var linea in lineasCodigo) {
    for (var i = 0; i < linea.length; i++) {

      print("\nITERACION NUMERO: $i");
      print(linea[i]);
      componente += linea[i];

      try{
        print("Entramos al try");
        //Condicion cuando es un token del lenguaje
        if(perteneceLenguaje(componente)){

          print("Comprobamos si pertenece al lenguaje");
          //Condicion para encontrar cadena
          if(dentroDe(componente, ['"', "'"])){
            comillas.add(componente);
            anadirToken(token: componente);

            String token, nombre, categoria = "";
            
            if(comillas.length.isOdd){
              for (var j = 0; j < linea.length - i; j++) {

                print("Iteracion j: $j, i: $i");

                if(i+j != linea.length-1){
                  print("Dentro del limite del indice");
                  if(dentroDe(linea[j+i+1], ['"', "'"])){
                    i+=1;
                    if(linea[i-1] == linea[j+i]){
                      token = linea.substring(i, i+j);
                      nombre = "Cadena";
                      categoria = "Constante Cadena";
                    }else{
                      token = linea.substring(i, i+j);
                      nombre = "Error (Comillas)";
                      categoria = "Error";
                    }
                    i = i + j - 1;
                    anadirToken(
                      token: token,
                      nombre: nombre,
                      categoria: categoria
                    );
                    break;
                  }
                }
                
              }
            }
            componente = "";
          }else{
            //Añadimos componente a la lista de tokens, y lo limpiamos
            anadirToken(token: componente);
            componente = "";
          }
        }
        //Condicion cuando es identificador
        else if (!dentroDe(componente[0], digito)){

          print("Comprobamos si es un identificador");
          //Condicion para ver si el sigueinte caracter es uno no de identificador
          if(i != linea.length-1){
            if(!dentroDe(linea[i+1], letras+digito+subguion) && dentroDe(linea[i], letras+digito+subguion)){
              anadirToken(
                token: componente.toString(),
                nombre: "Identificador",
                categoria: "Identificadores"
              );

              componente = "";
            }
          }else{
            tokens.add(
              {
                "token": "Error",
                "nombre": "Error",
                "categoria": "Error"
              }
            );
            componente = "";
          }
        }
        //Condicion para cuando es numero
        else if(dentroDe(componente, digito)){

          //Error al comprobar que el siguiente no sea numero
          //Agregar que al encontrar una coma considere un decimal

          print("Comprobamos si es un numero");
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
      }on RangeError {
        print("Error de rango en el analizador");
        break;
      }
    }
    componente = "";
  }
}
