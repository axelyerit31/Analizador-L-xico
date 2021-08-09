import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analizador Léxico"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  //TextField
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[500],
                        width: 2
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    height: 200,
                    width: 200,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20
                    ),
                    child: TextField(
                      minLines: 10,
                      maxLines: 20,
                    ),
                  ),

                  //Separacion
                  SizedBox(
                    width: 10
                  ),

                  //Flecha
                  Icon(
                    Icons.arrow_forward,
                    size: 30
                  ),

                  //Separacion
                  SizedBox(
                    width: 10
                  ),

                  //Area de Token
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[500],
                        width: 2
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20
                    ),
                    height: 200,
                    width: 100,
                    child: Text("Token")
                  ),

                  //Separacion
                  SizedBox(
                    width: 10
                  ),

                  //Area de Descripcion
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[500],
                        width: 2
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20
                    ),
                    height: 200,
                    width: 200,
                    child: Text("Descripcion")
                  )
                ],
              ),

              SizedBox(
                height: 20
              ),
              
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  padding: EdgeInsets.symmetric(
                      horizontal: 15, vertical: 8)
                ),
                onPressed: () {},
                child: Text(
                  "Analizar",
                  style: TextStyle(color: Colors.white)
                )
              )
            ]
          ),
        ),
      )
    );
  }
}