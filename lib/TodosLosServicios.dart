import 'dart:async';

import 'package:carup/Model/ServicioDTO.dart';
import 'package:carup/detalle_servicio.dart';
import 'package:carup/userDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'Model/Servicio.dart';
import 'Services/backendServices.dart';

class TodosLosServicios extends StatefulWidget {
  const TodosLosServicios({super.key});


  @override
  State<StatefulWidget> createState() => _MisServiciosTState();
}

class _MisServiciosTState extends State<TodosLosServicios> {



  @override
  void initState() {
    super.initState();
    serviciosFuture = getServicios();
  }



  Future<void> refresh() async{
serviciosFuture =  getServicios();
    setState(() {
    });
  }

  late Future<List<ServicioDTO>> serviciosFuture = getServicios();
  final apiService = ApiServices();

  Future<List<ServicioDTO>> getServicios() async {
    // final assetBundle = DefaultAssetBundle.of(context);
    // instancio el provider para obtener idUsuario
    var myProvider = Provider.of<userDataProvider>(context, listen: false);
    int idUsuario = myProvider.data.idUsrMobile;
    final data = await apiService.obtenerTodos(idUsuario);
    return data;
  }

  Future<bool> onBackPressed() async {
    Navigator.popAndPushNamed(context, 'home');
    return true;
  }

  @override
  Widget build(BuildContext context) =>
   WillPopScope (
  onWillPop: onBackPressed,
  child:Scaffold(


        appBar: AppBar(
          title: Text("Mis Servicios"),
          centerTitle: true,
        ),
        body: Center(
          child:
          RefreshIndicator(
            onRefresh:refresh,
            child:
            FutureBuilder<List<ServicioDTO>>(
            future: serviciosFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (snapshot.hasData) {
                final servicios = snapshot.data!;
                return  buildServicios(servicios);
              } else {
                return const Text("no hay datos");
              }
            },
          ),
        ),),
      ));

  Widget buildServicios(List<ServicioDTO> servicios) => ListView.builder(
      itemCount: servicios.length,
      itemBuilder: (context, index) {
        final servicio = servicios[index];

        return CardState(servicio);
      });
}
class CardState extends StatefulWidget {
  final ServicioDTO servicio;

  const CardState(ServicioDTO this.servicio, {super.key});



  @override
  State<StatefulWidget> createState() => _cardState();
}

class _cardState extends State<CardState> {
  late ServicioDTO servicio;

  @override
  void initState() {
    super.initState();

    servicio = widget.servicio;

  }

  Future<void> obtenerServicio(int idSrv) async {
    final apiService = ApiServices();

    Servicio srv = await apiService.obtenerServicio(idSrv);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetalleServicio(srv),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    String estado = "";
    Color? colorEstado;
    switch(servicio.estado) {
      case "A":
        estado = "PENDIENTE";
        colorEstado = Colors.redAccent;
        break;
      case "":
        estado = "ACEPTADO";
        colorEstado = Colors.redAccent;
        break;
      case "C":
        estado = "CANCELADO";
        colorEstado = Colors.black12;
        break;
      case "F":
        estado = "FINALIZADO";
        colorEstado = Colors.blueAccent;
        break;
      case "T":
        estado = "TERMINADO";
        colorEstado = Colors.black;
        break;
      case "X":
        estado = "ASIGNADO";
        colorEstado = Colors.lightGreen;
        break;
      default:
        estado = "PENDIENTE";
        colorEstado = Colors.lightGreen;
    }



    return Card(
      elevation: 3.0,
      child: ListTile(
        leading: Icon(
          Icons.taxi_alert,
          size: 30,
        ),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TAREA J ${servicio.idTarea}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("[${estado}]", style: TextStyle(color: colorEstado, fontWeight: FontWeight.bold),),
            ]),
        subtitle: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                    "${servicio.matricula} - ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      "${servicio.marca} ${servicio.modelo} ${servicio.color}")
                ]),
                Text("${servicio.calleOrigen} ${servicio.numPuertaOrigen}"),
                Text("esq. ${servicio.esquinaOrigen}"),
              ],
            )
          ],
        ),
        onTap: () {
          //obtenerServicio(servicio.idSrv!);
          _resumen();
        },
      ),
    );
  }

  void _resumen() async{
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(FontAwesomeIcons.mapPin,
                                    size: 18, color: Colors.black54),
                              ),
                              Text(
                                "UBICACIÓN",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                          Text(
                            "[" +
                                widget.servicio.ciudadOrigen! +
                                "-" +
                                widget.servicio.locOrigen! +
                                "]",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.servicio.calleOrigen!,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "esq. " + widget.servicio.esquinaOrigen!,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(FontAwesomeIcons.carBurst,
                                    size: 18, color: Colors.black54),
                              ),
                              Text(
                                "FALLA",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                          Text(
                            widget.servicio.falla ?? '',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                ElevatedButton(
                  child: const Text('CERRAR'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}

