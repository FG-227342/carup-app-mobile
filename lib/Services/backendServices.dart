import 'dart:convert';
import 'dart:io';
import 'package:carupapp/Model/ServicioDTO.dart';
import 'package:carupapp/Model/UserData.dart';
import 'package:http/http.dart' as http;
import 'package:carupapp/globals.dart' as global;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../Model/Servicio.dart';

class ApiServices {
  final apiString = global.urlBackend_dev;
  static String token = "";


  Future<UserData?> getLoginData(String user,String psw) async {
    var url = '$apiString/api/authenticate';
    String playerId = OneSignal.User.pushSubscription.id!;
    var body = jsonEncode({"username": user, "password": psw, "playerId": "$playerId"});

    try {
      final response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);
      print(response.body);
      print(response.statusCode);
      UserData res = UserData();
      if (response.statusCode == 200) {
        res.statusCode = 200;
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        res.nombre = data['userName'];
        res.token = data['jwt'];
        res.idUsrMobile = data['idUsrMobile'];
        token = data['jwt'];
        return res;
      }else if(response.statusCode == 500){
        res.statusCode = 500;
        return res;
      }else {
        print('Error en el login');
        return null;
      }
    }
    catch (e) {
      print('Error Occurred' + e.toString());
    }
  }

  void rechazarServicio(int idSrv){
    var url = '${apiString}/api/servicios/${idSrv}';
    var body = jsonEncode({"estado": "R"});
    try {
      http.patch(Uri.parse(url),
          headers: {HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: 'Bearer ${ApiServices.token}'}, body: body);
    } catch(e){}
  }

  void aceptarServicio(int idSrv){
    var url = '${apiString}/api/servicios/${idSrv}';
    var body = jsonEncode({"estado": "X"});
    try {
      http.patch(Uri.parse(url),
          headers: {HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: 'Bearer ${ApiServices.token}'}, body: body);
    } catch(e){}
  }

  void finalizarServicio(int idSrv){
    var url = '${apiString}/api/servicios/${idSrv}';
    var body = jsonEncode({"estado": "F"});
    try {
      http.patch(Uri.parse(url),
          headers: {HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: 'Bearer ${ApiServices.token}'}, body: body);
    } catch(e){}
  }

  Future<List<ServicioDTO>> obtenerSrvPendientes(int idUsuarioMobile) async {

    var url = '${apiString}/api/servicios/usuarioMobile/${idUsuarioMobile}';

    final List<ServicioDTO> res = [];
    try {
      final response = await http.get(Uri.parse(url),

          headers: {HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: 'Bearer ${ApiServices.token}'});
      if (response.statusCode == 200) {
        String x = Utf8Decoder().convert(response.bodyBytes);
        final item = json.decode(x);
        for(var i in item){

          ServicioDTO newSrv = ServicioDTO.fromJson(i);
          res.add(newSrv);
        }
        print("Hola desde login_service: $res");
      }
    } catch (e) {
      print('Error Occurred' + e.toString());
    }
    return res;
  }

  Future<List<ServicioDTO>> obtenerTodos(int idUsuarioMobile) async {

    var url = '${apiString}/api/servicios/usuarioMobile/todos/${idUsuarioMobile}';

    final List<ServicioDTO> res = [];
    try {
      final response = await http.get(Uri.parse(url),

          headers: {HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: 'Bearer ${ApiServices.token}'});
      if (response.statusCode == 200) {
        String x = Utf8Decoder().convert(response.bodyBytes);
        final item = json.decode(x);
        for(var i in item){

          ServicioDTO newSrv = ServicioDTO.fromJson(i);
          res.add(newSrv);
        }
        print("Hola desde login_service: $res");
      }
    } catch (e) {
      print('Error Occurred' + e.toString());
    }
    return res;
  }

  Future<Servicio> obtenerServicio(int idServicio) async{
    var url = '${apiString}/api/servicios/servicioDTO/${idServicio}';
    Servicio res = new Servicio();

    try {
      final response = await http.get(Uri.parse(url),

          headers: {HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: 'Bearer ${ApiServices.token}'});
      if (response.statusCode == 200) {
        String body = Utf8Decoder().convert(response.bodyBytes);
        res =  Servicio.fromJson(json.decode(body));
      }
      }catch(e){}
    return res;
  }

}
