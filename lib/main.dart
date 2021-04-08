import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sensors/sensors.dart';
import 'models/data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.red,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            onPrimary: Colors.black,
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      title: 'Eventos Giroscopio',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Eventos Giroscopio'),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Uri _url =
      Uri.parse('https://apiproductorlaura.azurewebsites.net/api/Data');
  String giroscopio = 'Esperando...';

  Future<String> _sendData(String evento) async {
    Data data = Data(
      eventDate: DateTime.now(),
      event: evento,
      nameDevice: "Samsung A20 - Giroscopio",
    );
    var response = await http.post(
      _url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: dataToJson(data),
    );
    print("${response.statusCode}: ${response.body}");
    return response.body;
  }

  @override
  void initState() {
    super.initState();
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        giroscopio = event.toString();
      });
      // print(event.toString());
      _sendData(event.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(giroscopio),
      ),
    );
  }
}
