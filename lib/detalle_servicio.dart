import 'package:carup/MisServicios.dart';
import 'package:carup/Services/backendServices.dart';
import 'package:carup/mapa_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Model/Servicio.dart';

class DetalleServicio extends StatefulWidget {
  final Servicio servicio;

  const DetalleServicio(this.servicio, {super.key});

  @override
  State<DetalleServicio> createState() => _detalleServicio();


}


class _detalleServicio extends State<DetalleServicio> {


  @override
  Widget build(BuildContext context) {
    Future<bool> onBackPressed() async {
      Navigator.popAndPushNamed(context, 'MisServicios');
      return true;
    }

    print(widget.servicio.estado);
    String estado = "";
    switch(widget.servicio.estado) {
      case "A":
        estado = "PENDIENTE";
        break;
      case "C":
        estado = "CANCELADO";
        break;
      case "F":
        estado = "FINALIZADO";
        break;
      case "T":
        estado = "TERMINADO";
        break;
      case "X":
        estado = "ASIGNADO";
        break;
      default:
        estado = "PENDIENTE";
    }

    return WillPopScope (
        onWillPop: onBackPressed,
        child: Scaffold(
      appBar: AppBar(
        title:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Text("Tarea N° " + widget.servicio.idTarea.toString()),
              Text("[" + estado + "]", style: TextStyle(fontSize:18),)
            ]
            ),
       actions: [

       ],
      ),
      body: SingleChildScrollView(
        child: _bodyServicio(),
      ),
    ));
  }

  Widget _bodyServicio() {
    ApiServices backend = ApiServices();

    String? latitud = widget.servicio.latitud;
    String? longitud = widget.servicio.longitud;
    double? latitudDouble = latitud! != "" ? double.parse(latitud) : null;
    double? longitudDouble = longitud! != "" ? double.parse(longitud) : null;
    print("LATLONG");
    print(latitud);
    print(longitud);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("#id " + widget.servicio.idSrv.toString()),
            Text("Fecha: " + widget.servicio.fecha.toString()),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 50),
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Color.fromRGBO(50, 50, 50, 1),
              ],
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  //Text(context.watch<userDataProvider>().data.token),
                  Text(
                    widget.servicio.matricula!,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    widget.servicio.marca! + " " +
                        widget.servicio.modelo! + " " +
                        widget.servicio.color!,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: 85,
                          width: 85,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)
                              //more than 50% of width makes circle
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Container(
                          height: 80,
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/imgs/car.png'),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(FontAwesomeIcons.solidUser,
                          size: 18, color: Colors.black54),
                    ),
                    Text(
                      "SOLICITANTE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black54),
                    ),
                  ],
                ),
                Text(
                  widget.servicio.nombreCliente.toString(),
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    Text(
                      "095238984",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.phone),
                      onPressed: () {
                        launchUrl(Uri.parse('tel://095238984'));
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.whatsapp,
                        size: 25,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        launchUrl(Uri.parse('https://wa.me/598095238984?text=Buenas tardes! Aquí el auxilio mecánico, '));

                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        Divider(),
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
        SizedBox(
          height: 10,
        ),
        mapa_service(latitudDouble, longitudDouble),
        SizedBox(
          height: 10,
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
        Divider(),
        widget.servicio.ciudadDestino != null
            ? Padding(
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
                              child: Icon(FontAwesomeIcons.truckMoving,
                                  size: 18, color: Colors.black54),
                            ),
                            Text(
                              "TRASLADO",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        Text(
                          "[" +
                              (widget.servicio.ciudadDestino ?? '') +
                              "-" +
                              (widget.servicio.locDestino ?? '') +
                              "]",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.servicio.calleDestino ?? '',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                      ],
                    )
                  ],
                ),
              )
            : Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey, width: 1.5, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'COSTO: \$ 2086',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'MOTIVO: Sin aux restantes',
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
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
                        child: Icon(FontAwesomeIcons.clipboardCheck,
                            size: 18, color: Colors.black54),
                      ),
                      Text(
                        "OBSERVACIONES",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.servicio.observaciones ?? '',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )
            ],
          ),
        ),
        Divider(),
        widget.servicio.estado == "A" ?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 30),
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
               backend.rechazarServicio(widget.servicio.idSrv!);
              // Navigator.of(context).pop();
               Navigator.popAndPushNamed(context, 'MisServicios');
              },
              child: const Text('RECHAZAR',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 30),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                backend.aceptarServicio(widget.servicio.idSrv!);
                Navigator.popAndPushNamed(context, 'MisServicios');
              },
              child: const Text(
                'ACEPTAR',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ],
        ) : Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 30),
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {

              },
              child: const Text('LLEGUÉ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 30),
                backgroundColor: const Color.fromRGBO(194, 15, 47, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                backend.finalizarServicio(widget.servicio.idSrv!);
                Navigator.popAndPushNamed(context, 'home');
              },
              child: const Text(
                'FINALIZAR',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
