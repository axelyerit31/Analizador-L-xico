List<Map> componentesLexicos = [palabrasReservadas, opAsignacion, opAritmeticos, opCompuestosAsignacion, opComparacion, opBooleanos, simbolosEspeciales];

List<String> nombres = [
  "Palabras Reservadas",
  "Operadores de Asignación",
  "Operadores Aritméticos",
  "Operadores Compuestos Asignación",
  "Operadores de Comparación",
  "Operadores Booleanos",
  "Símbolos Especiales"
];

List<Map> operadores = [opAsignacion, opAritmeticos, opCompuestosAsignacion, opComparacion, opBooleanos, simbolosEspeciales];

Map<String, String> palabrasReservadas = {
  "int" : "Entero",
  "dec" : "Decimal",
  "string" : "Cadena",
  "tup" : "Tupla",
  "list" : "Lista",
  "dic" : "Diccionario",
  "bool" : "Booleano",
  "true" : "Verdadero",
  "false" : "Falso",
  "try" : "Intentar",
  "except" : "Excepcion",
  "xError" : "Error",
  "if" : "Condicional Si",
  "elif": "Condicional Además",
  "else": "Condicional Sino",
  "while": "Bucle Mientras",
  "for": "Bucle Para",
  "break": "Bucle Rompe",
  "return": "Función Retornar",
  "default": "Función Defecto",
  "switch": "Multicondicional En Caso",
  "case": "Caso del En Caso",
  "function": "Define Función",
  "print": "Mostrar",
  "input": "Leer",
  "in": "Dentro de",
  "len": "Largo de un arreglo",
  "toInt": "Convertir a Entero",
  "toDec": "Convertir a Decimal",
  "toStr": "Convertir a Cadena",
  "toList": "Convertir a Lista",
  "toTup": "Convertir a Tupla",
  "max": "Máximo de arreglo",
  "min": "Mínimo de arreglo",
  "sum": "Suma de arreglo",
  "lower": "Convertir a minúscula",
  "upper": "Convertir a mayúscula",
  "cap": "Capitalizar"
};

Map<String, String> opAsignacion = {
  "=": "Asignación"
};

Map<String, String> opAritmeticos = {
  "+": "Suma",
  "-": "Resta",
  "*": "Multiplicación",
  "/": "División",
  "//": "Módulo",
  "^": "Potencia",
  "#": "Raíz Cuadrada"
};

Map<String, String> opCompuestosAsignacion = { 
  "+=": "Suma en Asignación",
  "-=": "Resta en Asignación",
  "*=": "Multiplicación en Asignación",
  "/=": "División en Asignación"
};

Map<String, String> opComparacion = {
  ">": "Mayor que",
  "<": "Menor que",
  ">>": "Mayor o igual que",
  "<<": "Menor o igual que"
};

Map<String, String> opBooleanos = {
  "&": "Conjunción Lógica",
  "°": "Disyunción Lógica",
  "x°": "Disyunción Exclusiva Lógica",
  "->": "Condicional Lógico",
  "<->": "Bicondicional Lógico",
  "!": "Negación Lógica"
};

Map<String, String> simbolosEspeciales = {
  "(": "Abre Paréntesis",
  ")": "Cierra Paréntesis",
  "[": "Abre Corchete",
  "]": "Cierra Corchete",
  "{": "Abre Llave",
  "}": "Cierra Llave",
  ":": "Dos puntos",
  ",": "Coma",
  ";": "Punto y coma",
  '"': "Comillas dobles",
  "'": "Comilla",
  "...": "Comentario Lineal",
  ":::": "Comentario Multilineal"
};