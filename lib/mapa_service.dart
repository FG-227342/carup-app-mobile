import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class mapa_service extends StatelessWidget {


   double? latitud;
   double? longitud;

  mapa_service(this.latitud, this.longitud, {super.key});


  @override
  Widget build(BuildContext context) {

    double lt;
    double lg;
    if(latitud == null || longitud == null){
      lt = -34.889052994490186;
      lg = -56.165979813299046;
    } else{
      lg = longitud!;
      lt = latitud!;
    }

    return Container(
      height: 300,
      child: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(lt, lg),
              zoom: 14,
              interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              maxZoom: 18,
              minZoom: 12,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              latitud != null && longitud != null ?
              MarkerLayer(
                markers: [

                    Marker(
                    point: LatLng(latitud!, longitud!),
                    width: 80,
                    height: 80,
                    child: Icon(
                      Icons.location_pin,
                      size: 60,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ): MarkerLayer(markers:[]),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.bottomRight,
              // add your floating action button
              child: FloatingActionButton(
                onPressed: () {
                  //launchUrl(Uri.parse("https://maps.google.com/?q=-34.8964125,-56.1869239&z=18"));
                  launch("https://maps.google.com/?q=${latitud},${longitud}");
                  // launch("http://maps.google.com/maps?q=${latitud},${longitud}&z=20");
                  //launch("https://www.google.com/maps/search/?api=1&query=${latitud}%2C${longitud}&zoom=21");
                },
                backgroundColor: Colors.black54,
                child:
                Icon(FontAwesomeIcons.mapLocationDot, color: Colors.white,),
                /*
                Icon(
                  Icons.navigation_outlined,
                  color: Colors.white,
                ),*/
              ),
            ),
          ),
        ],
      ),
    );
  }
}
