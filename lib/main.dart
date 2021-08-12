import 'dart:io';

import 'package:analizador_lexico/datos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

import 'analizador.dart';
import 'estilo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Analizador Léxico');
    setWindowMinSize(const Size(1200, 850));
    setWindowMaxSize(Size.infinite);
  }
  debugDefaultTargetPlatformOverride = TargetPlatform.windows;
  runApp(MyApp());
}

TextEditingController codigoController = TextEditingController();
Radius radioGrande = Radius.circular(15);
Radius radioChico = Radius.circular(8);
Radius radioBoton = Radius.circular(6);
double alturaTitulos = 120;
double tamanoCodigo = 14;
int tamanoToken = 4;
int tamanoDescripcion = 6;
double tamanoContador = 15;
double tamanoCajaMostrarToken = 25;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analizador Léxico',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  //Convertimos la lista de tokens en una string
  List<String> formatearTokens(){
    List<String> respuesta = [];

    for (var i = 0; i < tokens.length; i++) {
      respuesta.add("${i+1}. ${tokens[i]["token"]}\n");
    }

    return respuesta;
  }

  //Convertimos el nombre y categoria de cada token en una string
  List<String> formatearDescripcion(){
    List<String> respuesta = [];

    for (var i = 0; i < tokens.length; i++) {
      respuesta.add("${i+1}. ${tokens[i]["nombre"]}\n");
      // ${tokens[i]["categoria"]}:
    }

    return respuesta;
  }

  @override
  Widget build(BuildContext context) {

    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;

    print("Height: $sh, Width: $sw");

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/fondo.png"),
              fit: BoxFit.cover
            )
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 60,
              horizontal: 80
            ),
            child: Row(
              children: [
                izquierda(),
                derecha()
              ]
            )
          )
        ),
      )
    );
  }

  Widget izquierda() {
    return Expanded(
      flex: 15,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff4F37E9),
          borderRadius: BorderRadius.only(
            topLeft: radioGrande,
            bottomLeft: radioGrande
          ),
          image: DecorationImage(
            image: AssetImage("assets/fondoAnalizador.png"),
            fit: BoxFit.cover
          )
        ),
        padding: EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: alturaTitulos,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Analizador Léxico",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w700
                    )
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Escribe el código:",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                    )
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(radioChico)
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10
                ),
                child: TextField(
                  controller: codigoController,
                  minLines: 1,
                  maxLines: 100,
                  style: TextStyle(
                    fontFamily: "SpaceMono",
                    fontSize: tamanoCodigo,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  )
                )
              )
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container()
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      analizadorLexico(codigoController.text);             
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20
                    ),
                    child: Text(
                      "Analizar",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(radioBoton)
                  ),
                  color: colorAzulOscuro
                )
              ],
            )
          ]
        )
      )
    );
  }

  Widget derecha() {
    return Expanded(
      flex: 14,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: radioGrande,
            bottomRight: radioGrande
          )
        ),
        padding: EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: alturaTitulos,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: tamanoToken,
                        child: Text(
                          "Token",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 18,
                            color: colorAzulOscuro,
                            fontWeight: FontWeight.w700
                          )
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: tamanoDescripcion,
                        child: Text(
                          "Descripción",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 18,
                            color: colorAzulOscuro,
                            fontWeight: FontWeight.w700
                          )
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: tamanoToken,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(radioChico),
                            border: Border.all(
                              width: 2,
                              color: Color(0xffe4e4e4),
                            )
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: tamanoDescripcion,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(radioChico),
                            border: Border.all(
                              width: 2,
                              color: Color(0xffe4e4e4),
                            )
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:EdgeInsets.only(bottom: 2),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: tamanoToken,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 15
                              ),
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  for (var token in formatearTokens())
                                    Container(
                                      alignment: Alignment.topLeft,
                                      height: tamanoCajaMostrarToken,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            token,
                                            style: TextStyle(
                                              fontFamily: "SpaceMono",
                                              fontSize: tamanoCodigo,
                                              fontWeight: FontWeight.w700
                                            ),
                                          ),
                                          /* Container(
                                            height: tamanoContador,
                                            width: tamanoContador,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Color(0xff4F37E9),
                                              shape: BoxShape.circle
                                            ),
                                            child: Text(
                                              "2",
                                              style: TextStyle(
                                                fontFamily: "SpaceMono",
                                                fontSize: 11,
                                                color: Colors.white
                                              ),
                                            )
                                          ) */
                                        ],
                                      ),
                                    ),
                                ],
                              )
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: tamanoDescripcion,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 15
                              ),
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  for (var descripcion in formatearDescripcion())
                                    Container(
                                      alignment: Alignment.topLeft,
                                      height: tamanoCajaMostrarToken,
                                      child: Text(
                                        descripcion,
                                        style: TextStyle(
                                          fontFamily: "SpaceMono",
                                          fontSize: tamanoCodigo,
                                        ),
                                      ),
                                    ),
                                ],
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container()
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      tokens.clear();
                      tokensReg.clear();
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20
                    ),
                    child: Text(
                      "Limpiar",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 14,
                        color: colorAzulOscuro,
                        fontWeight: FontWeight.w600,
                      )
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: colorAzulOscuro,
                    ),
                    borderRadius: BorderRadius.all(radioBoton)
                  ),
                  color: Colors.white
                )
              ],
            )
          ]
        )
      )
    );
  }
}