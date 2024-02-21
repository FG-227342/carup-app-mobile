import 'package:carupapp/userDataProvider.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'Model/Servicio.dart';
import 'Model/ServicioDTO.dart';
import 'Services/backendServices.dart';
import 'detalle_servicio.dart';

class MisServicios extends StatefulWidget {
  const MisServicios({super.key});

  @override
  State<StatefulWidget> createState() => _MisServiciosState();
}

class _MisServiciosState extends State<MisServicios> {
  @override
  void initState() {
    super.initState();

    serviciosFuture = getServicios();
  }

  Future<void> refresh() async {
    serviciosFuture = getServicios();
    setState(() {});
  }

  late Future<List<ServicioDTO>> serviciosFuture = getServicios();
  final apiService = ApiServices();

  Future<List<ServicioDTO>> getServicios() async {
    // final assetBundle = DefaultAssetBundle.of(context);
    // instancio el provider para obtener idUsuario
    var myProvider = Provider.of<userDataProvider>(context, listen: false);
    int idUsuario = myProvider.data.idUsrMobile;
    final data = await apiService.obtenerSrvPendientes(idUsuario);
    return data;
  }

  Future<bool> onBackPressed() async {
    Navigator.popAndPushNamed(context, 'home');
    return true;
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mis Servicios"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: RefreshIndicator(
            onRefresh: refresh,
            child: FutureBuilder<List<ServicioDTO>>(
              future: serviciosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Column(
                      children: [
                        Image.asset('assets/imgs/mechanicGif.gif'),
                        const SizedBox(
                          height: 60,
                        ),
                        const Text(
                          "No hay servicios por realizar",
                          style: TextStyle(fontSize: 20, color: Colors.teal),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Relajese, vamos por un café?",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.teal)),
                            Icon(
                              Icons.local_cafe,
                              color: Colors.teal,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(150, 30),
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            refresh();
                          },
                          child: const Text(
                            'RECARGAR',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  }
                  final servicios = snapshot.data!;
                  return buildServicios(servicios);
                } else {
                  return const Text("no hay datos");
                }
              },
            ),
          ),
        ),
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
    switch (servicio.estado) {
      case "A":
        estado = "PENDIENTE";
        colorEstado = Colors.redAccent;
        break; // The switch statement must be told to exit, or it will execute every case.
      case "X":
        estado = "ACEPTADO";
        colorEstado = Colors.lightGreen;
        break;
      default:
        estado = "PENDIENTE";
        colorEstado = Colors.lightGreen;
    }

    return Card(
      elevation: 3.0,
      child: ListTile(
        leading: const Icon(
          Icons.taxi_alert,
          size: 30,
        ),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "TAREA J ${servicio.idTarea}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "[$estado]",
            style: TextStyle(color: colorEstado, fontWeight: FontWeight.bold),
          ),
          Text("contador")
        ]),
        subtitle: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                    "${servicio.matricula} - ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${servicio.marca} ${servicio.modelo} ${servicio.color}")
                ]),
                Text("${servicio.calleOrigen} ${servicio.numPuertaOrigen}"),
                Text("esq. ${servicio.esquinaOrigen}"),
                /*
                Text("hora Asign: ${horaAsignado.toString()}"),
                Text("hora Act: ${horaActual.toString()}"),
                Text("hora Act: ${horaActual.toString()}"),*/
                /*    Text("${timeDifference.inSeconds}")*/
              ],
            )
          ],
        ),
        onTap: () {
          obtenerServicio(servicio.idSrv!);
        },
        /*
        trailing: timeDifference.inSeconds == 0 ? Icon(Icons.more_vert) : Text("${timeDifference.inSeconds}", style: TextStyle(fontSize: 20, color: Colors.green),),
        onTap: () {
          obtenerServicio(servicio.idSrv!);

        },*/
      ),
    );
  }

}
