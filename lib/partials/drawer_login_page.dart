import 'package:carup/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../MisServicios.dart';

class DrawerHomePage extends StatelessWidget {
  DrawerHomePage(this.userName);
  final userName;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Image.asset('assets/imgs/color_logo_alpha.png'),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "@${userName}",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text('Servicios Pendientes'),
            onTap: () {
              Navigator.popAndPushNamed(context, 'MisServicios');

            },
          ),
          Divider(),
          ListTile(
            title: Text('Todos los servicios'),
            onTap: () {
              Navigator.popAndPushNamed(context, 'TodosServicios');
            },
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              _logout(context);
            },
          ),
        ],
      ),
    );
  }
}



final storage = FlutterSecureStorage();
Future<void> _logout(BuildContext context) async {
  await storage.delete(
      key: 'username'); // O cualquier otra información guardada

  // Navega de regreso a la pantalla de inicio de sesión
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
}
