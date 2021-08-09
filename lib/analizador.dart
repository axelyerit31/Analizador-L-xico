import 'datos.dart';

List<String> letras = ["a", "b"];

String analizadorLexico(String codigo) {

  String respuesta = "";

  //Separando las lineas de codigo
  List<String> lineasCodigo = codigo.split("\n");

  for (var linea in lineasCodigo) {
    respuesta += "- $linea\n";
  }

  return respuesta;
}