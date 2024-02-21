import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:carupapp/MisServicios.dart';
import 'package:carupapp/TodosLosServicios.dart';
import 'package:carupapp/home_page.dart';
import 'package:carupapp/Login.dart';
import 'package:carupapp/serviceRefreshProvider.dart';
import 'package:carupapp/userDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'Model/Servicio.dart';
import 'detalle_servicio.dart';
import 'globals.dart' as globals;
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  OneSignal.Debug.setLogLevel(OSLogLevel.none);
  OneSignal.initialize("f727b6cc-4f46-4d91-ae78-1c7e86e27e5f");
  OneSignal.Notifications.requestPermission(true);
  OneSignal.Notifications.clearAll();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<userDataProvider>(create: (_) => userDataProvider()),
        ChangeNotifierProvider<ServiceRefreshProvider>(create: (_) => ServiceRefreshProvider()),
      ],
      child: MyApp(),
    ),
  );
}

Future<String> obtenerServicio(context, idServicio) async {
  //pego a la api
  var myProvider = Provider.of<userDataProvider>(context, listen: false);
  var token = myProvider.data.token;
  final String _url = globals.urlBackend_dev;

  final response =
  await http.get(Uri.parse(_url + "/api/servicios/servicioDTO/" + idServicio), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${token}'
  });
  if (response.statusCode == 200) {
    // devuelvo el body decodificado, si no muestra error en algunos caracteres
    return Utf8Decoder().convert(response.bodyBytes);
  }
  return "";
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  MyApp({super.key});

  @override
  void initState() {}


  @override
  Widget build(BuildContext context) {

    OneSignal.Notifications.addClickListener((event) async {
      //print("se HIZO CLICK EN UNA NOTI");
      print(event.notification.additionalData?.entries.first.value.toString());
      String? idServicioBuscado = event.notification.additionalData?.entries.first.value.toString();
      var servicio = await obtenerServicio(context, idServicioBuscado);
      print("servicio de Obtener servicio:");
      print(servicio.toString());
      Servicio s = Servicio.fromJson(json.decode(servicio));

      Navigator.push(navigatorKey.currentState!.context,
          MaterialPageRoute(builder: (context) => DetalleServicio(s)));
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {

      //print("LLEGOOO NOTI");
      Provider.of<ServiceRefreshProvider>(context, listen: false).actualizar();

      //   event.notification.display();
    });


    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'CARUP S.A',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(194, 15, 47, 1),
        useMaterial3: true,
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white), color: const Color.fromRGBO(194, 15, 47, 1), titleTextStyle: TextStyle(color: Colors.white, fontSize: 25) //<-- SEE HERE
        ),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => Login(),
        'home': (BuildContext context) => home_page(),
        'MisServicios': (BuildContext context) => MisServicios(),
        'TodosServicios': (BuildContext context) => TodosLosServicios()
      },
    );
  }
}
